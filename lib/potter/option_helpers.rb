module Potter
  module OptionHelpers
    extend ActiveSupport::Concern

    included do
      class_attribute :options, default: {}, instance_accessor: false, instance_predicate: false
    end

    def assign_options!(**)
      @options ||= {**}
      self.class.options.each { assign_option!(_1, **_2) }
    end

    def assign_option!(k, default:, block:)
      value = @options.delete(k) { default.respond_to?(:call) ? instance_exec(&default) : default.clone }
      instance_variable_set("@#{k}", block.(value))
    end

    class_methods do
      def option(name, proc = -> { _1 }, default: nil, accessor: true, reader: accessor, writer: accessor, predicate: reader, &block)
        block  ||= proc
        reader &&= !name.end_with?(??)
        name     = name.to_s.chomp(??).to_sym

        attr_reader name if reader
        attr_writer name if writer
        define_method("#{name}?") { instance_variable_get("@#{name}").present? } if predicate

        option = {default:, block:}
        self.options = options.merge(name => option)
      end

      def option_accessor(name, proc = -> { _1 }, &block)
        block ||= proc
        define_method(name) { @options[name] }
        define_method("#{name}=") { @options[name] = block.call(_1) }
      end
    end
  end
end
