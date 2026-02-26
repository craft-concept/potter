module Potter
  module Model
    extend ActiveSupport::Concern

    include Schema
    include Collections
    include Transformers
    include CSV

    included do
      from Array do |values|
        assign values.zip(fields.keys).to_h(&:reverse)
      end
    end
  end
end
