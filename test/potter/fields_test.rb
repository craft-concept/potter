module Potter
  class FieldsTest < Minitest::Test
    class Animal
      include Potter::Fields

      field Types::Integer, :legs
    end

    class Person < Animal
      default legs: 2

      string :name
    end

    def test_fields_hash
      assert Animal.fields[:legs]
      assert Person.fields[:name]
    end
  end
end
