module Potter
  class Collection < Array
    def self.filter(name, block)
      define_method(name) do |*args|
        filter { _1.instance_exec(*args, &block) }
      end
    end
  end

  module Collections
    extend ActiveSupport::Concern

    class_methods do
      def inherited(child)
        super

        child.class_eval <<-RUBY
          class Collection < Collection
          end
        RUBY
      end

      def filter(...)   = Collection.filter(...)
      def all(arr)      = Collection.new(arr)
      def if(cond, ...) = cond ? instance_exec(cond, ...) : self
      def to(...)       = map { _1.to(...) }
    end
  end
end
