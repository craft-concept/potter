module Potter
  module AST
    class Value < Node
      attr_reader :value

      def initialize(value)
        @value = value
      end
    end
  end
end
