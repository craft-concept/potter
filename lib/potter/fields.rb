module Potter
  concern :Fields do
    included do
      class_attribute :fields, default: {}
    end

    def initialize(**attrs)

      attrs.each do |name, value|
        instance_variable_set("@#{name}", fields[name.to_sym].new(value))
      end
    end

    class_methods do
      def Field(...) = Field.of(...)

      def const_added(const)
        super
        klass = const_get(const)
        return unless klass.is_a?(Class) and klass < Field
        name = const.to_s.underscore.to_sym
        self.fields = fields.merge(name => klass)
        attr_accessor name
      end

      def field(type, name, **, &)
        define_class(name, Field(type), &)
      end

      def default(**)
      end

      def date(...)    = field(Date,    ...)
      def float(...)   = field(Float,   ...)
      def boolean(...) = field(Boolean, ...)
      def string(...)  = field(String,  ...)
      def decimal(...) = field(Decimal, ...)

      def bool(...) = boolean(...)
    end
  end
end
