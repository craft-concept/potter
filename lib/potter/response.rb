module Potter
  class Response < ApplicationRecord
    include Record, Caching

    attribute :headers, ActiveRecord::Type::Json.new, default: -> { {} }

    normalizes :headers, with: -> { _1.compact.stringify_keys.transform_keys(&:parameterize).sort.to_h }

    has_many :requests, dependent: :nullify

    scope :status, ->(status) { where(status:) }
    scope :body,   ->(body) { where(body:) }

    merged_scope :headers, ->(headers) { where(headers:) }

    def self.inherited(subclass)
      super
      subclass.has_many :requests, dependent: :nullify
    end
  end
end
