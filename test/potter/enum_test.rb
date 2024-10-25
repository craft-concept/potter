# frozen_string_literal: true

require "test_helper"
require "potter/enum"

class Potter::EnumTest < Minitest::Test
  def test_can_be_defined
    assert_instance_of Class, Potter::Enum.of(Integer)
  end
end
