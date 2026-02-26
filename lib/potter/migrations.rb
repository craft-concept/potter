module Potter
  module Migrations
    extend ActiveSupport::Concern

    class Migration < ActiveRecord::Migration[8.0]
      def initialize(model)
        @model = model
      end

      def column_names
      end

      def create_or_change_table(name, **, &)
        return create_table(name, **, &) unless table_exists?(name)

        change_table(name, **) do |t|
          t.remove_columns(*(t.columns.map(&:name) - %w[id]))
          yield t
        end
      end

      def change
        create_or_change_table(model.table_name) do |t|
          model.fields.each do |f|
            t.column f.name, f.type.to_sym, null: f.optional?
          end
        end
      end
    end

    included do
      unless defined?(table_name)
        def self.table_name = name.tableize
      end
    end

    class_methods do
      def migrate!  = migration.migrate(:up)
      def migration = Migration.new(self)
    end
  end
end
