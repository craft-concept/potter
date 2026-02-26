if defined? ::ActiveRecord::ConnectionAdapters::SQLite3
  class ::ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition
    unless method_defined? :jsonb
      def jsonb(name)
        blob name
        check_constraint %{json_valid(#{name}, 6)}, name: "#{name}_valid_json"
      end
    end

    unless method_defined? :json
      def json(name)
        text name
        check_constraint %{json_valid(#{name}, 6)}, name: "#{name}_valid_json"
      end
    end
  end
end
