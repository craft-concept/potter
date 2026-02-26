require_relative "node"

module Potter
  module AST
    class Unary < Node
      attr_reader :child

      def initialize(child)
        super()
        @child = child
      end

      def eval = public_send(symbol)
    end

    def self.define_unary(const, symbol)
      define_node(const, Unary, symbol:)
    end

    define_unary :Not, :!@
    define_unary :Negate, :-@
  end
end
