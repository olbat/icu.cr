require "./spec_helper"

describe "ICU::CharsetDetector" do
  describe "initialize" do
    it "creates a new charset detector" do
      ICU::CharsetDetector.new.should_not be_nil
    end
  end

  describe "detect" do
    it "detects encoding" do
      text = File.read(File.join(DATA_DIR, "text_sample.txt"))

      csdet = ICU::CharsetDetector.new
      cm = csdet.detect(text)

      cm.name.should eq("ISO-8859-1")
      cm.language.should eq("en")
      cm.confidence.should be > 50
    end
  end

  describe "detect_all" do
    it "detects encoding" do
      text = File.read(File.join(DATA_DIR, "text_sample.txt"))

      csdet = ICU::CharsetDetector.new
      cms = csdet.detect_all(text)

      cms.first.name.should eq("ISO-8859-1")
      cms.first.language.should eq("en")
      cms.first.confidence.should be > 50

      cms.size.should be > 1
    end
  end

  describe "detectable_charsets" do
    it "returns the list of detectable charsets" do
      dcs1 = ICU::CharsetDetector.new.detectable_charsets
      dcs1.size.should be > 1

      dcs2 = ICU::CharsetDetector.detectable_charsets
      dcs2.size.should be > 1
      dcs2.should eq(dcs1)
    end
  end
end
