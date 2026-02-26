require "potter/ast/binary"
require "potter/ast/dsl"
require "potter/ast/proxy"
require "potter/ast/unary"
require "potter/ast/value"
require "potter/ast/variable"

module Potter
  module AST
    module_function

    def Proxy(o)
      o.is_a?(Proxy) ? o : Proxy.new(Node o)
    end

    def Value(o)
      o.is_a?(Value) ? o : Value.new(o)
    end

    def Node(o)
      o.is_a?(Node) ? o : Value.new(o)
    end

    def Variable(o)
      o.is_a?(Variable) ? o : Variable.new(o)
    end

    def proxy(o) = Proxy(o)
    def value(o) = Value(o)
    def var(o)   = Variable(o)
  end
end
