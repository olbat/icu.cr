@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
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
  fun unum_apply_pattern = unum_applyPattern_52(format : UNumberFormat*, localized : UBool, pattern : UChar*, pattern_length : Int32T, parse_error : UParseError*, status : UErrorCode*)
  fun unum_clone = unum_clone_52(fmt : UNumberFormat*, status : UErrorCode*) : UNumberFormat*
  fun unum_close = unum_close_52(fmt : UNumberFormat*)
  fun unum_count_available = unum_countAvailable_52 : Int32T
  fun unum_format = unum_format_52(fmt : UNumberFormat*, number : Int32T, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_decimal = unum_formatDecimal_52(fmt : UNumberFormat*, number : LibC::Char*, length : Int32T, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_double = unum_formatDouble_52(fmt : UNumberFormat*, number : LibC::Double, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_double_currency = unum_formatDoubleCurrency_52(fmt : UNumberFormat*, number : LibC::Double, currency : UChar*, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_int64 = unum_formatInt64_52(fmt : UNumberFormat*, number : Int64T, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_format_u_formattable = unum_formatUFormattable_52(fmt : UNumberFormat*, number : UFormattable*, result : UChar*, result_length : Int32T, pos : UFieldPosition*, status : UErrorCode*) : Int32T
  fun unum_get_attribute = unum_getAttribute_52(fmt : UNumberFormat*, attr : UNumberFormatAttribute) : Int32T
  fun unum_get_available = unum_getAvailable_52(locale_index : Int32T) : LibC::Char*
  fun unum_get_double_attribute = unum_getDoubleAttribute_52(fmt : UNumberFormat*, attr : UNumberFormatAttribute) : LibC::Double
  fun unum_get_locale_by_type = unum_getLocaleByType_52(fmt : UNumberFormat*, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun unum_get_symbol = unum_getSymbol_52(fmt : UNumberFormat*, symbol : UNumberFormatSymbol, buffer : UChar*, size : Int32T, status : UErrorCode*) : Int32T
  fun unum_get_text_attribute = unum_getTextAttribute_52(fmt : UNumberFormat*, tag : UNumberFormatTextAttribute, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun unum_open = unum_open_52(style : UNumberFormatStyle, pattern : UChar*, pattern_length : Int32T, locale : LibC::Char*, parse_err : UParseError*, status : UErrorCode*) : UNumberFormat*
  fun unum_parse = unum_parse_52(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : Int32T
  fun unum_parse_decimal = unum_parseDecimal_52(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, out_buf : LibC::Char*, out_buf_length : Int32T, status : UErrorCode*) : Int32T
  fun unum_parse_double = unum_parseDouble_52(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : LibC::Double
  fun unum_parse_double_currency = unum_parseDoubleCurrency_52(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, currency : UChar*, status : UErrorCode*) : LibC::Double
  fun unum_parse_int64 = unum_parseInt64_52(fmt : UNumberFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : Int64T
  fun unum_parse_to_u_formattable = unum_parseToUFormattable_52(fmt : UNumberFormat*, result : UFormattable*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : UFormattable*
  fun unum_set_attribute = unum_setAttribute_52(fmt : UNumberFormat*, attr : UNumberFormatAttribute, new_value : Int32T)
  fun unum_set_double_attribute = unum_setDoubleAttribute_52(fmt : UNumberFormat*, attr : UNumberFormatAttribute, new_value : LibC::Double)
  fun unum_set_symbol = unum_setSymbol_52(fmt : UNumberFormat*, symbol : UNumberFormatSymbol, value : UChar*, length : Int32T, status : UErrorCode*)
  fun unum_set_text_attribute = unum_setTextAttribute_52(fmt : UNumberFormat*, tag : UNumberFormatTextAttribute, new_value : UChar*, new_value_length : Int32T, status : UErrorCode*)
  fun unum_to_pattern = unum_toPattern_52(fmt : UNumberFormat*, is_pattern_localized : UBool, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
end
