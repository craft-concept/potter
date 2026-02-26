module Potter
  class ASTTest < Minitest::Test
    def test_ast_basics
      assert AST.value(1)
      assert AST.var(:x)
    end
  end
end
