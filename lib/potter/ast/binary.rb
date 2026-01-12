require_relative "node"
require_relative "proxy"

module Potter
  module AST
    class Binary < Node
      def initialize(left, right)
        super
        @left  = left
        @right = right
      end

      def walk
        yield @left
        yield @right
      end
    end

    def self.Binary(symbol, name)
      Node(Binary, symbol:, name:)
    end

    EqualTo        = Binary(:==, :eq)
    GreaterThan    = Binary(:>,  :gt)
    GreaterOrEqual = Binary(:>=, :gte)
    LessThan       = Binary(:<,  :lt)
    LessOrEqual    = Binary(:<=, :lte)

    And   = Binary(:&, :and)
    Or    = Binary(:|, :or)
    Plus  = Binary(:+, :plus)
    Minus = Binary(:-, :minus)
    Times = Binary(:*, :times)

    Range = Binary(:"..", :range)
  end
end
