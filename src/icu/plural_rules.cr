# __Plural Rules__
#
# Provides access to ICU's plural rules functionality.
#
# __Usage__
# ```
# plural_rules = ICU::PluralRules.new("pl")
# plural_rules.select(0) # => "many"
# plural_rules.select(1) # => "one"
# plural_rules.select(2) # => "few"
# ```
#
# __See also__
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/upluralrules_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/plural_rules_spec.cr)
class ICU::PluralRules
  alias Type = LibICU::UPluralType

  @uplrules : LibICU::UPluralRules

  # Creates a new PluralRules object for the given locale.
  #
  # ```
  # plural_rules = ICU::PluralRules.new("en")
  # ```
  def initialize(locale : String)
    ustatus = LibICU::UErrorCode::UZeroError
    @uplrules = LibICU.uplrules_open(locale, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  # Creates a new PluralRules object for the given locale and plural type.
  #
  # ```
  # plural_rules = ICU::PluralRules.new("de", ICU::PluralRules::Type::TypeOrdinal)
  # ```
  def initialize(locale : String, type : Type)
    ustatus = LibICU::UErrorCode::UZeroError
    @uplrules = LibICU.uplrules_open_for_type(locale, type, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  # Closes the PluralRules object and releases resources.
  def finalize
    LibICU.uplrules_close(@uplrules)
  end

  # Selects the plural form for the given number.
  #
  # ```
  # plural_rules = ICU::PluralRules.new("fr")
  # plural_rules.select(1)   # => "one"
  # plural_rules.select(1.5) # => "one"
  # plural_rules.select(2)   # => "other"
  # ```
  def select(number : Float64) : String
    ICU.with_auto_resizing_buffer(32, UChars) do |buff, status_ptr|
      LibICU.uplrules_select(@uplrules, number, buff.as(UChars), buff.size, status_ptr)
    end
  end

  # Selects the plural form for the given integer number.
  #
  # Delegates to `#select(Float64)` after converting the integer.
  def select(number : Int) : String
    self.select(number.to_f64)
  end

  # Returns keywords associated to this plural rules.
  #
  # ```
  # plural_rules = ICU::PluralRules.new("pl")
  # plural_rules.keywords # => ["few", "many", "one", "other"]
  # ```
  def keywords : Array(String)
    ustatus = LibICU::UErrorCode::UZeroError
    keywords = LibICU.uplrules_get_keywords(@uplrules, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ICU::UEnum.new(keywords, owns: true).to_a
  end
end
