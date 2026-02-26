module Potter
  module AST
    class Proxy
      attr_reader :node

      def initialize(node)
        @node = node
      end

      def Node(o) = AST.Node(o)
      def Proxy(o) = AST.Proxy(o)
    end
  end
end
