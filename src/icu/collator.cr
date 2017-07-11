class ICU::Collator
  alias Attribute = LibICU::UColAttribute
  alias AttributeValue = LibICU::UColAttributeValue
  alias Strength = LibICU::UCollationStrength
  alias BoundMode = LibICU::UColBoundMode
  alias ReorderCode = LibICU::UColReorderCode
  alias RuleOption = LibICU::UColRuleOption

  ON      = ICU::Collator::AttributeValue::On
  OFF     = ICU::Collator::AttributeValue::Off
  DEFAULT = ICU::Collator::AttributeValue::Default

  LOCALES = begin
    ustatus = LibICU::UErrorCode::UZeroError
    uenum = LibICU.ucol_open_available_locales(pointerof(ustatus))
    ICU.check_error!(ustatus)
    locales = UEnum.new(uenum).to_a
    LibICU.uenum_close(uenum)
    Set(String).new(locales)
  end

  @ucol : LibICU::UCollator
  @locale : String?
  @rules : ICU::UChars?
  getter :locale, :rules

  def initialize(@locale : String = "")
    if !locale.empty? && !LOCALES.includes?(locale) && !LOCALES.includes?(locale.split('_').first)
      raise ICU::Error.new("unknown locale #{locale}")
    end

    ustatus = LibICU::UErrorCode::UZeroError
    @ucol = LibICU.ucol_open(locale, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def initialize(@rules : UChars, normalization_mode : AttributeValue = DEFAULT, strength : Strength = AttributeValue::DefaultStrength)
    ustatus = LibICU::UErrorCode::UZeroError
    @ucol = LibICU.ucol_open_rules(rules, rules.size, normalization_mode, strength, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def finalize
    @ucol.try { |ucol| LibICU.ucol_close(ucol) }
  end

  def compare(s1 : String, s2 : String) : Int
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.ucol_strcoll_utf8(@ucol, s1, s2.size, s2, s2.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret.to_i
  end

  def equals?(s1 : String, s2 : String) : Bool
    LibICU.ucol_equal(@ucol, s1.to_uchars, s2.size, s2.to_uchars, s2.size) != 0
  end
end
