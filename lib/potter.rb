# frozen_string_literal: true

require_relative "potter/version"
require_relative "potter/endpoints"
require_relative "potter/enum"
require_relative "potter/flag"
require_relative "potter/model"

module Potter
  class Error < StandardError; end
end
