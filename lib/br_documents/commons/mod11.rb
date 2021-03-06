module BrDocuments
  module Commons
    module Mod11

      def generate_digital_check(values, weights)
        sum = reduce_weights(values, weights)
        mod = sum % 11
        mod < 2 ? 0 : (11 - mod)
      end

      def reduce_weights(values, weights)
        sum = 0
        weights.each_index do |i|
          sum += weights[i] * values[i].to_i
        end
        sum
      end
    end
  end
end
