require "spec_helper"

describe BrDocuments::IE::RO do
  describe "#formatted" do
    context "when having 9 digits" do
      it "returns a formatted ie" do
        ie = BrDocuments::IE::RO.new("123456789")
        expect(ie.formatted).to eq "123.45678-9"
      end
    end

    context "when having 14 digits" do
      it "returns a formatted ie" do
        ie = BrDocuments::IE::RO.new("12345678901234")
        expect(ie.formatted).to eq "1234567890123-4"
      end
    end
  end

  describe "#valid?" do
    it "is invalid with malformed number" do
      ["20.049.788-6", "2.004.978-86", "937.03AB1-6"].each do |number|
        ie = BrDocuments::IE::RO.new(number)
        expect(ie).to_not be_valid
      end
    end

    it "is invalid with length different to 9 or 14" do
      ["1234567", "123456789012", "12345678901234567"].each do |number|
        ie = BrDocuments::IE::RO.new(number)
        expect(ie).to_not be_valid
      end
    end

    context "when having 9 digits" do
      it "is invalid with invalid check number" do
        ie = BrDocuments::IE::RO.new("134725252")
        expect(ie).to_not be_valid
      end

      it "is valid with valid number" do
        ie = BrDocuments::IE::RO.new("101625213")
        expect(ie).to be_valid
      end
    end

    context "when having 14 digits" do
      it "is invalid with invalid check number" do
        ie = BrDocuments::IE::RO.new("02539835229263")
        expect(ie).to_not be_valid
      end

      it "is valid with valid number" do
        ie = BrDocuments::IE::RO.new("00000000625213")
        expect(ie).to be_valid
      end
    end
  end
end
