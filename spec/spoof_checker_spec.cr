require "./spec_helper"

describe "ICU::SpoofChecker" do
  describe "initialize" do
    it "creates a new spoof checker" do
      ICU::SpoofChecker.new.should_not be_nil
    end
  end

  describe "checks" do
    it "returns a default non-zero value" do
      ICU::SpoofChecker.new.checks.should_not eq(0)
    end

    it "round-trips via checks=" do
      sc = ICU::SpoofChecker.new
      sc.checks = ICU::SpoofChecker::Check::Invisible.to_i32
      sc.checks.should eq(ICU::SpoofChecker::Check::Invisible.to_i32)
    end

    it "accepts combined flags" do
      sc = ICU::SpoofChecker.new
      flags = (ICU::SpoofChecker::Check::Invisible | ICU::SpoofChecker::Check::MixedNumbers).to_i32
      sc.checks = flags
      sc.checks.should eq(flags)
    end
  end

  describe "restriction_level" do
    it "returns a valid restriction level" do
      ICU::SpoofChecker.new.restriction_level.should_not be_nil
    end

    it "round-trips via restriction_level=" do
      sc = ICU::SpoofChecker.new
      sc.restriction_level = ICU::SpoofChecker::RestrictionLevel::HighlyRestrictive
      sc.restriction_level.should eq(ICU::SpoofChecker::RestrictionLevel::HighlyRestrictive)
    end
  end

  describe "allowed_locales" do
    it "returns an empty string by default" do
      ICU::SpoofChecker.new.allowed_locales.should eq("")
    end

    it "round-trips via allowed_locales=" do
      sc = ICU::SpoofChecker.new
      sc.allowed_locales = "en"
      sc.allowed_locales.should eq("en")
    end
  end

  describe "check" do
    it "returns 0 for a safe ASCII string" do
      sc = ICU::SpoofChecker.new
      sc.checks = ICU::SpoofChecker::Check::RestrictionLevel.to_i32
      sc.check("hello").should eq(0)
    end

    it "returns non-zero for a mixed-script string" do
      sc = ICU::SpoofChecker.new
      sc.checks = ICU::SpoofChecker::Check::RestrictionLevel.to_i32
      # Contains the Cyrillic "е" mixed with Latin characters
      sc.check("hеllo").should_not eq(0)
    end

    it "populates a CheckResult with restriction level" do
      sc = ICU::SpoofChecker.new
      sc.checks = ICU::SpoofChecker::Check::RestrictionLevel.to_i32
      result = ICU::SpoofChecker::CheckResult.new
      sc.check("hello", result)
      result.restriction_level.should eq(ICU::SpoofChecker::RestrictionLevel::Ascii)
    end

    it "returns non-zero in CheckResult for a failing string" do
      sc = ICU::SpoofChecker.new
      sc.checks = ICU::SpoofChecker::Check::RestrictionLevel.to_i32
      result = ICU::SpoofChecker::CheckResult.new
      ret = sc.check("hеllo", result)
      ret.should_not eq(0)
      result.checks.should_not eq(0)
    end
  end

  describe "safe?" do
    it "returns true for a safe ASCII string" do
      sc = ICU::SpoofChecker.new
      sc.checks = ICU::SpoofChecker::Check::RestrictionLevel.to_i32
      sc.safe?("hello").should be_true
    end

    it "returns false for a mixed-script string" do
      sc = ICU::SpoofChecker.new
      sc.checks = ICU::SpoofChecker::Check::RestrictionLevel.to_i32
      sc.safe?("hеllo").should be_false
    end
  end

  describe "confusable?" do
    it "returns true for visually confusable strings" do
      sc = ICU::SpoofChecker.new
      # "рaypal" uses Cyrillic "р" in place of Latin "p"
      sc.confusable?("paypal", "рaypal").should be_true
    end

    it "returns false for clearly distinct strings" do
      sc = ICU::SpoofChecker.new
      sc.confusable?("hello", "world").should be_false
    end
  end

  describe "bidi_confusable?" do
    it "returns a boolean result" do
      sc = ICU::SpoofChecker.new
      result = sc.bidi_confusable?("hello", "world", ICU::SpoofChecker::Direction::Ltr)
      result.should be_a(Bool)
    end
  end

  describe "skeleton" do
    it "returns a non-empty string" do
      sc = ICU::SpoofChecker.new
      sc.skeleton("hello").should_not be_empty
    end

    it "produces equal skeletons for confusable strings" do
      sc = ICU::SpoofChecker.new
      sc.skeleton("paypal").should eq(sc.skeleton("рaypal"))
    end

    it "produces different skeletons for non-confusable strings" do
      sc = ICU::SpoofChecker.new
      sc.skeleton("hello").should_not eq(sc.skeleton("world"))
    end
  end

  describe "bidi_skeleton" do
    it "returns a non-empty string" do
      sc = ICU::SpoofChecker.new
      sc.bidi_skeleton("hello", ICU::SpoofChecker::Direction::Ltr).should_not be_empty
    end
  end

  describe ".inclusion_set" do
    it "returns a non-empty set of characters" do
      ICU::SpoofChecker.inclusion_set.should_not be_empty
    end

    it "returns a Set(Char)" do
      ICU::SpoofChecker.inclusion_set.should be_a(Set(Char))
    end
  end

  describe ".recommended_set" do
    it "returns a non-empty set of characters" do
      ICU::SpoofChecker.recommended_set.should_not be_empty
    end

    it "returns a Set(Char)" do
      ICU::SpoofChecker.recommended_set.should be_a(Set(Char))
    end

    it "includes common ASCII letters" do
      ICU::SpoofChecker.recommended_set.includes?('a').should be_true
    end
  end

  describe "CheckResult" do
    it "creates a check result" do
      ICU::SpoofChecker::CheckResult.new.should_not be_nil
    end

    it "returns checks bitmask" do
      result = ICU::SpoofChecker::CheckResult.new
      ICU::SpoofChecker.new.check("hello", result)
      result.checks.should be_a(Int32)
    end

    it "returns numerics as Set(Char)" do
      result = ICU::SpoofChecker::CheckResult.new
      sc = ICU::SpoofChecker.new
      sc.checks = ICU::SpoofChecker::Check::MixedNumbers.to_i32
      sc.check("hello", result)
      result.numerics.should be_a(Set(Char))
    end
  end
end
