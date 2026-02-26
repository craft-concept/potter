module Potter
  module Fields
    class Collection < Array
      include Caching

      derive :names,   ->{ map(&:name) }
      derive :by_name, ->{ index_by(&:name) }

      def |(fields)
        self.class.new super.uniq(&:name)
      end

      def [](key) = by_name[key]
    end
  end
end
