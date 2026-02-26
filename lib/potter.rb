# frozen_string_literal: true

require "zeitwerk"
require "active_support"
require "active_support/core_ext"
require "cnc/core_ext"
require "potter/core_ext"

if defined? ::Rails
  require "potter/engine"
else
  loader = Zeitwerk::Loader.for_gem
  loader.inflector.inflect("ast" => "AST", "dsl" => "DSL")
  loader.ignore("#{__dir__}/potter/core_ext.rb")
  loader.ignore("#{__dir__}/potter/core_ext")
  loader.setup
end

module Potter
  class Error < StandardError; end

  def self.Field(...) = Field.of(...)
  def self.Enum(...) = Enum.of(...)

  def self.root = Pathname.new(__dir__).dirname

  def self.migrate!
    ActiveRecord::MigrationContext.new([root / "db/migrate"]).up
  end

  def self.database(name)
    require "active_record"
    ENV['DATABASE_URL'] = "sqlite:///#{ENV['HOME']}/.config/#{name}/development.sqlite3"
  end
end
