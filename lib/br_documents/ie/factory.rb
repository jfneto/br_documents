module BrDocuments
  module IE
    class Factory
      def self.create(uf, number)
        klass = IE.const_get("#{uf}")
        klass.new(number)
      rescue NameError
        raise(ArgumentError, I18n.t("validator.ie.uf.invalid"))
      end
    end
  end
end
