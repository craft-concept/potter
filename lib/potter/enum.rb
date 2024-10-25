module Potter
  module Enum
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def next_id  = @prev_id ? @prev_id + 1 : 0

      def const(name, id = next_id, description: nil)
        @prev_id = id
        const_set(name, id)
      end

      def cast(value)
        case value
        when Integer
          new(value)
        when Symbol, String
          const_get(value)
        end
      end
    end

    @enums = {}
    def self.of(type)
      parent = self

      @enums[type] ||=
         Class.new(type) do
          puts "name: #{type.name}"
          include parent
        end
    end
  end

  def self.Enum(type) = Enum.of(type)
end
