require_relative "base"
require_relative "../commons/mod11"

module BrDocuments
  module IE
    class Pattern2 < Base
      include Commons::Mod11

      def initialize(number)
        super
        @weight1 = [4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        @weight2 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
      end

      private
      def valid_format?
        regex = @mask
        regex.match(@number).present?
      end

      def valid_digital_check?
        @number.gsub!(/[\.\/-]/, "")

        digital_check1 = generate_digital_check(@number, @weight1)
        digital_check2 = generate_digital_check(@number, @weight2)

        @number[-2, 2].eql? "#{digital_check1}#{digital_check2}"
      end
    end
  end
end
