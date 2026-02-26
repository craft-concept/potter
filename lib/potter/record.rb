module Potter
  module Record
    extend ActiveSupport::Concern

    include Migrations
    include Schema

    included do
      scope :newest, -> { order(created_at: :desc) }
      scope :oldest, -> { order(created_at: :asc) }
      delegate :secret, to: :class
    end

    class_methods do
      def secret(*keys)
        scope = module_parent_name.underscore.split("/")
        Rails.application.credentials.dig(*scope, *keys)
      end

      def normalizes(*, keys: nil, values: nil, with: :itself, **)
        with = with.to_proc
        with >>= -> { _1.compact.stringify_keys.transform_keys(&keys).sort.to_h } if keys
        with >>= -> { _1.transform_values(&values) } if values

        super(*, with:, **)
      end

      def merged_scope(name, block)
        scope name, ->(value) {
          value
            .with_defaults(where_values_hash[name.to_s] || {})
            .compact.sort.to_h
            .then { instance_exec(_1, &block) }
        }
      end

      def joined_scope(name, sep, block)
        scope name, ->(*value) {
          [*where_values_hash[name.to_s], *value]
            .join(sep)
            .then { instance_exec(_1, &block) }
        }
      end
    end
  end
end
