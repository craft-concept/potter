require "net/http"

module Potter
  class Request < ActiveRecord::Base
    include Record

    # class Method < Enum(String)
    #   const :GET, :POST, :PUT, :PATCH, :HEAD, :DELETE, :OPTIONS, :TRACE, :CONNECT
    # end


    enum :state, %w[received queued sending responded failed].to_h { [ _1, _1 ] }, default: "sending"
    enum :http_method, %w[get post put patch head delete options trace connect].to_h { [ _1, _1 ] }, prefix: :http, default: "get"

    attribute :path, default: ""
    attribute :params,  ActiveRecord::Type::Json.new, default: {}
    attribute :headers, ActiveRecord::Type::Json.new, default: {}

    normalizes :headers, keys: :parameterize

    belongs_to :response, optional: true

    validates :root,        presence: true
    validates :state,       presence: true
    validates :http_method, presence: true

    scope :get,   -> { http_get }
    scope :post,  -> { http_post }
    scope :patch, -> { http_patch }
    scope :put,   -> { http_put }
    scope :head,  -> { http_head }

    scope :root, ->(root) { where(root:) }
    scope :body, ->(body) { where(body:) }

    joined_scope :path, "/", ->(path)    { where(path:) }
    merged_scope :params,    ->(params)  { where(params:) }
    merged_scope :headers,   ->(headers) { where(headers:) }

    after_commit :perform, if: :sending?

    def header(name) = self[:headers][name.to_s.downcase.gsub(/_/, "-")]

    def query = URI.encode_www_form(params)
    def url   = root + path
    def uri   = URI(url).tap { _1.query = query }

    def body_for_request = body_for_database
    def request_class = Net::HTTP.const_get(http_method.capitalize)

    def request
      @request ||=
        request_class.new(uri, headers).tap do |req|
          req.body = body_for_request if req.request_body_permitted?
        end
    end

    def http
      @http ||=
        Net::HTTP.new(uri.hostname, uri.port).tap do |http|
          http.use_ssl = uri.is_a?(URI::HTTPS)
        end
    end

    def self.response! = sending.create!.response

    def self.root(root)
      default_scope -> { create_with(root:) }
    end

    def self.header(headers)
      default_scope -> { create_with(headers:) }
    end

    def self.param(params)
      default_scope -> { create_with(params:) }
    end

    def self.inherited(subclass)
      super
      subclass.belongs_to :response, optional: true
    end

    private

    def record_response(res)
      build_response status:  res.code,
                     headers: res.to_hash,
                     body:    res.body
    end

    def perform
      res = http.start { http.request(request) }
      record_response(res)
      responded!
    rescue
      failed!
      raise
    end
  end
end
