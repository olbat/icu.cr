require "./spec_helper"

{% if compare_versions(LibICU::VERSION, "52.0.0") >= 0 %}
describe "ICU::Region" do
  describe "initialize" do
    it "creates a new region from a code" do
      ICU::Region.new("UK").should_not be_nil
    end

    it "creates a new region from a numeric code" do
      ICU::Region.new(150).should_not be_nil
    end
  end

  describe "code" do
    it "returns the canonical code of a region" do
      ICU::Region.new(250).code.should eq("FR")
    end
  end

  describe "numeric_code" do
    it "returns the numeric code of a region" do
      ICU::Region.new("DE").numeric_code.should eq(276)
    end
  end

  describe "==" do
    it "compares two equivalent regions" do
      ICU::Region.new("JP").should eq(ICU::Region.new("JPN"))
    end

    it "compares two different regions" do
      ICU::Region.new("IN").should_not eq(ICU::Region.new("IT"))
    end
  end

  describe "contains?" do
    it "returns true when a region contains another" do
      ICU::Region.new("001").contains?(ICU::Region.new("AS")).should be_true
    end

    it "returns false when a region doesn't contain another" do
      ICU::Region.new("PL").contains?(ICU::Region.new("EU")).should be_false
      ICU::Region.new("PL").contains?(ICU::Region.new("RO")).should be_false
    end
  end

  describe "containing_region" do
    it "returns the containg region" do
      ICU::Region.new("AR").containing_region.should eq(ICU::Region.new(5))
    end
  end

  describe "contained_regions" do
    it "returns the contained regions" do
      regions = ICU::Region.new(21).contained_regions
      regions.map(&.code).should eq(["BM", "CA", "GL", "PM", "US"])
    end
  end
end
{% end %}
