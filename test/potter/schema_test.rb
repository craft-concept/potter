require "test_helper"

module Potter
  class SchemaTest < Minitest::Test
    class Animal
      include Schema

      integer :legs
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
