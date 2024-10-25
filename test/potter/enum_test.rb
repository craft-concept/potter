# frozen_string_literal: true

require "test_helper"
require "potter/enum"

class Potter::EnumTest < Minitest::Test
  class MyInteger < Potter.Enum(Integer)
    # const :ONE
    # const :TWO
  end

  def test_enum_creation
    assert MyInteger
    assert MyInteger < Integer
    assert MyInteger < Potter::Enum
    assert MyInteger::ONE.is_a?(Integer)
  end
end
