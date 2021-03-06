module BrDocuments
  module IE
    class Base
      def initialize(number)
        @number = number
      end

      def valid?
        valid_format? and valid_digital_check?
      end

      def formatted
        format_ie(@number)
      end
    end
  end
end
