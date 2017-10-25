# Collation
#
# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/ucol_8h.html)
# - [user guide](http://userguide.icu-project.org/collation)
class ICU::Collator
  alias Attribute = LibICU::UColAttribute
  alias AttributeValue = LibICU::UColAttributeValue
  alias Strength = LibICU::UCollationStrength
  alias BoundMode = LibICU::UColBoundMode
  alias ReorderCode = LibICU::UColReorderCode
  alias RuleOption = LibICU::UColRuleOption

  ON      = AttributeValue::On
  OFF     = AttributeValue::Off
  DEFAULT = AttributeValue::Default

  LOCALES = begin
    ustatus = LibICU::UErrorCode::UZeroError
    uenum = LibICU.ucol_open_available_locales(pointerof(ustatus))
    ICU.check_error!(ustatus)
    locales = UEnum.new(uenum).to_a
    LibICU.uenum_close(uenum)
    Set(String).new(locales)
  end

  KEYWORDS = begin
    keywords = Hash(String, Set(String)).new
    ustatus = LibICU::UErrorCode::UZeroError
    kenum = LibICU.ucol_get_keywords(pointerof(ustatus))
    ICU.check_error!(ustatus)
    UEnum.new(kenum).each do |keyword|
      ustatus = LibICU::UErrorCode::UZeroError
      venum = LibICU.ucol_get_keyword_values(keyword, pointerof(ustatus))
      ICU.check_error!(ustatus)
      keywords[keyword] = Set(String).new(UEnum.new(venum).to_a)
    end
    LibICU.uenum_close(kenum)
    keywords
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

  def to_unsafe
    @ucol
  end

  {% if compare_versions(LibICU::VERSION, "50.0.0") >= 0 %}
  def compare(s1 : String, s2 : String) : Int
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.ucol_strcoll_utf8(@ucol, s1, s2.size, s2, s2.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret.to_i
  end
  {% end %}

  def equals?(s1 : String, s2 : String) : Bool
    LibICU.ucol_equal(@ucol, s1.to_uchars, s2.size, s2.to_uchars, s2.size) != 0
  end

  # Get the value of the specified attribute
  def [](attribute : Attribute) : AttributeValue
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.ucol_get_attribute(@ucol, attribute, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret
  end

  # Set a value to the specified attribute
  def []=(attribute : Attribute, value : AttributeValue)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.ucol_set_attribute(@ucol, attribute, value, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  def strength : Strength
    LibICU.ucol_get_strength(@ucol)
  end

  def strength=(value : Strength)
    LibICU.ucol_set_strength(@ucol, value)
    self
  end

  def reorder_codes : Array(ReorderCode)
    ustatus = LibICU::UErrorCode::UZeroError
    dest = Slice(Int32).new(ReorderCode.names.size) # max size = size of the enum
    size = LibICU.ucol_get_reorder_codes(@ucol, dest, dest.size, pointerof(ustatus))
    ICU.check_error!(ustatus)

    if size > 0
      dest.to_a[0..(size - 1)].map { |c| ReorderCode.new(c) }
    else
      [] of ReorderCode
    end
  end

  def reorder_codes=(codes : Array(ReorderCode))
    ustatus = LibICU::UErrorCode::UZeroError
    codes = codes.map { |c| c.to_i32 }
    LibICU.ucol_set_reorder_codes(@ucol, codes, codes.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  def self.functional_equivalent(locale : String, keyword : String = KEYWORDS.keys.first)
    ustatus = LibICU::UErrorCode::UZeroError
    available = Bytes.new(1)
    res = Bytes.new(ICU::Locale::FULLNAME_MAX_SIZE)
    size = LibICU.ucol_get_functional_equivalent(res, res.size, keyword, locale, available, pointerof(ustatus))
    ICU.check_error!(ustatus)

    if available
      String.new(res[0, size])
    else
      nil
    end
  end
end
