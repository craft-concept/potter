module Potter
  module AST
    class Node
      def symbol = SYMBOL
      def name   = NAME

      def visit(visitor)
        visitor.try(name, self)
      end

      def hash = [self.class, *instance_variable_values].hash

      def eql?(o)
        hash == o.hash
      end
    end

    def self.define_node(const, parent = Node, symbol: nil, name: const.underscore, &)
      define_class(const, parent) do
        const_set(:SYMBOL, symbol) if symbol
        const_set(:NAME,   name)   if name
        class_exec(&) if block_given?
        klass = self

        if name
          Node.define_method(name)  {|*args| Proxy klass.new(self, *args.map { Node _1 }) }
          DSL.define_singleton_method(name)   {|*args| klass.new(*args.map { Node _1 }) }
          Proxy.define_method(name) {|*args| Proxy klass.new(@node, *args.map { Node _1 }) }
        end

        if symbol
          Proxy.define_method(symbol) {|*args| Proxy klass.new(@node, *args.map { Node _1 }) }
        end
      end
    end
  end
end
