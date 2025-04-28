require "./spec_helper"

describe ICU::PluralRules do
  it "initializes with a locale" do
    plural_rules = ICU::PluralRules.new("en")
    plural_rules.should be_a ICU::PluralRules
  end

  it "initializes with a locale and type" do
    plural_rules = ICU::PluralRules.new("en", ICU::PluralRules::Type::TypeCardinal)
    plural_rules.should be_a ICU::PluralRules
    plural_rules = ICU::PluralRules.new("en", ICU::PluralRules::Type::TypeOrdinal)
    plural_rules.should be_a ICU::PluralRules
  end

  it "selects the correct plural form" do
    plural_rules = ICU::PluralRules.new("fr")
    plural_rules.select(0).should eq "one"
    plural_rules.select(1).should eq "one"
    plural_rules.select(2).should eq "other"
  end

  it "returns the keywords for a given locale" do
    plural_rules = ICU::PluralRules.new("pl")
    keywords = plural_rules.keywords
    keywords.sort.should eq ["few", "many", "one", "other"]
  end
end
