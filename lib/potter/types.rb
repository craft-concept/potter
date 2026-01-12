module Potter
  module Types
    extend Concern

    def self.get(name)
      name.to_s.camelize.constantize
    end

    class Type
      include OptionHelpers

      attr_reader :name, :options

      option :format

      def initialize(name, **options)
        @name        = name
        @options     = options
        assign_options!
      end

      def name   = self.class.name.split('::').last
      def klass  = Object.const_get(name)
      def to_sym = name.to_sym

      def parse(o)    = klass.new(o)
      def generate(o) = o.to_s
    end

    class Boolean < Type
      def parse(o)
        case o
        when /^\s*(|no|off|0)\s*$/i,
             false, 0, nil
          false
        else true
        end
      end
    end

    class Date    < Type; end
    class Decimal < Type; end
    class Float   < Type; end
    class String  < Type; end
    class Time    < Type; end
  end
end
