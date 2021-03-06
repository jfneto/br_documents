require "spec_helper"
require_relative "shared_examples_for_to_remove_all_masks"

describe BrDocuments::IE::SP do
  describe "#formatted" do
    context "when having 12 digits" do
      it "returns a formatted ie" do
        ie = described_class.new("110042490114")
        expect(ie.formatted).to eq "110.042.490.114"
      end
    end

    context "when having 13 digits" do
      it "returns a formatted ie" do
        ie = described_class.new("P011004243002")
        expect(ie.formatted).to eq "P-01100424.3/002"
      end
    end
  end

  describe "#valid?" do
    it "is invalid with malformed number" do
      ["36.9107.395114", "527.08212.8110"].each do |number|
        ie = described_class.new(number)
        expect(ie).to_not be_valid
      end
    end

    it "is invalid with invalid check number" do
      ["110042490113", "110.042.491.114", "P-01100424.4/002"].each do |number|
        ie = described_class.new(number)
        expect(ie).to_not be_valid
      end
    end

    it "is valid with valid number" do
      ["110042490114", "110.042.490.114", "P-01100424.3/002"].each do |number|
        ie = described_class.new(number)
        expect(ie).to be_valid
      end
    end

    include_examples "for to remove all masks", "P-01100424.3/002"
  end
end
