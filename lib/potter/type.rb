module Potter
  Type = ActiveRecord::Type

  module Type
    class Password < String
      def type = :password
    end

    class Symbol < ImmutableString
      def type = :symbol

      private

      def cast_value(value)
        case value
        when true then @true
        when false then @false
        else value.to_sym
        end
      end
    end

    register(:password, Password)
    register(:symbol, Symbol)
  end
end
