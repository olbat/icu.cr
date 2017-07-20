require "./spec_helper"

describe "ICU::IDNA" do
  describe "to_ascii" do
    it "converts a Unicode IDN to it's ASCII representation" do
      idn = "افغانستا.icom.museum"
      ICU::IDNA.to_ascii(idn).should eq("xn--mgbaal8b0b9b2b.icom.museum")
      ICU::IDNA.to_unicode(ICU::IDNA.to_unicode(idn)).should eq(idn)
    end
  end

  describe "to_unicode" do
    it "converts an ASCII IDN to it's Unicode representation" do
      idn = "xn--mgbaal8b0b9b2b.icom.museum"
      ICU::IDNA.to_unicode(idn).should eq("افغانستا.icom.museum")
      ICU::IDNA.to_ascii(ICU::IDNA.to_unicode(idn)).should eq(idn)
    end
  end

  describe "compare" do
    it "compares two IDNs using the same representation" do
      ICU::IDNA.compare("example.org", "example.org").should eq(0)
      ICU::IDNA.compare("fxample.org", "example.org").should eq(1)
      ICU::IDNA.compare("example.org", "fxample.org").should eq(-1)
    end

    it "compares two IDNs using a different representation" do
      ICU::IDNA.compare("افغانستا.icom.museum", "xn--mgbaal8b0b9b2b.icom.museum").should eq(0)
      ICU::IDNA.compare("افغانستا.jcom.museum", "xn--mgbaal8b0b9b2b.icom.museum").should eq(1)
      ICU::IDNA.compare("افغانستا.icom.museum", "xn--mgbaal8b0b9b2b.jcom.museum").should eq(-1)
    end
  end
end
