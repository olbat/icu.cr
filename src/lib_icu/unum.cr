@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UNumberFormatAttribute
    UnumParseIntOnly                  =    0
    UnumGroupingUsed                  =    1
    UnumDecimalAlwaysShown            =    2
    UnumMaxIntegerDigits              =    3
    UnumMinIntegerDigits              =    4
    UnumIntegerDigits                 =    5
    UnumMaxFractionDigits             =    6
    UnumMinFractionDigits             =    7
    UnumFractionDigits                =    8
    UnumMultiplier                    =    9
    UnumGroupingSize                  =   10
    UnumRoundingMode                  =   11
    UnumRoundingIncrement             =   12
    UnumFormatWidth                   =   13
    UnumPaddingPosition               =   14
    UnumSecondaryGroupingSize         =   15
    UnumSignificantDigitsUsed         =   16
    UnumMinSignificantDigits          =   17
    UnumMaxSignificantDigits          =   18
    UnumLenientParse                  =   19
    UnumParseAllInput                 =   20
    UnumScale                         =   21
    UnumNumericAttributeCount         =   22
    UnumMaxNonbooleanAttribute        = 4095
    UnumFormatFailIfMoreThanMaxDigits = 4096
    UnumParseNoExponent               = 4097
    UnumLimitBooleanAttribute         = 4098
  end
  enum UNumberFormatStyle
    UnumPatternDecimal   =  0
    UnumDecimal          =  1
    UnumCurrency         =  2
    UnumPercent          =  3
    UnumScientific       =  4
    UnumSpellout         =  5
    UnumOrdinal          =  6
    UnumDuration         =  7
    UnumNumberingSystem  =  8
    UnumPatternRulebased =  9
    UnumCurrencyIso      = 10
    UnumCurrencyPlural   = 11
    UnumFormatStyleCount = 12
    UnumDefault          =  1
    UnumIgnore           =  0
  end
  enum UNumberFormatSymbol
    UnumDecimalSeparatorSymbol          =  0
    UnumGroupingSeparatorSymbol         =  1
    UnumPatternSeparatorSymbol          =  2
    UnumPercentSymbol                   =  3
    UnumZeroDigitSymbol                 =  4
    UnumDigitSymbol                     =  5
    UnumMinusSignSymbol                 =  6
    UnumPlusSignSymbol                  =  7
    UnumCurrencySymbol                  =  8
    UnumIntlCurrencySymbol              =  9
    UnumMonetarySeparatorSymbol         = 10
    UnumExponentialSymbol               = 11
    UnumPermillSymbol                   = 12
    UnumPadEscapeSymbol                 = 13
    UnumInfinitySymbol                  = 14
    UnumNanSymbol                       = 15
    UnumSignificantDigitSymbol          = 16
    UnumMonetaryGroupingSeparatorSymbol = 17
    UnumOneDigitSymbol                  = 18
    UnumTwoDigitSymbol                  = 19
    UnumThreeDigitSymbol                = 20
    UnumFourDigitSymbol                 = 21
    UnumFiveDigitSymbol                 = 22
    UnumSixDigitSymbol                  = 23
    UnumSevenDigitSymbol                = 24
    UnumEightDigitSymbol                = 25
    UnumNineDigitSymbol                 = 26
    UnumFormatSymbolCount               = 27
  end
  enum UNumberFormatTextAttribute
    UnumPositivePrefix   = 0
    UnumPositiveSuffix   = 1
    UnumNegativePrefix   = 2
    UnumNegativeSuffix   = 3
    UnumPaddingCharacter = 4
    UnumCurrencyCode     = 5
    UnumDefaultRuleset   = 6
    UnumPublicRulesets   = 7
  end
  fun unum_apply_pattern = unum_applyPattern{{SYMS_SUFFIX.id}}(format : UNumberFormat*, localized : UBool, pattern : UChar*, pattern_length : Int32T, parse_error : UParseError*, status : UErrorCode*)
  fun unum_clone = unum_clone{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, status : UErrorCode*) : UNumberFormat*
  fun unum_close = unum_close{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*)
  fun unum_count_available = unum_countAvailable{{SYMS_SUFFIX.id}} : Int32T
  fun unum_format = unum_format{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, number : Int32T, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_decimal = unum_formatDecimal{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, number : LibC::Char*, length : Int32T, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_double = unum_formatDouble{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, number : LibC::Double, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_double_currency = unum_formatDoubleCurrency{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, number : LibC::Double, currency : UChar*, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_int64 = unum_formatInt64{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, number : Int64T, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_u_formattable = unum_formatUFormattable{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, number : UFormattable*, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_get_attribute = unum_getAttribute{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, attr : UNumberFormatAttribute) : Int32T
  fun unum_get_available = unum_getAvailable{{SYMS_SUFFIX.id}}(locale_index : Int32T) : LibC::Char*
  fun unum_get_double_attribute = unum_getDoubleAttribute{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, attr : UNumberFormatAttribute) : LibC::Double
  fun unum_get_locale_by_type = unum_getLocaleByType{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun unum_get_symbol = unum_getSymbol{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, symbol : UNumberFormatSymbol, buffer : UChar*, size : Int32T, status : UErrorCode*) : Int32T
  fun unum_get_text_attribute = unum_getTextAttribute{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, tag : UNumberFormatTextAttribute, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun unum_open = unum_open{{SYMS_SUFFIX.id}}(style : UNumberFormatStyle, pattern : UChar*, pattern_length : Int32T, locale : LibC::Char*, parse_err : UParseError*, status : UErrorCode*) : UNumberFormat*
  fun unum_parse = unum_parse{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : Int32T
  fun unum_parse_decimal = unum_parseDecimal{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, out_buf : LibC::Char*, out_buf_length : Int32T, status : UErrorCode*) : Int32T
  fun unum_parse_double = unum_parseDouble{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : LibC::Double
  fun unum_parse_double_currency = unum_parseDoubleCurrency{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, currency : UChar*, status : UErrorCode*) : LibC::Double
  fun unum_parse_int64 = unum_parseInt64{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : Int64T
  fun unum_parse_to_u_formattable = unum_parseToUFormattable{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, result : UFormattable*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : UFormattable*
  fun unum_set_attribute = unum_setAttribute{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, attr : UNumberFormatAttribute, new_value : Int32T)
  fun unum_set_double_attribute = unum_setDoubleAttribute{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, attr : UNumberFormatAttribute, new_value : LibC::Double)
  fun unum_set_symbol = unum_setSymbol{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, symbol : UNumberFormatSymbol, value : UChar*, length : Int32T, status : UErrorCode*)
  fun unum_set_text_attribute = unum_setTextAttribute{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, tag : UNumberFormatTextAttribute, new_value : UChar*, new_value_length : Int32T, status : UErrorCode*)
  fun unum_to_pattern = unum_toPattern{{SYMS_SUFFIX.id}}(fmt : UNumberFormat*, is_pattern_localized : UBool, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  {% end %}
end
