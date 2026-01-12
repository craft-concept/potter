# frozen_string_literal: true

require "zeitwerk"
require "active_support"
require "active_support/core_ext"
require "potter/core_ext"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("ast" => "AST", "dsl" => "DSL")
loader.setup

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
