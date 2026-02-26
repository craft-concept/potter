require "test_helper"

module Potter
  class MigrationsTest < Minitest::Test
    class Article
      include ::Potter::Schema, Migrations

      string :title
    end

    def test_migration
      assert Article.migration
    end
  end
end
