module Potter
  module AST
    def self.value(x) = Value.new(x)
    def self.var(x)   = Variable.new(x)
  end
end
