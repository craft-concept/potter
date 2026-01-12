module Potter
  concern :Field do
    include Transformers
    # option :description
    # option :required?
    # option :index?

    # def optional? = !required?

    def migrate(t)
      t.public_send to_sym, name, null: optional?, index: index?
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

  Field.of(::String)
end
