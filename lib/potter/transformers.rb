module Potter
  module Transformers
    extend ActiveSupport::Concern

    def initialize(value = nil)
      self.class.transformers.each do |klass, block|
        if value.is_a? klass
          super(nil)
          value.instance_exec(self, &block)
          return
        end
      end

      super
    end

    def to(klass) = klass.new(self)

    class_methods do
      def transformers = @transformers ||= []

      def from(klass, &block)
        @transformers ||= {}
        @transformers[klass] = block
      end
    end
  end
end
