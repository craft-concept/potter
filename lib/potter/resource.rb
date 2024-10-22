module Potter
  class Resource
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
