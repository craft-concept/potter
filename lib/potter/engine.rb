require "rails"

module Potter
  class Engine < ::Rails::Engine
    # config.autoload_paths += paths["lib"].to_a

    initializer "potter.inflections" do
      ActiveSupport::Inflector.inflections do |i|
        i.acronym "AST"
        i.acronym "DSL"
        i.acronym "CSV"
      end
    end
  end
end
