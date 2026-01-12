module Potter
  concern :Enum do
    include Transformers

    class_methods do
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

    def self.of(type, &)
      const_cache(type) do
        parent = self
        Class.new(type) do
          include parent
          class_exec(&) if block_given?
        end
      end
    end
  end
end
