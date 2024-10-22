module Potter
  module Enum
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def next_id = @last_id ? @last_id += 1 : @last_id = 0

      def const(name, id = next_id, description: nil)
        @last_id = id
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

    def self.of(type)
      parent = self
      name = type.name.gsub("::", "")
      const_get(name) ||
        const_set(type.name.gsub("::", ""), Class.new(type) do
          include parent
        end)
    end
  end

  def self.Enum(type) = Enum.of(type)
end
