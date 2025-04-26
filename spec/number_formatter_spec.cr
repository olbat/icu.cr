require "./spec_helper"

describe ICU::NumberFormatter do
  it "creates a NumberFormatter instance" do
    nf = ICU::NumberFormatter.new
    nf.should be_a ICU::NumberFormatter
  end

  it "formats an integer number" do
    nf = ICU::NumberFormatter.new("fr_FR")
    nf.format(1234_i64).should eq "1 234"
  end

  it "formats a floating point number" do
    nf = ICU::NumberFormatter.new("en_US")
    nf.format(1234.56).should eq "1,234.56"
  end

  it "formats a floating point number with a currency code" do
    nf = ICU::NumberFormatter.new("en_US", ICU::NumberFormatter::FormatStyle::Currency)
    nf.format(1234.56, "USD").should eq "$1,234.56"
  end

  it "parses an integer number" do
    nf = ICU::NumberFormatter.new("nl_NL")
    nf.parse_int("1.234,56").should eq 1234
  end

  it "parses a floating point number" do
    nf = ICU::NumberFormatter.new("en_US")
    nf.parse_float("-1,234.56").should eq -1234.56
  end

  it "parses a floating point number" do
    nf = ICU::NumberFormatter.new("en_US")
    nf.parse_float_with_currency("$1,234.56").should eq ICU::NumberFormatter::MonetaryAmount.new(1234.56, "USD")
  end

  it "sets and gets an attribute" do
    nf = ICU::NumberFormatter.new("en_US")

    nf.set_attribute(ICU::NumberFormatter::FormatAttribute::GroupingUsed, 0)
    nf.get_attribute(ICU::NumberFormatter::FormatAttribute::GroupingUsed).should eq 0

    nf.format(1234.56).should eq "1234.56"
  end
end
