require "test_helper"

class Potter::EnumTest < Minitest::Test
  class MyInteger < Potter.Enum(Integer)
    const :ONE
    const :TWO
  end

  def test_enum_creation
    assert_operator MyInteger, :<, Integer
    assert_operator MyInteger, :<, Potter::Enum
    assert_kind_of Integer, MyInteger::ONE
  end
end
