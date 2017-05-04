@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  alias UDateFormat = Void*
  alias UDateFormatOpener = (UDateFormatStyle, UDateFormatStyle, LibC::Char*, UChar*, Int32T, UChar*, Int32T, UErrorCode* -> UDateFormat*)
  alias UDateTimePatternGenerator = Void*
  enum UDateFormatBooleanAttribute
    UdatParseAllowWhitespace  = 0
    UdatParseAllowNumeric     = 1
    UdatBooleanAttributeCount = 2
  end
  enum UDateFormatField
    UdatEraField                        =  0
    UdatYearField                       =  1
    UdatMonthField                      =  2
    UdatDateField                       =  3
    UdatHourOfDaY1Field                 =  4
    UdatHourOfDaY0Field                 =  5
    UdatMinuteField                     =  6
    UdatSecondField                     =  7
    UdatFractionalSecondField           =  8
    UdatDayOfWeekField                  =  9
    UdatDayOfYearField                  = 10
    UdatDayOfWeekInMonthField           = 11
    UdatWeekOfYearField                 = 12
    UdatWeekOfMonthField                = 13
    UdatAmPmField                       = 14
    UdatHouR1Field                      = 15
    UdatHouR0Field                      = 16
    UdatTimezoneField                   = 17
    UdatYearWoyField                    = 18
    UdatDowLocalField                   = 19
    UdatExtendedYearField               = 20
    UdatJulianDayField                  = 21
    UdatMillisecondsInDayField          = 22
    UdatTimezoneRfcField                = 23
    UdatTimezoneGenericField            = 24
    UdatStandaloneDayField              = 25
    UdatStandaloneMonthField            = 26
    UdatQuarterField                    = 27
    UdatStandaloneQuarterField          = 28
    UdatTimezoneSpecialField            = 29
    UdatYearNameField                   = 30
    UdatTimezoneLocalizedGmtOffsetField = 31
    UdatTimezoneIsoField                = 32
    UdatTimezoneIsoLocalField           = 33
    UdatFieldCount                      = 34
  end
  enum UDateFormatStyle
    UdatFull           =   0
    UdatLong           =   1
    UdatMedium         =   2
    UdatShort          =   3
    UdatDefault        =   2
    UdatRelative       = 128
    UdatFullRelative   = 128
    UdatLongRelative   = 129
    UdatMediumRelative = 130
    UdatShortRelative  = 131
    UdatNone           =  -1
    UdatPattern        =  -2
    UdatIgnore         =  -2
  end
  enum UDateFormatSymbolType
    UdatEras                      =  0
    UdatMonths                    =  1
    UdatShortMonths               =  2
    UdatWeekdays                  =  3
    UdatShortWeekdays             =  4
    UdatAmPms                     =  5
    UdatLocalizedChars            =  6
    UdatEraNames                  =  7
    UdatNarrowMonths              =  8
    UdatNarrowWeekdays            =  9
    UdatStandaloneMonths          = 10
    UdatStandaloneShortMonths     = 11
    UdatStandaloneNarrowMonths    = 12
    UdatStandaloneWeekdays        = 13
    UdatStandaloneShortWeekdays   = 14
    UdatStandaloneNarrowWeekdays  = 15
    UdatQuarters                  = 16
    UdatShortQuarters             = 17
    UdatStandaloneQuarters        = 18
    UdatStandaloneShortQuarters   = 19
    UdatShorterWeekdays           = 20
    UdatStandaloneShorterWeekdays = 21
  end
  enum UDateTimePatternConflict
    UdatpgNoConflict    = 0
    UdatpgBaseConflict  = 1
    UdatpgConflict      = 2
    UdatpgConflictCount = 3
  end
  enum UDateTimePatternField
    UdatpgEraField              =  0
    UdatpgYearField             =  1
    UdatpgQuarterField          =  2
    UdatpgMonthField            =  3
    UdatpgWeekOfYearField       =  4
    UdatpgWeekOfMonthField      =  5
    UdatpgWeekdayField          =  6
    UdatpgDayOfYearField        =  7
    UdatpgDayOfWeekInMonthField =  8
    UdatpgDayField              =  9
    UdatpgDayperiodField        = 10
    UdatpgHourField             = 11
    UdatpgMinuteField           = 12
    UdatpgSecondField           = 13
    UdatpgFractionalSecondField = 14
    UdatpgZoneField             = 15
    UdatpgFieldCount            = 16
  end
  enum UDateTimePatternMatchOptions
    UdatpgMatchNoOptions         =     0
    UdatpgMatchHourFieldLength   =  2048
    UdatpgMatchMinuteFieldLength =  4096
    UdatpgMatchSecondFieldLength =  8192
    UdatpgMatchAllFieldsLength   = 65535
  end
  enum UDisplayContext
    UdispctxStandardNames                        =   0
    UdispctxDialectNames                         =   1
    UdispctxCapitalizationNone                   = 256
    UdispctxCapitalizationForMiddleOfSentence    = 257
    UdispctxCapitalizationForBeginningOfSentence = 258
    UdispctxCapitalizationForUiListOrMenu        = 259
    UdispctxCapitalizationForStandalone          = 260
  end
  enum UDisplayContextType
    UdispctxTypeDialectHandling = 0
    UdispctxTypeCapitalization  = 1
  end
  fun udat_apply_pattern = udat_applyPattern{{SYMS_SUFFIX.id}}(format : UDateFormat*, localized : UBool, pattern : UChar*, pattern_length : Int32T)
  fun udat_apply_pattern_relative = udat_applyPatternRelative{{SYMS_SUFFIX.id}}(format : UDateFormat*, date_pattern : UChar*, date_pattern_length : Int32T, time_pattern : UChar*, time_pattern_length : Int32T, status : UErrorCode*)
  fun udat_clone = udat_clone{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, status : UErrorCode*) : UDateFormat*
  fun udat_close = udat_close{{SYMS_SUFFIX.id}}(format : UDateFormat*)
  fun udat_count_available = udat_countAvailable{{SYMS_SUFFIX.id}} : Int32T
  fun udat_count_symbols = udat_countSymbols{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, type : UDateFormatSymbolType) : Int32T
  fun udat_format = udat_format{{SYMS_SUFFIX.id}}(format : UDateFormat*, date_to_format : UDate, result : UChar*, result_length : Int32T, position : UFieldPosition*, status : UErrorCode*) : Int32T
  fun udat_get2digit_year_start = udat_get2DigitYearStart{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, status : UErrorCode*) : UDate
  fun udat_get_available = udat_getAvailable{{SYMS_SUFFIX.id}}(locale_index : Int32T) : LibC::Char*
  fun udat_get_boolean_attribute = udat_getBooleanAttribute{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, attr : UDateFormatBooleanAttribute, status : UErrorCode*) : UBool
  fun udat_get_calendar = udat_getCalendar{{SYMS_SUFFIX.id}}(fmt : UDateFormat*) : UCalendar*
  fun udat_get_context = udat_getContext{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, type : UDisplayContextType, status : UErrorCode*) : UDisplayContext
  fun udat_get_locale_by_type = udat_getLocaleByType{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun udat_get_number_format = udat_getNumberFormat{{SYMS_SUFFIX.id}}(fmt : UDateFormat*) : UNumberFormat*
  fun udat_get_symbols = udat_getSymbols{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, type : UDateFormatSymbolType, symbol_index : Int32T, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun udat_is_lenient = udat_isLenient{{SYMS_SUFFIX.id}}(fmt : UDateFormat*) : UBool
  fun udat_open = udat_open{{SYMS_SUFFIX.id}}(time_style : UDateFormatStyle, date_style : UDateFormatStyle, locale : LibC::Char*, tz_id : UChar*, tz_id_length : Int32T, pattern : UChar*, pattern_length : Int32T, status : UErrorCode*) : UDateFormat*
  fun udat_parse = udat_parse{{SYMS_SUFFIX.id}}(format : UDateFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : UDate
  fun udat_parse_calendar = udat_parseCalendar{{SYMS_SUFFIX.id}}(format : UDateFormat*, calendar : UCalendar*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*)
  fun udat_register_opener = udat_registerOpener{{SYMS_SUFFIX.id}}(opener : UDateFormatOpener, status : UErrorCode*)
  fun udat_set2digit_year_start = udat_set2DigitYearStart{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, d : UDate, status : UErrorCode*)
  fun udat_set_boolean_attribute = udat_setBooleanAttribute{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, attr : UDateFormatBooleanAttribute, x2 : UBool, status : UErrorCode*)
  fun udat_set_calendar = udat_setCalendar{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, calendar_to_set : UCalendar*)
  fun udat_set_context = udat_setContext{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, value : UDisplayContext, status : UErrorCode*)
  fun udat_set_lenient = udat_setLenient{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, is_lenient : UBool)
  fun udat_set_number_format = udat_setNumberFormat{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, number_format_to_set : UNumberFormat*)
  fun udat_set_symbols = udat_setSymbols{{SYMS_SUFFIX.id}}(format : UDateFormat*, type : UDateFormatSymbolType, symbol_index : Int32T, value : UChar*, value_length : Int32T, status : UErrorCode*)
  fun udat_to_calendar_date_field = udat_toCalendarDateField{{SYMS_SUFFIX.id}}(field : UDateFormatField) : UCalendarDateFields
  fun udat_to_pattern = udat_toPattern{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, localized : UBool, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun udat_to_pattern_relative_date = udat_toPatternRelativeDate{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun udat_to_pattern_relative_time = udat_toPatternRelativeTime{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun udat_unregister_opener = udat_unregisterOpener{{SYMS_SUFFIX.id}}(opener : UDateFormatOpener, status : UErrorCode*) : UDateFormatOpener
  fun udatpg_add_pattern = udatpg_addPattern{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, pattern : UChar*, pattern_length : Int32T, override : UBool, conflicting_pattern : UChar*, capacity : Int32T, p_length : Int32T*, p_error_code : UErrorCode*) : UDateTimePatternConflict
  fun udatpg_clone = udatpg_clone{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_error_code : UErrorCode*) : UDateTimePatternGenerator*
  fun udatpg_close = udatpg_close{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*)
  fun udatpg_get_append_item_format = udatpg_getAppendItemFormat{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, field : UDateTimePatternField, p_length : Int32T*) : UChar*
  fun udatpg_get_append_item_name = udatpg_getAppendItemName{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, field : UDateTimePatternField, p_length : Int32T*) : UChar*
  fun udatpg_get_base_skeleton = udatpg_getBaseSkeleton{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, pattern : UChar*, length : Int32T, base_skeleton : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_get_best_pattern = udatpg_getBestPattern{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, skeleton : UChar*, length : Int32T, best_pattern : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_get_best_pattern_with_options = udatpg_getBestPatternWithOptions{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, skeleton : UChar*, length : Int32T, options : UDateTimePatternMatchOptions, best_pattern : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_get_date_time_format = udatpg_getDateTimeFormat{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_length : Int32T*) : UChar*
  fun udatpg_get_decimal = udatpg_getDecimal{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_length : Int32T*) : UChar*
  fun udatpg_get_pattern_for_skeleton = udatpg_getPatternForSkeleton{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, skeleton : UChar*, skeleton_length : Int32T, p_length : Int32T*) : UChar*
  fun udatpg_get_skeleton = udatpg_getSkeleton{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, pattern : UChar*, length : Int32T, skeleton : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_open = udatpg_open{{SYMS_SUFFIX.id}}(locale : LibC::Char*, p_error_code : UErrorCode*) : UDateTimePatternGenerator*
  fun udatpg_open_base_skeletons = udatpg_openBaseSkeletons{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_error_code : UErrorCode*) : UEnumeration
  fun udatpg_open_empty = udatpg_openEmpty{{SYMS_SUFFIX.id}}(p_error_code : UErrorCode*) : UDateTimePatternGenerator*
  fun udatpg_open_skeletons = udatpg_openSkeletons{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_error_code : UErrorCode*) : UEnumeration
  fun udatpg_replace_field_types = udatpg_replaceFieldTypes{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, pattern : UChar*, pattern_length : Int32T, skeleton : UChar*, skeleton_length : Int32T, dest : UChar*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_replace_field_types_with_options = udatpg_replaceFieldTypesWithOptions{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, pattern : UChar*, pattern_length : Int32T, skeleton : UChar*, skeleton_length : Int32T, options : UDateTimePatternMatchOptions, dest : UChar*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_set_append_item_format = udatpg_setAppendItemFormat{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, field : UDateTimePatternField, value : UChar*, length : Int32T)
  fun udatpg_set_append_item_name = udatpg_setAppendItemName{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, field : UDateTimePatternField, value : UChar*, length : Int32T)
  fun udatpg_set_date_time_format = udatpg_setDateTimeFormat{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, dt_format : UChar*, length : Int32T)
  fun udatpg_set_decimal = udatpg_setDecimal{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, decimal : UChar*, length : Int32T)
  fun udtitvfmt_close = udtitvfmt_close{{SYMS_SUFFIX.id}}(formatter : UDateIntervalFormat)
  fun udtitvfmt_format = udtitvfmt_format{{SYMS_SUFFIX.id}}(formatter : UDateIntervalFormat, from_date : UDate, to_date : UDate, result : UChar*, result_capacity : Int32T, position : UFieldPosition*, status : UErrorCode*) : Int32T
  fun udtitvfmt_open = udtitvfmt_open{{SYMS_SUFFIX.id}}(locale : LibC::Char*, skeleton : UChar*, skeleton_length : Int32T, tz_id : UChar*, tz_id_length : Int32T, status : UErrorCode*) : UDateIntervalFormat
  type UDateIntervalFormat = Void*
  {% end %}
end
