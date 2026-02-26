module Potter
  class MigrationsTest < Minitest::Test
    require "active_record"
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: ':memory:'
    )

    class Article
      include Schema, Migrations

      string :title
    end

    def test_migration
      assert Article.migration
    end
  end
end
