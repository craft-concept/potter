module Potter
  concern :Fields do
    included do
      class_attribute :fields, default: Fields::Collection.new
    end

    def initialize(**attrs)
      attrs.each do |name, value|
        instance_variable_set("@#{name}", fields[name.to_sym].new(value))
      end
    end

    class_methods do
      def field(type, name, **, &)
        type = type.new(**, &)
        field = Field.new(name:, type:, declared: true, **type.options)
        self.fields |= [field]
      end

      def default(**)
      end

      def boolean(...) = field(Types::Boolean, ...)
      def date(...)    = field(Types::Date,    ...)
      def decimal(...) = field(Types::Decimal, ...)
      def integer(...) = field(Types::Integer, ...)
      def float(...)   = field(Types::Float,   ...)
      def string(...)  = field(Types::String,  ...)

      alias_method :bool, :boolean
      alias_method :int,  :integer
    end
  end
end
