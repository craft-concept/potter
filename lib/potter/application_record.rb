module Potter
  if defined?(::ApplicationRecord)
    ApplicationRecord = ::ApplicationRecord
  else
    require "active_record"
    class ApplicationRecord < ActiveRecord::Base
      primary_abstract_class
    end
  end
end
