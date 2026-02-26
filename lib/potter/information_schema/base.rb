module Potter
  module InformationSchema
    class Base < ActiveRecord::Base
      # include Potter::Record
      self.abstract_class     = true
      self.table_name_prefix  = "information_schema."
      self.param_delimiter    = "-"
      self.inheritance_column = nil
    end
  end
end
