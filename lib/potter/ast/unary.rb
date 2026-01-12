require_relative "node"

module Potter
  module AST
    class Unary < Node
      attr_reader :child

      def initialize(child)
        super
        @child = child
      end

      def walk
        yield @child
      end
    end

    def self.Unary(symbol, name)
      Node(Unary, symbol:, name:)
    end

    Not    = Unary(:!@, :not)
    Negate = Unary(:-@, :negate)
  end
end
