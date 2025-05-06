require "./spec_helper"

describe "ICU::Normalizer" do
  describe "initialize" do
    it "creates a new Normalizer specifying a type" do
      ICU::Normalizer.new(:NFC).should_not be_nil
    end

    it "creates a new Normalizer using sub-classes" do
      ICU::Normalizer::NFC.new.should_not be_nil
      ICU::Normalizer::NFD.new.should_not be_nil
      ICU::Normalizer::NFKC.new.should_not be_nil
      ICU::Normalizer::NFKD.new.should_not be_nil
      ICU::Normalizer::NFKCCF.new.should_not be_nil
    end

    it "raises an exception if the given type does not exist" do
      expect_raises(ICU::Error) do
        ICU::Normalizer.new(:_)
      end
    end
  end

  describe "normalize" do
    it "normalize some not-normalized text" do
      ICU::Normalizer::NFC.new.normalize("Àẹ́ñが").should eq("\u00C0" + "\u1EB9\u0301" + "\u00F1" + "\u304C")
    end

    it "don't modify some normalized text" do
      text = "\u00C0" + "\u1EB9\u0301" + "\u00F1" + "\u304C"
      ICU::Normalizer::NFC.new.normalize(text).should eq(text)
    end
  end

  describe "normalized?" do
    it "returns false if a text isn't normalized" do
      ICU::Normalizer::NFC.new.normalized?("Àẹ́ñが").should be_false
    end

    it "returns true if a text is normalized" do
      norm = ICU::Normalizer::NFC.new
      norm.normalized?(norm.normalize("Àẹ́ñが")).should be_true
    end
  end

  describe "normalized_quick?" do
    it "returns CheckResult::Yes if a text is normalized" do
      norm = ICU::Normalizer::NFC.new
      norm.normalized_quick?(norm.normalize("é")).should eq(ICU::Normalizer::CheckResult::Yes)
    end

    it "returns CheckResult::No if a text isn't normalized" do
      norm = ICU::Normalizer::NFC.new
      norm.normalized_quick?("Àẹ́ñが").should eq(ICU::Normalizer::CheckResult::No)
    end

    it "returns CheckResult::Maybe if a text is maybe normalized" do
      norm = ICU::Normalizer::NFC.new
      norm.normalized_quick?(norm.normalize("Àẹ́ñが")).should eq(ICU::Normalizer::CheckResult::Maybe)
    end
  end

  describe "inert?" do
    it "returns true if a character is inert to normalization" do
      ICU::Normalizer::NFD.new.inert?('a').should be_true
    end
    it "returns true if a character is sensible to normalization" do
      ICU::Normalizer::NFD.new.inert?('à').should be_false
    end
  end

  describe "decomposition" do
    it "returns the decomposition mapping of a character" do
      ICU::Normalizer::NFD.new.decomposition('é').should eq("\u0065\u0301")
    end
  end
end

describe "ICU::Normalizer::NFC" do
  describe "initialize" do
    it "creates a new NFCNormalizer" do
      ICU::Normalizer::NFC.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFC)" do
      ICU::Normalizer::NFC.new.normalize("Àẹ́ñが").should eq("\u00C0" + "\u1EB9\u0301" + "\u00F1" + "\u304C")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::Normalizer::NFC.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end

describe "ICU::Normalizer::NFD" do
  describe "initialize" do
    it "creates a new NFDNormalizer" do
      ICU::Normalizer::NFD.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFD)" do
      ICU::Normalizer::NFD.new.normalize("Àẹ́ñが").should eq("\u0041\u0300" + "\u0065\u0323\u0301" + "\u006E\u0303" + "\u304B\u3099")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::Normalizer::NFD.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end

describe "ICU::Normalizer::NFKC" do
  describe "initialize" do
    it "creates a new NFKCNormalizer" do
      ICU::Normalizer::NFKC.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFKC)" do
      ICU::Normalizer::NFKC.new.normalize("Àẹ́ñが").should eq("\u00C0" + "\u1EB9\u0301" + "\u00F1" + "\u304C")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::Normalizer::NFKC.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end

describe "ICU::Normalizer::NFKD" do
  describe "initialize" do
    it "creates a new NFKDNormalizer" do
      ICU::Normalizer::NFKD.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFKD)" do
      ICU::Normalizer::NFKD.new.normalize("Àẹ́ñが").should eq("\u0041\u0300" + "\u0065\u0323\u0301" + "\u006E\u0303" + "\u304B\u3099")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::Normalizer::NFKD.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end

describe "ICU::Normalizer::NFKCCF" do
  describe "initialize" do
    it "creates a new NFKCCFNormalizer" do
      ICU::Normalizer::NFKCCF.new.should_not be_nil
    end
  end

  describe "normalize" do
    it "normalize some text (NFKCCF)" do
      ICU::Normalizer::NFKCCF.new.normalize("Àẹ́ñが").should eq("\u00E0" + "\u1EB9\u0301" + "\u00F1" + "\u304C")
    end
  end

  describe "normalized?" do
    it "checks if a text is normalized" do
      norm = ICU::Normalizer::NFKCCF.new
      text = "Àẹ́ñが"

      norm.normalized?(text).should be_false
      norm.normalized?(norm.normalize(text)).should be_true
    end
  end
end
