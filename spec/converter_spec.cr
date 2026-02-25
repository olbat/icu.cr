require "./spec_helper"

describe "ICU::Converter" do
  describe "initialize" do
    it "creates a converter for a known encoding" do
      ICU::Converter.new("UTF-8").should_not be_nil
    end

    it "creates a converter using an alias name" do
      ICU::Converter.new("latin-1").should_not be_nil
    end

    it "raises an error for an unknown encoding" do
      expect_raises(ICU::Error) do
        ICU::Converter.new("not-a-real-encoding")
      end
    end
  end

  describe "name" do
    it "returns the canonical name" do
      ICU::Converter.new("UTF-8").name.should eq("UTF-8")
    end

    it "normalizes alias names to canonical form" do
      ICU::Converter.new("latin-1").name.should eq("ISO-8859-1")
    end
  end

  describe "type" do
    it "returns the correct type for UTF-8" do
      ICU::Converter.new("UTF-8").type.should eq(ICU::Converter::Type::Utf8)
    end

    it "returns the correct type for ISO-8859-1" do
      ICU::Converter.new("ISO-8859-1").type.should eq(ICU::Converter::Type::Latin1)
    end
  end

  describe "min_char_size / max_char_size" do
    it "returns 1 for UTF-8 minimum" do
      ICU::Converter.new("UTF-8").min_char_size.should eq(1)
    end

    it "returns a value > 1 for UTF-8 maximum" do
      ICU::Converter.new("UTF-8").max_char_size.should be > 1
    end

    it "returns 1 for both min and max for ISO-8859-1" do
      cnv = ICU::Converter.new("ISO-8859-1")
      cnv.min_char_size.should eq(1)
      cnv.max_char_size.should eq(1)
    end
  end

  describe "fixed_width?" do
    it "returns false for variable-width encodings" do
      ICU::Converter.new("UTF-8").fixed_width?.should be_false
    end
  end

  describe "encode / decode" do
    it "round-trips ASCII text via ISO-8859-1" do
      cnv = ICU::Converter.new("ISO-8859-1")
      original = "Hello, World!"
      cnv.decode(cnv.encode(original)).should eq(original)
    end

    it "round-trips Latin-1 characters via ISO-8859-1" do
      cnv = ICU::Converter.new("ISO-8859-1")
      original = "caf\u00e9" # café
      cnv.decode(cnv.encode(original)).should eq(original)
    end

    it "round-trips text via UTF-16BE" do
      cnv = ICU::Converter.new("UTF-16BE")
      original = "Hello"
      cnv.decode(cnv.encode(original)).should eq(original)
    end

    it "encodes text to the expected bytes for ISO-8859-1" do
      cnv = ICU::Converter.new("ISO-8859-1")
      bytes = cnv.encode("A\u00e9") # 'A' and 'é'
      bytes.should eq(Bytes[0x41, 0xe9])
    end
  end

  describe "reset" do
    it "returns self" do
      cnv = ICU::Converter.new("UTF-8")
      cnv.reset.should eq(cnv)
    end
  end

  describe ".aliases" do
    it "returns a non-empty list of aliases" do
      aliases = ICU::Converter.aliases("UTF-8")
      aliases.should_not be_empty
      aliases.should contain("UTF-8")
    end
  end

  describe ".canonical_name" do
    it "returns the canonical name for a known alias" do
      result = ICU::Converter.canonical_name("utf8", "IANA")
      result.should eq("UTF-8")
    end

    it "returns nil for an unknown alias" do
      result = ICU::Converter.canonical_name("not-a-real-alias", "IANA")
      result.should be_nil
    end
  end

  describe ".available_names" do
    it "returns a non-empty list of converter names" do
      names = ICU::Converter.available_names
      names.should_not be_empty
      names.should contain("UTF-8")
    end

    it "returns the same list on successive calls (cached)" do
      ICU::Converter.available_names.should eq(ICU::Converter.available_names)
    end
  end

  describe ".default_name" do
    it "returns a non-empty string" do
      ICU::Converter.default_name.should_not be_empty
    end
  end

  describe ".convert" do
    it "converts bytes between two encodings" do
      cnv = ICU::Converter.new("ISO-8859-1")
      iso_bytes = cnv.encode("caf\u00e9")

      utf8_bytes = ICU::Converter.convert("ISO-8859-1", "UTF-8", iso_bytes)
      String.new(utf8_bytes).should eq("caf\u00e9")
    end

    it "handles ASCII pass-through" do
      bytes = "Hello".to_slice
      result = ICU::Converter.convert("ASCII", "UTF-8", bytes)
      String.new(result).should eq("Hello")
    end
  end
end

describe "ICU::ConverterSelector" do
  describe "initialize" do
    it "creates a selector from a list of converter names" do
      ICU::ConverterSelector.new(["UTF-8", "ISO-8859-1"]).should_not be_nil
    end
  end

  describe "select_for" do
    it "returns converters that can encode ASCII text" do
      sel = ICU::ConverterSelector.new(["UTF-8", "ISO-8859-1", "ISO-8859-2"])
      candidates = sel.select_for("Hello")
      # All listed converters can handle plain ASCII
      candidates.should contain("UTF-8")
      candidates.should contain("ISO-8859-1")
      candidates.should contain("ISO-8859-2")
    end

    it "excludes converters that cannot encode the text" do
      # ISO-8859-5 is Cyrillic — it cannot round-trip Japanese characters
      sel = ICU::ConverterSelector.new(["UTF-8", "ISO-8859-5", "Shift_JIS"])
      candidates = sel.select_for("\u3053\u3093\u306b\u3061\u306f") # こんにちは
      candidates.should contain("UTF-8")
      candidates.should_not contain("ISO-8859-5")
    end

    it "returns UTF-8 for any valid Unicode string" do
      sel = ICU::ConverterSelector.new(["UTF-8", "ISO-8859-1"])
      sel.select_for("Hello \u4e2d\u6587").should contain("UTF-8")
    end
  end
end
