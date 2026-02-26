require "test_helper"

class PotterTest < Minitest::Test
  def test_that_it_has_a_version_number
    assert ::Potter::VERSION
  end

  def test_eager_load
    begin
      Potter::LOADER.eager_load(force: true)
    rescue Zeitwerk::NameError => e
      flunk e.message
    else
      assert Potter::LOADER
    end
  end
end
