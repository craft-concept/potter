module Potter
  module InformationSchema
    class Table < Base
      self.primary_key = %w[table_schema table_name]
    end
  end
end
