module Potter
  concern :Caching do
    # def full = cache(:full) { first + last }
    def cache(name, &)
      name = "@#{name}"
      @_cached ||= []
      @_cached << name
      instance_variable_defined?(name) ?
        instance_variable_get(name) :
        instance_variable_set(name, instance_exec(&))
    end

    def clear_cache!
      @_cached.each { remove_instance_variable(_1) }.clear
    end

    class_methods do
      # derive :full, -> { first + last }
      def derive(name, proc = nil, &block)
        proc ||= block
        define_method(name) { cache(name, &proc) }
      end

      # cache! def full = first + last
      def cache!(name)
        prepend Module.new.tap { _1.module_eval <<~RUBY }
          def #{name} = cache(:#{name}) { super }
        RUBY
        name
      end
    end
  end
end
