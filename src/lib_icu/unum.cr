@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UNumberFormatAttribute
    ParseIntOnly                  =    0
    GroupingUsed                  =    1
    DecimalAlwaysShown            =    2
    MaxIntegerDigits              =    3
    MinIntegerDigits              =    4
    IntegerDigits                 =    5
    MaxFractionDigits             =    6
    MinFractionDigits             =    7
    FractionDigits                =    8
    Multiplier                    =    9
    GroupingSize                  =   10
    RoundingMode                  =   11
    RoundingIncrement             =   12
    FormatWidth                   =   13
    PaddingPosition               =   14
    SecondaryGroupingSize         =   15
    SignificantDigitsUsed         =   16
    MinSignificantDigits          =   17
    MaxSignificantDigits          =   18
    LenientParse                  =   19
    ParseAllInput                 =   20
    Scale                         =   21
    NumericAttributeCount         =   22
    MaxNonbooleanAttribute        = 4095
    FormatFailIfMoreThanMaxDigits = 4096
    ParseNoExponent               = 4097
    LimitBooleanAttribute         = 4098
  end
  enum UNumberFormatStyle
    PatternDecimal   =  0
    Decimal          =  1
    Currency         =  2
    Percent          =  3
    Scientific       =  4
    Spellout         =  5
    Ordinal          =  6
    Duration         =  7
    NumberingSystem  =  8
    PatternRulebased =  9
    CurrencyIso      = 10
    CurrencyPlural   = 11
    FormatStyleCount = 12
    Default          =  1
    Ignore           =  0
  end
  enum UNumberFormatSymbol
    DecimalSeparatorSymbol          =  0
    GroupingSeparatorSymbol         =  1
    PatternSeparatorSymbol          =  2
    PercentSymbol                   =  3
    ZeroDigitSymbol                 =  4
    DigitSymbol                     =  5
    MinusSignSymbol                 =  6
    PlusSignSymbol                  =  7
    CurrencySymbol                  =  8
    IntlCurrencySymbol              =  9
    MonetarySeparatorSymbol         = 10
    ExponentialSymbol               = 11
    PermillSymbol                   = 12
    PadEscapeSymbol                 = 13
    InfinitySymbol                  = 14
    NanSymbol                       = 15
    SignificantDigitSymbol          = 16
    MonetaryGroupingSeparatorSymbol = 17
    OneDigitSymbol                  = 18
    TwoDigitSymbol                  = 19
    ThreeDigitSymbol                = 20
    FourDigitSymbol                 = 21
    FiveDigitSymbol                 = 22
    SixDigitSymbol                  = 23
    SevenDigitSymbol                = 24
    EightDigitSymbol                = 25
    NineDigitSymbol                 = 26
    FormatSymbolCount               = 27
  end
  enum UNumberFormatTextAttribute
    PositivePrefix   = 0
    PositiveSuffix   = 1
    NegativePrefix   = 2
    NegativeSuffix   = 3
    PaddingCharacter = 4
    CurrencyCode     = 5
    DefaultRuleset   = 6
    PublicRulesets   = 7
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
