# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "potter"

require "minitest/autorun"

module Minitest::Assertions
  def assert_eql exp, act, msg = nil
    msg = message(msg) { "#{exp.hash} <=> #{act.hash}\n" + diff(exp, act) }
    assert exp.eql?(act), msg
  end
end
