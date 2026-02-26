module Potter
  module InformationSchema
    class Index < Base
      self.table_name_prefix = nil
      self.table_name = "pg_indexes"
      self.primary_key = "indexname"
    end
  end
end
