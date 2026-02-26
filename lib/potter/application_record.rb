module Potter
  if defined?(ApplicationRecord)
    ApplicationRecord = ::ApplicationRecord
  else
    class ApplicationRecord < Base
      primary_abstract_class
    end
  end
end
