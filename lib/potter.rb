# frozen_string_literal: true

require "zeitwerk"
require "active_support/all"
require "potter/core_ext"

module Potter
  class Error < StandardError; end

  LOADER = Zeitwerk::Loader.for_gem.tap do |loader|
    loader.inflector.inflect("ast" => "AST", "dsl" => "DSL", "csv" => "CSV")
    loader.ignore("#{__dir__}/potter/core_ext.rb")
    loader.ignore("#{__dir__}/potter/core_ext")
    loader.setup
  end

  require "potter/engine"

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
