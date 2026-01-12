module Potter
  module Migrations
    extend ActiveSupport::Concern

    class_methods do
      def migration
        Class.new(ActiveRecord::Migration[8.0]) do
          create_table :requests do |t|
            fields.each do |field|
              field.migrate(t)
            end
          end
        end
      end
    end
  end
end
