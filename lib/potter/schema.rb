require "active_model"

module Potter
  module Schema
    extend ActiveSupport::Concern

    include ActiveModel::Attributes

    Type = ActiveRecord::Type
    module Type
      class Symbol < ImmutableString
        def type
          :symbol
        end

        private

        def cast_value(value)
          case value
          when true then @true
          when false then @false
          else value.to_sym
          end
        end
      end

      register(:symbol, Symbol)
    end

    included do
      class_attribute :fields, default: {}
      class_attribute :indexes, default: []
    end

    class_methods do
      def array(*, **, &) = field(*, array: true, **, &)

      def bigint(...)   = field(Type::BigInteger, ...)
      def binary(...)   = field(Type::Binary, ...)
      def boolean(...)  = field(Type::Boolean, ...)
      def date(...)     = field(Type::Date, ...)
      def datetime(...) = field(Type::DateTime, ...)
      def decimal(...)  = field(Type::Decimal, ...)
      def float(...)    = field(Type::Float, ...)
      def integer(...)  = field(Type::Integer, ...)
      def json(...)     = field(Type::Json, ...)
      def symbol(...)   = field(Type::Symbol, ...)
      def string(...)   = field(Type::String, ...)
      def text(...)     = field(Type::Text, ...)
      def time(...)     = field(Type::Time, ...)

      alias bool        boolean
      alias int         integer
      alias sym         symbol
      alias big_integer bigint
      alias date_time   datetime

      def strings(...) = array(Type::String, ...)

      def field(type, name, **)
        f = Field.new(type:, name:, **)
        self.fields = fields.merge(name => f)
        f.record!(self)
      end

      def default(**keys)
        keys.each do |key, default|
          fields[key].default = default
          fields[key].record!(self)
        end
      end

      def index(*indexes, unique: false)
        self.indexes |= indexes.map { {fields: [*_1], unique:} }
      end
    end
  end
end
