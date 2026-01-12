module Potter
  module AST
    class Variable < Node
      attr_reader :name

      def initialize(name)
        @name = name
      end
    end
  end
end
