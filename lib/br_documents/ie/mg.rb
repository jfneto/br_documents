require_relative "base"
require_relative "../commons/mod11"

module BrDocuments
  module IE
    class MG < Base
      include Commons::Mod11

      private
      def format_ie(number)
        number.sub(/(\d{3})(\d{3})(\d{3})(\d{4})/, "\\1.\\2.\\3/\\4")
      end

      def valid_format?
        regex = /^(\d{3}\.\d{3}\.\d{3}\.\d{2}\-\d{2})$|^(\d{13})$/
        regex.match(@number).present?
      end

      def valid_digital_check?
        @number.gsub!(/[\.\/-]/, "")

        number1 = @number[0, 3] + "0" + @number[3..10]
        weight1 = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2]
        digital_check1 = generate_first_digital_check(number1, weight1)

        number2 = "#{@number[0, 11]}#{digital_check1}"
        weight2 = [3, 2, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2]
        digital_check2 = generate_digital_check(number2, weight2)

        @number[-2, 2].eql? "#{digital_check1}#{digital_check2}"
      end

      def generate_first_digital_check(values, weights)
        sum = 0
        weights.each_index do |i|
          number = weights[i] * values[i].to_i
          if number < 10
            sum += number
          else
            sum += number.to_s[0].to_i + number.to_s[1].to_i
          end
        end
        next_dozen(sum) - sum
      end

      def next_dozen(number)
        while number % 10 != 0
          number = number + 1
        end
        number
      end
    end
  end
end
