module Potter
  class Transformer
    def initialize(klass)
      @klass   = klass
      @parsers = Hash.new { _1[_2] = [] }
    end

    def parse(type, &block)
      parsers[type] << block
    end

    def from(o)

    end
  end
end
