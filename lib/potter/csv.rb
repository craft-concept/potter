require "csv"

module Potter
  module CSV
    extend ActiveSupport::Concern

    class Table < ::CSV::Table
    end

    class Row < ::CSV::Row
    end

    def to_csv
      Row.new(attributes.keys, attributes.values.map(&:presence))
    end
  end
end
