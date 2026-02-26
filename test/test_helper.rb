# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "active_record"
require "minitest/autorun"
require "potter"

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

Zeitwerk::Loader.eager_load_all

module Minitest::Assertions
  def assert_eql(exp, act, msg = nil)
    msg = message(msg) { "#{exp.hash} <=> #{act.hash}\n" + diff(exp, act) }

    assert exp.eql?(act), msg
  end
end
