module Potter
  module AST
    class Value < Node
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def eval = @value
    end
  end
end
