require_relative "enum"

module Potter
  module Flag
    include Enum

    module ClassMethods
      def next_id = @prev_id ? @prev_id << 1 : 1
    end
  end

  def Flag(type) = Flag.of(type)
end
