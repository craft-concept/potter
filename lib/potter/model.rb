require "active_model"

module Potter
  class Model
    include ActiveModel::Model
    include ActiveModel::Attributes

    class << self
      attr_reader :fields

      def field(name, type, description: nil)
        @fields ||= []
        @fields << Field.new(name:, type:, description:)
      end
    end

    class Field < Struct.new(:name, :type, :description, keyword_init: true)
    end
  end
end
