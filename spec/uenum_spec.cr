require "./spec_helper"

describe "ICU::UEnum" do
  describe "initialize" do
    it "creates a new uenum" do
      elements = ["foo", "bar", "baz"]
      uenum = ICU::UEnum.new(elements)
      uenum.size.should eq(elements.size)
    end
  end

  describe "each" do
    it "iterates over the elements" do
      elements = ["foo", "bar", "baz"]
      uenum = ICU::UEnum.new(elements)
      uenum.to_a.should eq(elements)
    end
  end
end
