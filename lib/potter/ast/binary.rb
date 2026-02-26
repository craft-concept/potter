require_relative "node"
require_relative "proxy"

module Potter
  module AST
    class Binary < Node
      def initialize(left, right)
        super()
        @left  = left
        @right = right
      end

      def walk
        yield @left
        yield @right
      end

      def eval = @left.eval.public_send(symbol, @right.eval)
    end

    def self.define_binary(const, symbol, name = const.underscore, &)
      define_node(const, Binary, symbol:, name:, &)
    end

    define_binary :EqualTo,        :==, :eq
    define_binary :GreaterThan,    :>,  :gt
    define_binary :GreaterOrEqual, :>=, :gte
    define_binary :LessThan,       :<,  :lt
    define_binary :LessOrEqual,    :<=, :lte

    define_binary :And,   :&
    define_binary :Or,    :|
    define_binary :Plus,  :+
    define_binary :Minus, :-
    define_binary :Times, :*
    define_binary :Range, :".."
  end
end
