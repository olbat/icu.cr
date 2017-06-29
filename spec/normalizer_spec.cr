require "./spec_helper"

describe "ICU::Normalizer" do
  describe "initialize" do
    it "creates a new Normalizer specifying a type" do
      ICU::Normalizer.new(:NFC).should_not be_nil
    end

    it "creates a new Normalizer using sub-classes" do
      ICU::NFCNormalizer.new.should_not be_nil
      ICU::NFDNormalizer.new.should_not be_nil
      ICU::NFKCNormalizer.new.should_not be_nil
      ICU::NFKDNormalizer.new.should_not be_nil
      ICU::NFKCCFNormalizer.new.should_not be_nil
    end

    it "raises an exception if the given type does not exist" do
      expect_raises do
        ICU::Normalizer.new(:_)
      end
    end
  end

  describe "normalize" do
    it "normalize some not-normalized text" do
      ICU::NFCNormalizer.new.normalize("Àẹ́ñが").should eq("\u00C0" + "\u1EB9\u0301" + "\u00F1" + "\u304C")
    end

    it "don't modify some normalized text" do
      text = "\u00C0" + "\u1EB9\u0301" + "\u00F1" + "\u304C"
      ICU::NFCNormalizer.new.normalize(text).should eq(text)
    end
  end

  describe "normalized?" do
    it "returns false if a text isn't normalized" do
      ICU::NFCNormalizer.new.normalized?("Àẹ́ñが").should be_false
    end

    it "returns true if a text is normalized" do
      norm = ICU::NFCNormalizer.new
      norm.normalized?(norm.normalize("Àẹ́ñが")).should be_true
    end
  end

  describe "normalized_quick?" do
    it "returns CheckResult::Yes if a text is normalized" do
      norm = ICU::NFCNormalizer.new
      norm.normalized_quick?(norm.normalize("é")).should eq(ICU::Normalizer::CheckResult::Yes)
    end

    it "returns CheckResult::No if a text isn't normalized" do
      norm = ICU::NFCNormalizer.new
      norm.normalized_quick?("Àẹ́ñが").should eq(ICU::Normalizer::CheckResult::No)
    end

    it "returns CheckResult::Maybe if a text is maybe normalized" do
      norm = ICU::NFCNormalizer.new
      norm.normalized_quick?(norm.normalize("Àẹ́ñが")).should eq(ICU::Normalizer::CheckResult::Maybe)
    end
  end

  describe "inert?" do
    it "returns true if a character is inert to normalization" do
      ICU::NFDNormalizer.new.inert?('a').should be_true
    end
    it "returns true if a character is sensible to normalization" do
      ICU::NFDNormalizer.new.inert?('à').should be_false
    end
  end

  describe "decomposition" do
    it "returns the decomposition mapping of a character" do
      ICU::NFDNormalizer.new.decomposition('é').should eq("\u0065\u0301")
    end
  end
end

describe "ICU::NFCNormalizer" do
  describe "initialize" do
    it "creates a new NFCNormalizer" do
      ICU::NFCNormalizer.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFC)" do
      ICU::NFCNormalizer.new.normalize("Àẹ́ñが").should eq("\u00C0" + "\u1EB9\u0301" + "\u00F1" + "\u304C")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::NFCNormalizer.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end

describe "ICU::NFDNormalizer" do
  describe "initialize" do
    it "creates a new NFDNormalizer" do
      ICU::NFDNormalizer.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFD)" do
      ICU::NFDNormalizer.new.normalize("Àẹ́ñが").should eq("\u0041\u0300" + "\u0065\u0323\u0301" + "\u006E\u0303" + "\u304B\u3099")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::NFDNormalizer.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end

describe "ICU::NFKCNormalizer" do
  describe "initialize" do
    it "creates a new NFKCNormalizer" do
      ICU::NFKCNormalizer.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFKC)" do
      ICU::NFKCNormalizer.new.normalize("Àẹ́ñが").should eq("\u00C0" + "\u1EB9\u0301" + "\u00F1" + "\u304C")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::NFKCNormalizer.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end

describe "ICU::NFKDNormalizer" do
  describe "initialize" do
    it "creates a new NFKDNormalizer" do
      ICU::NFKDNormalizer.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFKD)" do
      ICU::NFKDNormalizer.new.normalize("Àẹ́ñが").should eq("\u0041\u0300" + "\u0065\u0323\u0301" + "\u006E\u0303" + "\u304B\u3099")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::NFKDNormalizer.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end

describe "ICU::NFKCCFNormalizer" do
  describe "initialize" do
    it "creates a new NFKCCFNormalizer" do
      ICU::NFKCCFNormalizer.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFKCCF)" do
      ICU::NFKCCFNormalizer.new.normalize("Àẹ́ñが").should eq("\u00E0" + "\u1EB9\u0301" + "\u00F1" + "\u304C")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::NFKCCFNormalizer.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end
