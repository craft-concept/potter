require "test_helper"

module Potter
  module AST
    class ProxyTest < Minitest::Test
      def test_proxy_basics
        assert_eql DSL.plus(1, 2), (AST.proxy(1) + 2).node
        assert_eql DSL.minus(DSL.plus(1, 2), 3), (AST.proxy(1) + 2 - 3).node
        assert_eql DSL.eq(1, 3), (AST.proxy(1) == 3).node
      end
    end
  end
end
