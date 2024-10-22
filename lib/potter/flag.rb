require_relative "enum"

module Potter
  module Flag
    include Enum

    module ClassMethods
      def next_id = @last_id ? @last_id <<= 1 : @last_id = 1
    end
  end

  def Flag(type) = Flag.of(type)
end
