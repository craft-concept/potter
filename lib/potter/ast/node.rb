module Potter
  module AST
    class Node
      def symbol = SYMBOL
      def name   = NAME
    end

    def self.Node(parent, symbol: nil, name: nil)
      klass = Class.new(parent) do
        const_set(:SYMBOL, symbol) if symbol
        const_set(:NAME,   name)   if name
      end

      Node.define_method(name)    { |*args| klass.new(self, *args) }
      Proxy.define_method(symbol) { |*args| klass.new(value, *args) }
      DSL.define_method(name)     { |*args| klass.new(*args) }

      klass
    end
  end
end
