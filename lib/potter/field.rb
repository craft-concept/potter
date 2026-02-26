module Potter
  class Field
    include OptionHelpers

    option :name, &:to_sym
    option :type, -> { _1.is_a?(Class) ? _1.new : _1 }
    option :default

    option :enum
    option :validates
    option :normalizes

    option :persist?, default: true
    option :required?, default: -> { default.nil? }
    option :declared?
    option :description

    def initialize(**)
      assign_options!(**)
    end

    def optional? = !required?

    def string? = type.type == :string

    def record!(klass)
      klass.attribute(name, type, default:)
      klass.normalizes(name, **normalizes) if normalizes?
      klass.validates(name, **validates) if validates?
      klass.enum(name, enum) if enum?
      self
    end
  end
end
