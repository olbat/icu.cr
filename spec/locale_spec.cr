require "./spec_helper"
require "../src/icu/locale"

describe ICU::Locale do
  it "initializes with a locale string" do
    locale = ICU::Locale.new("en_US")
    locale.id.should eq("en_US")
  end

  it "gets locale components" do
    locale = ICU::Locale.new("en_US_POSIX@collation=phonebook;calendar=gregorian")
    locale.language.should eq("en")
    locale.country.should eq("US")
    locale.script.should eq("") # No script in this ID
    locale.variant.should eq("POSIX")
    locale.base_name.should eq("en_US_POSIX")
    # Check keywords and values instead of the full name string due to variable order
    locale.keyword_value("collation").should eq("phonebook")
    locale.keyword_value("calendar").should eq("gregorian")
    locale.keywords.to_a.sort.should eq(["calendar", "collation"])
    # The full name string can have variable keyword order, so we don't assert exact equality
    locale.name.should start_with("en_US_POSIX@")
    locale.name.should contain("collation=phonebook")
    locale.name.should contain("calendar=gregorian")
  end

  it "gets display names" do
    locale_fr = ICU::Locale.new("fr_FR")
    locale_en = ICU::Locale.new("en_US")

    locale_fr.display_name("en_US").should eq("French (France)")
    locale_en.display_name("fr_FR").should eq("anglais (États-Unis)")

    locale_fr.display_language("en_US").should eq("French")
    locale_en.display_language("fr_FR").should eq("anglais")

    locale_fr.display_country("en_US").should eq("France")
    locale_en.display_country("fr_FR").should eq("États-Unis")

    locale_zh_hans_cn = ICU::Locale.new("zh-Hans-CN")
    locale_zh_hans_cn.display_script("en_US").should eq("Simplified Han")

    locale_en_us_posix = ICU::Locale.new("en_US_POSIX")
    locale_en_us_posix.display_variant("en_US").should eq("Computer")
  end

  it "gets display name for keyword" do
    ICU::Locale.display_keyword("collation", "en_US").should eq("Sort Order")
    ICU::Locale.display_keyword("calendar", "fr_FR").should eq("calendrier")
  end

  it "gets display name for keyword value" do
    locale = ICU::Locale.new("fr_FR@collation=phonebook")
    locale.display_keyword_value("collation", "en_US").should eq("Phonebook Sort Order")
  end

  it "canonicalizes locale ID" do
    ICU::Locale.new("en-us").canonicalize.id.should eq("en_US")
    ICU::Locale.new("fr_fr").canonicalize.id.should eq("fr_FR")
  end

  it "adds likely subtags" do
    # Results can vary slightly based on ICU data version
    locale_en = ICU::Locale.new("en").add_likely_subtags
    locale_en.id.should start_with("en_Latn_") # Script is usually Latn for English
    locale_en.id.should end_with("_US")        # Country is usually US for English

    locale_zh = ICU::Locale.new("zh").add_likely_subtags
    locale_zh.id.should start_with("zh_Hans_") # Script is usually Hans for Chinese
    locale_zh.id.should end_with("_CN")        # Country is usually CN for Chinese
  end

  it "minimizes subtags" do
    ICU::Locale.new("en_Latn_US").minimize_subtags.id.should eq("en")
    ICU::Locale.new("zh_Hans_CN").minimize_subtags.id.should eq("zh")
    ICU::Locale.new("fr_FR").minimize_subtags.id.should eq("fr") # FR is the most likely country for fr
  end

  it "converts to language tag" do
    ICU::Locale.new("en_US").to_language_tag.should eq("en-US")
    ICU::Locale.new("en_US_POSIX").to_language_tag.should eq("en-US-u-va-posix")
    ICU::Locale.new("en_US_POSIX").to_language_tag(strict: true).should eq("en-US-u-va-posix")
    ICU::Locale.new("zh_Hans_CN").to_language_tag.should eq("zh-Hans-CN")
    ICU::Locale.new("fr_FR@collation=phonebook").to_language_tag.should eq("fr-FR-u-co-phonebk")
  end

  it "creates from language tag" do
    ICU::Locale.from_language_tag("en-US").id.should eq("en_US")
    ICU::Locale.from_language_tag("en-US-posix").id.should eq("en_US_POSIX")
    ICU::Locale.from_language_tag("zh-Hans-CN").id.should eq("zh_Hans_CN")
    ICU::Locale.from_language_tag("fr-FR-u-co-phonebk").id.should eq("fr_FR@collation=phonebook")
  end

  it "gets keyword value" do
    locale = ICU::Locale.new("fr_FR@collation=phonebook;calendar=gregorian")
    locale.keyword_value("collation").should eq("phonebook")
    locale.keyword_value("calendar").should eq("gregorian")
    locale.keyword_value("nonexistent").should eq("")
  end

  it "sets keyword value" do
    locale = ICU::Locale.new("fr_FR")
    new_locale = locale.add_keyword_value("collation", "phonebook")
    # Check the resulting locale's components and keywords instead of the full ID string
    new_locale.language.should eq("fr")
    new_locale.country.should eq("FR")
    new_locale.keyword_value("collation").should eq("phonebook")
    new_locale.keywords.to_a.should eq(["collation"]) # Only one keyword set

    # Setting another keyword
    another_locale = new_locale.add_keyword_value("calendar", "gregorian")
    another_locale.language.should eq("fr")
    another_locale.country.should eq("FR")
    another_locale.keyword_value("collation").should eq("phonebook")
    another_locale.keyword_value("calendar").should eq("gregorian")
    another_locale.keywords.to_a.sort.should eq(["calendar", "collation"])

    # Overwriting a keyword
    overwrite_locale = another_locale.add_keyword_value("collation", "standard")
    overwrite_locale.language.should eq("fr")
    overwrite_locale.country.should eq("FR")
    overwrite_locale.keyword_value("collation").should eq("standard")
    overwrite_locale.keyword_value("calendar").should eq("gregorian")
    overwrite_locale.keywords.to_a.sort.should eq(["calendar", "collation"])
  end

  it "enumerates keywords" do
    locale = ICU::Locale.new("fr_FR@collation=phonebook;calendar=gregorian")
    keywords = locale.keywords.to_a.sort
    keywords.should eq(["calendar", "collation"])

    ICU::Locale.new("en_US").keywords.to_a.should be_empty
  end

  it "gets orientation" do
    ICU::Locale.new("en_US").character_orientation.should eq(LibICU::ULayoutType::LayoutLtr)
    ICU::Locale.new("ar_AE").character_orientation.should eq(LibICU::ULayoutType::LayoutRtl)

    ICU::Locale.new("en_US").line_orientation.should eq(LibICU::ULayoutType::LayoutTtb)
    # ICU doesn't seem to have built-in data for non-Ttb line orientation for standard locales.
    # This test assumes Ttb for common locales is sufficient for a basic test.
  end

  it "checks right_to_left?" do
    ICU::Locale.new("en_US").right_to_left?.should be_false
    ICU::Locale.new("ar_AE").right_to_left?.should be_true
  end

  it "gets default locale" do
    # This test might be sensitive to the environment's default locale
    default_locale = ICU::Locale.default
    default_locale.should be_a(ICU::Locale)
    # We can't assert the exact ID unless we control the environment,
    # but we can check if it's a valid locale string.
    default_locale.id.should_not be_empty
  end

  it "enumerates available locales" do
    available = ICU::Locale.available_locales.to_a
    available.should be_a(Array(ICU::Locale))
    available.should_not be_empty
    locale_names = available.map(&.name)
    locale_names.should contain("en_US")
    locale_names.should contain("fr_FR")
  end

  it "gets measurement system" do
    ICU::Locale.new("en_US").measurement_system.should eq(LibICU::UMeasurementSystem::Us)
    ICU::Locale.new("en_GB").measurement_system.should eq(LibICU::UMeasurementSystem::Uk)
    ICU::Locale.new("fr_FR").measurement_system.should eq(LibICU::UMeasurementSystem::Si)
  end

  it "gets delimiters" do
    locale = ICU::Locale.new("en_US")
    locale.delimiter(ICU::Locale::DelimiterType::QuotationStart).should eq("“")
    locale.delimiter(ICU::Locale::DelimiterType::QuotationEnd).should eq("”")
    locale.delimiter(ICU::Locale::DelimiterType::AltQuotationStart).should eq("‘")
    locale.delimiter(ICU::Locale::DelimiterType::AltQuotationEnd).should eq("’")
  end

  it "gets locale display pattern and separator" do
    ICU::Locale.new("en_US").locale_display_pattern.should eq("{0} ({1})")
    ICU::Locale.new("en_US").locale_separator.should eq(", ")
  end
end
