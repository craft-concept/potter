module Potter
  concern :Types do
    def self.get(name)
      name.to_s.camelize.constantize
    end
  end

  module Types
    class Type
      include OptionHelpers

      attr_reader :options

      def initialize(**)
        assign_options!(**)
      end

      def name   = self.class.name.split('::').last
      def klass  = Object.const_get(name)
      def to_sym = name.underscore.to_sym

      def from(o)
        case o
        when klass  then o
        when String then parse(o)
        else new(o)
        end
      end

      def new(o)      = klass.new(o)
      def parse(o)    = klass.parse(o)
      def generate(o) = o.to_s
    end

    class Boolean < Type
      def parse(o)
        case o
        when /^\s*(|no|off|0+)\s*$/i,
              false, 0, nil
          false
        else true
        end
      end
    end

    class Date < Type
      option :format
    end

    class DateTime < Type
      option :format
    end

    class Decimal < Type
      option :precision # Number of significant digits.
      option :scale     # Number of digits after the decimal.
    end

    class Float   < Type; end
    class Integer < Type
      def parse(o) = o.to_i
    end
    class String  < Type; end
    class Time    < Type; end
  end
end
