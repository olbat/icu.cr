require "./spec_helper"

describe "ICU::Transliterator" do
  describe "IDS" do
    it "lists available IDs" do
      ICU::Transliterator::IDS.includes?({from: "Any", to: "Hex", variant: nil}).should be_true
    end
  end

  describe "id2str" do
    it "convert an ID to a String" do
      ICU::Transliterator.id2str({from: "Any", to: nil, variant: nil}).should eq("Any")
      ICU::Transliterator.id2str({from: "Any", to: "Hex", variant: nil}).should eq("Any-Hex")
      ICU::Transliterator.id2str({from: "Any", to: "Hex", variant: "Unicode"}).should eq("Any-Hex/Unicode")
    end
  end

  describe "str2id" do
    it "convert a String to an ID" do
      ICU::Transliterator.str2id("Any").should eq({from: "Any", to: nil, variant: nil})
      ICU::Transliterator.str2id("Any-Hex").should eq({from: "Any", to: "Hex", variant: nil})
      ICU::Transliterator.str2id("Any-Hex/Unicode").should eq({from: "Any", to: "Hex", variant: "Unicode"})
    end
  end

  describe "initialize" do
    it "creates a Transliterator using built-in transforms" do
      ICU::Transliterator.new("Any-Hex").should_not be_nil
      ICU::Transliterator.new({from: "Any", to: "Hex", variant: nil}).should_not be_nil
      ICU::Transliterator.new("Any-Hex/Unicode").should_not be_nil
      ICU::Transliterator.new({from: "Any", to: "Hex", variant: "Unicode"}).should_not be_nil
    end

    it "creates a Transliterator using a custom transform" do
      ICU::Transliterator.new("TestRule", "x > y ;").should_not be_nil
    end

    it "raises an exception if the built-in ID does not exist" do
      expect_raises do
        ICU::Transliterator.new("Nothing")
      end
    end

    it "raises an exception if the custom rule is not valid" do
      expect_raises do
        ICU::Transliterator.new(id: "InvalidRule", rules: "a")
      end
    end
  end

  describe "transliterate" do
    it "transliterates a text using built-in transforms" do
      # use only built-in transforms
      # (see http://userguide.icu-project.org/transforms/general)
      samples = [
        {
          src:  {script: "Greek", text: "Αλφαβητικός Κατάλογος"},
          dest: {script: "Latin", text: "Alphabētikós Katálogos"},
        },
        # FIXME: strange bug with this test
        # {
        #  src: {script: "Latin", text: "Alphabētikós Katálogos"},
        #  dest: {script: "Greek", text: "Αλφαβητικός Κατάλογος"},
        # },
        {
          src:  {script: "Katakana", text: "ミヤモト ムサシ"},
          dest: {script: "Hiragana", text: "みやもと むさし"},
        },
        {
          src:  {script: "Simplified", text: "我能吞下玻璃而不伤身体。"},
          dest: {script: "Traditional", text: "我能吞下玻璃而不傷身體。"},
        },
        {
          src:  {script: "Any", text: "Some Text"},
          dest: {script: "Upper", text: "SOME TEXT"},
        },
        {
          src:  {script: "Latin", text: "Sómè Téxt ©"},
          dest: {script: "ASCII", text: "Some Text (C)"},
        },
        {
          src:  {script: "Accents", text: "Sómè Téxt ©"},
          dest: {script: "Any", text: "So←'→me←`→ Te←'→xt ©"},
        },
        {
          src:  {script: "Any", text: "ミヤモト ムサシ"},
          dest: {script: "Hex", text: "\\u30DF\\u30E4\\u30E2\\u30C8\\u0020\\u30E0\\u30B5\\u30B7"},
        },
      ]

      samples.each do |sample|
        trans = ICU::Transliterator.new({from: sample[:src][:script], to: sample[:dest][:script], variant: nil})
        trans.transliterate(sample[:src][:text]).should eq(sample[:dest][:text])
      end
    end

    it "transliterates a text using custom transforms" do
      trans = ICU::Transliterator.new(id: "XYZ", rules: "xy > z ;")
      trans.transliterate("xyz").should eq("zz")
    end
  end

  describe "reverse" do
    it "reverses a transliterator" do
      trans = ICU::Transliterator.new("Greek-Latin")
      trans.reverse!.transliterate("tí phḗis").should eq("τί φῄς")
    end
  end
end
