require "./spec_helper"

describe "ICU::Collator" do
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
end
