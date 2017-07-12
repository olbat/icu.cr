require "./spec_helper"

describe "ICU::Collator" do
  describe "LOCALES" do
    it "lists available locales" do
      ICU::Collator::LOCALES.includes?("en").should be_true
    end
  end

  describe "KEYWORDS" do
    it "lists available keywords" do
      ICU::Collator::KEYWORDS["collation"]?.should_not be_nil
      ICU::Collator::KEYWORDS["collation"].includes?("standard").should be_true
    end
  end

  describe "initialize" do
    it "creates a new Collator without specifying a locale" do
      ICU::Collator.new.should_not be_nil
    end

    it "creates a new Collator specifying a locale" do
      ICU::Collator.new("en_US").should_not be_nil
    end

    it "creates a new Collator using custom rules" do
      ICU::Collator.new("&b < a".to_uchars).should_not be_nil
    end

    it "raises an exception if the given locale does not exist" do
      expect_raises do
        ICU::Collator.new("not_a_locale")
      end
    end
  end

  describe "functional_equivalent" do
    it "returns a functional equivalent to a given locale" do
      ICU::Collator.functional_equivalent("en").should eq("root")
    end
  end

  describe "compare" do
    it "compares two strings and return their order depending on the locale" do
      col = ICU::Collator.new("en")
      col.compare("abc", "abd").should eq(-1)
      col.compare("abc", "abc").should eq(0)
      col.compare("abd", "abc").should eq(1)

      # examples from http://userguide.icu-project.org/collation
      col.compare("y", "i").should eq(1)
      col.compare("y", "k").should eq(1)
      col.compare("c", "ch").should eq(-1)

      col = ICU::Collator.new("lt")
      col.compare("y", "i").should eq(1)
      col.compare("y", "k").should eq(-1)

      col = ICU::Collator.new("fr")
      col.compare("côte", "coté").should eq(-1)

      col = ICU::Collator.new("es")
      col.compare("ch", "c").should eq(0)
      col.compare("ch", "d").should eq(-1)
    end

    it "compares two strings and return their order depending on custom rules" do
      col = ICU::Collator.new("&c < b < a".to_uchars)
      col.compare("a", "b").should eq(1)
      col.compare("b", "c").should eq(1)
      col.compare("d", "e").should eq(-1)
      col.compare("abb", "abc").should eq(1)
      col.compare("abd", "abe").should eq(-1)
    end
  end

  describe "equals?" do
    it "returns true when two strings are equal" do
      col = ICU::Collator.new("en")
      col.equals?("a", "a").should be_true
      col.equals?("abc", "abc").should be_true
    end

    it "returns false when two strings arent equal" do
      col = ICU::Collator.new("en")
      col.equals?("a", "b").should be_false
      col.equals?("abc", "abd").should be_false
    end
  end

  describe "[]" do
    it "returns the value of the specified attribute" do
      nm = ICU::Collator::ON
      col = ICU::Collator.new("&c < b < a".to_uchars, nm)
      col[ICU::Collator::Attribute::NormalizationMode].should eq(nm)
    end
  end

  describe "[]=" do
    it "set a value to the specified attribute" do
      col = ICU::Collator.new("&c < b < a".to_uchars, ICU::Collator::ON)
      nm = ICU::Collator::OFF
      col[ICU::Collator::Attribute::NormalizationMode] = nm
      col[ICU::Collator::Attribute::NormalizationMode].should eq(nm)
    end
  end

  describe "strength" do
    it "returns the strength" do
      str = ICU::Collator::Strength::Secondary
      col = ICU::Collator.new("&c < b < a".to_uchars, strength: str)
      col.strength.should eq(str)
      col.strength.should eq(col[ICU::Collator::Attribute::Strength])
    end
  end

  describe "strength=" do
    it "set the strength" do
      col = ICU::Collator.new("&c < b < a".to_uchars, strength: ICU::Collator::Strength::Tertiary)
      str = ICU::Collator::Strength::Secondary
      col.strength = str
      col.strength.should eq(str)
    end
  end

  describe "reorder_codes" do
    it "returns the reorder codes" do
      col = ICU::Collator.new
      rc = [ICU::Collator::ReorderCode::ReorderCodeSymbol]
      col.reorder_codes = rc
      col.reorder_codes.should eq(rc)
    end

    it "returns an empty array if no reorder codes were set" do
      col = ICU::Collator.new
      col.reorder_codes.should_not be_nil
      col.reorder_codes.empty?.should be_true
    end
  end

  describe "reorder_codes=" do
    it "set the reorder codes" do
      col = ICU::Collator.new
      rc = [
        ICU::Collator::ReorderCode::ReorderCodePunctuation,
        ICU::Collator::ReorderCode::ReorderCodeSymbol,
      ]
      col.reorder_codes = rc
      col.reorder_codes.should eq(rc)
    end
  end
end
