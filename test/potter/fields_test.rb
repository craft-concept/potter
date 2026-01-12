require "test_helper"

class Potter::FieldsTest < Minitest::Test
  class Animal
    include Potter::Fields

    class Legs < Field(Integer); end
  end

  class Person < Animal
    default legs: 2

    string :name
  end

  def test_field_class
    assert Animal::Legs
    assert Person::Name
  end

  def test_fields_reader
    assert_equal({legs: Animal::Legs}, Animal.fields)
    assert_equal({legs: Animal::Legs, name: Person::Name}, Person.fields)
  end
end
