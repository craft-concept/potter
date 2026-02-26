require "test_helper"

module Potter
  class TypesTest < Minitest::Test
    def test_type_class
      assert Types::Integer.new
    end

    def test_parsing
      assert_equal 10, Types::Integer.new.parse("10")
    end
  end
end
