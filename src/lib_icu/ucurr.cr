@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  alias UCurrRegistryKey = Void*
  enum UCurrNameStyle
    SymbolName        = 0
    LongName          = 1
    NarrowSymbolName  = 2
    FormalSymbolName  = 3
    VariantSymbolName = 4
  end
  enum UCurrencyUsage
    UsageStandard = 0
    UsageCash     = 1
    UsageCount    = 2
  end
  fun ucurr_count_currencies = ucurr_countCurrencies{{SYMS_SUFFIX.id}}(locale : LibC::Char*, date : UDate, ec : UErrorCode*) : Int32T
  fun ucurr_for_locale = ucurr_forLocale{{SYMS_SUFFIX.id}}(locale : LibC::Char*, buff : UChar*, buff_capacity : Int32T, ec : UErrorCode*) : Int32T
  fun ucurr_for_locale_and_date = ucurr_forLocaleAndDate{{SYMS_SUFFIX.id}}(locale : LibC::Char*, date : UDate, index : Int32T, buff : UChar*, buff_capacity : Int32T, ec : UErrorCode*) : Int32T
  fun ucurr_get_default_fraction_digits = ucurr_getDefaultFractionDigits{{SYMS_SUFFIX.id}}(currency : UChar*, ec : UErrorCode*) : Int32T
  fun ucurr_get_default_fraction_digits_for_usage = ucurr_getDefaultFractionDigitsForUsage{{SYMS_SUFFIX.id}}(currency : UChar*, usage : UCurrencyUsage, ec : UErrorCode*) : Int32T
  fun ucurr_get_keyword_values_for_locale = ucurr_getKeywordValuesForLocale{{SYMS_SUFFIX.id}}(key : LibC::Char*, locale : LibC::Char*, commonly_used : UBool, status : UErrorCode*) : UEnumeration
  fun ucurr_get_name = ucurr_getName{{SYMS_SUFFIX.id}}(currency : UChar*, locale : LibC::Char*, name_style : UCurrNameStyle, is_choice_format : UBool*, len : Int32T*, ec : UErrorCode*) : UChar*
  fun ucurr_get_numeric_code = ucurr_getNumericCode{{SYMS_SUFFIX.id}}(currency : UChar*) : Int32T
  fun ucurr_get_plural_name = ucurr_getPluralName{{SYMS_SUFFIX.id}}(currency : UChar*, locale : LibC::Char*, is_choice_format : UBool*, plural_count : LibC::Char*, len : Int32T*, ec : UErrorCode*) : UChar*
  fun ucurr_get_rounding_increment = ucurr_getRoundingIncrement{{SYMS_SUFFIX.id}}(currency : UChar*, ec : UErrorCode*) : LibC::Double
  fun ucurr_get_rounding_increment_for_usage = ucurr_getRoundingIncrementForUsage{{SYMS_SUFFIX.id}}(currency : UChar*, usage : UCurrencyUsage, ec : UErrorCode*) : LibC::Double
  fun ucurr_is_available = ucurr_isAvailable{{SYMS_SUFFIX.id}}(iso_code : UChar*, from : UDate, to : UDate, error_code : UErrorCode*) : UBool
  fun ucurr_open_iso_currencies = ucurr_openISOCurrencies{{SYMS_SUFFIX.id}}(curr_type : Uint32T, p_error_code : UErrorCode*) : UEnumeration
  fun ucurr_register = ucurr_register{{SYMS_SUFFIX.id}}(iso_code : UChar*, locale : LibC::Char*, status : UErrorCode*) : UCurrRegistryKey
  fun ucurr_unregister = ucurr_unregister{{SYMS_SUFFIX.id}}(key : UCurrRegistryKey, status : UErrorCode*) : UBool
  {% end %}
end
