require "active_model"
require "potter/collections"
require "potter/csv"
require "potter/fields"
require "potter/transformers"

module Potter
  module Model
    extend ActiveSupport::Concern

    include Fields
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
