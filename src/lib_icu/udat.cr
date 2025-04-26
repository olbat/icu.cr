@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  alias UDateFormat = Void*
  alias UDateFormatOpener = (UDateFormatStyle, UDateFormatStyle, LibC::Char*, UChar*, Int32T, UChar*, Int32T, UErrorCode* -> UDateFormat*)
  alias UDateTimePatternGenerator = Void*
  enum UDateFormatBooleanAttribute
    ParseAllowWhitespace          = 0
    ParseAllowNumeric             = 1
    ParsePartialLiteralMatch      = 2
    ParseMultiplePatternsForMatch = 3
    BooleanAttributeCount         = 4
  end
  enum UDateFormatField
    EraField                        =  0
    YearField                       =  1
    MonthField                      =  2
    DateField                       =  3
    HourOfDay1Field                 =  4
    HourOfDay0Field                 =  5
    MinuteField                     =  6
    SecondField                     =  7
    FractionalSecondField           =  8
    DayOfWeekField                  =  9
    DayOfYearField                  = 10
    DayOfWeekInMonthField           = 11
    WeekOfYearField                 = 12
    WeekOfMonthField                = 13
    AmPmField                       = 14
    Hour1Field                      = 15
    Hour0Field                      = 16
    TimezoneField                   = 17
    YearWoyField                    = 18
    DowLocalField                   = 19
    ExtendedYearField               = 20
    JulianDayField                  = 21
    MillisecondsInDayField          = 22
    TimezoneRfcField                = 23
    TimezoneGenericField            = 24
    StandaloneDayField              = 25
    StandaloneMonthField            = 26
    QuarterField                    = 27
    StandaloneQuarterField          = 28
    TimezoneSpecialField            = 29
    YearNameField                   = 30
    TimezoneLocalizedGmtOffsetField = 31
    TimezoneIsoField                = 32
    TimezoneIsoLocalField           = 33
    RelatedYearField                = 34
    AmPmMidnightNoonField           = 35
    FlexibleDayPeriodField          = 36
    TimeSeparatorField              = 37
    FieldCount                      = 38
  end
  enum UDateFormatHourCycle
    HourCycle11 = 0
    HourCycle12 = 1
    HourCycle23 = 2
    HourCycle24 = 3
  end
  enum UDateFormatStyle
    Full           =   0
    Long           =   1
    Medium         =   2
    Short          =   3
    Default        =   2
    Relative       = 128
    FullRelative   = 128
    LongRelative   = 129
    MediumRelative = 130
    ShortRelative  = 131
    None           =  -1
    Pattern        =  -2
    Ignore         =  -2
  end
  enum UDateFormatSymbolType
    Eras                      =  0
    Months                    =  1
    ShortMonths               =  2
    Weekdays                  =  3
    ShortWeekdays             =  4
    AmPms                     =  5
    LocalizedChars            =  6
    EraNames                  =  7
    NarrowMonths              =  8
    NarrowWeekdays            =  9
    StandaloneMonths          = 10
    StandaloneShortMonths     = 11
    StandaloneNarrowMonths    = 12
    StandaloneWeekdays        = 13
    StandaloneShortWeekdays   = 14
    StandaloneNarrowWeekdays  = 15
    Quarters                  = 16
    ShortQuarters             = 17
    StandaloneQuarters        = 18
    StandaloneShortQuarters   = 19
    ShorterWeekdays           = 20
    StandaloneShorterWeekdays = 21
    CyclicYearsWide           = 22
    CyclicYearsAbbreviated    = 23
    CyclicYearsNarrow         = 24
    ZodiacNamesWide           = 25
    ZodiacNamesAbbreviated    = 26
    ZodiacNamesNarrow         = 27
    NarrowQuarters            = 28
    StandaloneNarrowQuarters  = 29
  end
  enum UDateTimePatternConflict
    NoConflict    = 0
    BaseConflict  = 1
    Conflict      = 2
    ConflictCount = 3
  end
  enum UDateTimePatternField
    EraField              =  0
    YearField             =  1
    QuarterField          =  2
    MonthField            =  3
    WeekOfYearField       =  4
    WeekOfMonthField      =  5
    WeekdayField          =  6
    DayOfYearField        =  7
    DayOfWeekInMonthField =  8
    DayField              =  9
    DayperiodField        = 10
    HourField             = 11
    MinuteField           = 12
    SecondField           = 13
    FractionalSecondField = 14
    ZoneField             = 15
    FieldCount            = 16
  end
  enum UDateTimePatternMatchOptions
    MatchNoOptions         =     0
    MatchHourFieldLength   =  2048
    MatchMinuteFieldLength =  4096
    MatchSecondFieldLength =  8192
    MatchAllFieldsLength   = 65535
  end
  enum UDateTimePgDisplayWidth
    Wide        = 0
    Abbreviated = 1
    Narrow      = 2
  end
  fun udat_adopt_number_format = udat_adoptNumberFormat{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, number_format_to_adopt : UNumberFormat*)
  fun udat_adopt_number_format_for_fields = udat_adoptNumberFormatForFields{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, fields : UChar*, number_format_to_set : UNumberFormat*, status : UErrorCode*)
  fun udat_apply_pattern = udat_applyPattern{{SYMS_SUFFIX.id}}(format : UDateFormat*, localized : UBool, pattern : UChar*, pattern_length : Int32T)
  fun udat_apply_pattern_relative = udat_applyPatternRelative{{SYMS_SUFFIX.id}}(format : UDateFormat*, date_pattern : UChar*, date_pattern_length : Int32T, time_pattern : UChar*, time_pattern_length : Int32T, status : UErrorCode*)
  fun udat_clone = udat_clone{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, status : UErrorCode*) : UDateFormat*
  fun udat_close = udat_close{{SYMS_SUFFIX.id}}(format : UDateFormat*)
  fun udat_count_available = udat_countAvailable{{SYMS_SUFFIX.id}} : Int32T
  fun udat_count_symbols = udat_countSymbols{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, type : UDateFormatSymbolType) : Int32T
  fun udat_format = udat_format{{SYMS_SUFFIX.id}}(format : UDateFormat*, date_to_format : UDate, result : UChar*, result_length : Int32T, position : UFieldPosition*, status : UErrorCode*) : Int32T
  fun udat_format_calendar = udat_formatCalendar{{SYMS_SUFFIX.id}}(format : UDateFormat*, calendar : UCalendar*, result : UChar*, capacity : Int32T, position : UFieldPosition*, status : UErrorCode*) : Int32T
  fun udat_format_calendar_for_fields = udat_formatCalendarForFields{{SYMS_SUFFIX.id}}(format : UDateFormat*, calendar : UCalendar*, result : UChar*, capacity : Int32T, fpositer : UFieldPositionIterator, status : UErrorCode*) : Int32T
  fun udat_format_for_fields = udat_formatForFields{{SYMS_SUFFIX.id}}(format : UDateFormat*, date_to_format : UDate, result : UChar*, result_length : Int32T, fpositer : UFieldPositionIterator, status : UErrorCode*) : Int32T
  fun udat_get2_digit_year_start = udat_get2DigitYearStart{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, status : UErrorCode*) : UDate
  fun udat_get_available = udat_getAvailable{{SYMS_SUFFIX.id}}(locale_index : Int32T) : LibC::Char*
  fun udat_get_boolean_attribute = udat_getBooleanAttribute{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, attr : UDateFormatBooleanAttribute, status : UErrorCode*) : UBool
  fun udat_get_calendar = udat_getCalendar{{SYMS_SUFFIX.id}}(fmt : UDateFormat*) : UCalendar*
  fun udat_get_context = udat_getContext{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, type : UDisplayContextType, status : UErrorCode*) : UDisplayContext
  fun udat_get_locale_by_type = udat_getLocaleByType{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun udat_get_number_format = udat_getNumberFormat{{SYMS_SUFFIX.id}}(fmt : UDateFormat*) : UNumberFormat*
  fun udat_get_number_format_for_field = udat_getNumberFormatForField{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, field : UChar) : UNumberFormat*
  fun udat_get_symbols = udat_getSymbols{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, type : UDateFormatSymbolType, symbol_index : Int32T, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun udat_is_lenient = udat_isLenient{{SYMS_SUFFIX.id}}(fmt : UDateFormat*) : UBool
  fun udat_open = udat_open{{SYMS_SUFFIX.id}}(time_style : UDateFormatStyle, date_style : UDateFormatStyle, locale : LibC::Char*, tz_id : UChar*, tz_id_length : Int32T, pattern : UChar*, pattern_length : Int32T, status : UErrorCode*) : UDateFormat*
  fun udat_parse = udat_parse{{SYMS_SUFFIX.id}}(format : UDateFormat*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*) : UDate
  fun udat_parse_calendar = udat_parseCalendar{{SYMS_SUFFIX.id}}(format : UDateFormat*, calendar : UCalendar*, text : UChar*, text_length : Int32T, parse_pos : Int32T*, status : UErrorCode*)
  fun udat_register_opener = udat_registerOpener{{SYMS_SUFFIX.id}}(opener : UDateFormatOpener, status : UErrorCode*)
  fun udat_set2_digit_year_start = udat_set2DigitYearStart{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, d : UDate, status : UErrorCode*)
  fun udat_set_boolean_attribute = udat_setBooleanAttribute{{SYMS_SUFFIX.id}}(fmt : UDateFormat*, attr : UDateFormatBooleanAttribute, new_value : UBool, status : UErrorCode*)
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
  fun udatpg_get_base_skeleton = udatpg_getBaseSkeleton{{SYMS_SUFFIX.id}}(unused_dtpg : UDateTimePatternGenerator*, pattern : UChar*, length : Int32T, base_skeleton : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_get_best_pattern = udatpg_getBestPattern{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, skeleton : UChar*, length : Int32T, best_pattern : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_get_best_pattern_with_options = udatpg_getBestPatternWithOptions{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, skeleton : UChar*, length : Int32T, options : UDateTimePatternMatchOptions, best_pattern : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_get_date_time_format = udatpg_getDateTimeFormat{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_length : Int32T*) : UChar*
  fun udatpg_get_date_time_format_for_style = udatpg_getDateTimeFormatForStyle{{SYMS_SUFFIX.id}}(udtpg : UDateTimePatternGenerator*, style : UDateFormatStyle, p_length : Int32T*, p_error_code : UErrorCode*) : UChar*
  fun udatpg_get_decimal = udatpg_getDecimal{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_length : Int32T*) : UChar*
  fun udatpg_get_default_hour_cycle = udatpg_getDefaultHourCycle{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_error_code : UErrorCode*) : UDateFormatHourCycle
  fun udatpg_get_field_display_name = udatpg_getFieldDisplayName{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, field : UDateTimePatternField, width : UDateTimePgDisplayWidth, field_name : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_get_pattern_for_skeleton = udatpg_getPatternForSkeleton{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, skeleton : UChar*, skeleton_length : Int32T, p_length : Int32T*) : UChar*
  fun udatpg_get_skeleton = udatpg_getSkeleton{{SYMS_SUFFIX.id}}(unused_dtpg : UDateTimePatternGenerator*, pattern : UChar*, length : Int32T, skeleton : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_open = udatpg_open{{SYMS_SUFFIX.id}}(locale : LibC::Char*, p_error_code : UErrorCode*) : UDateTimePatternGenerator*
  fun udatpg_open_base_skeletons = udatpg_openBaseSkeletons{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_error_code : UErrorCode*) : UEnumeration
  fun udatpg_open_empty = udatpg_openEmpty{{SYMS_SUFFIX.id}}(p_error_code : UErrorCode*) : UDateTimePatternGenerator*
  fun udatpg_open_skeletons = udatpg_openSkeletons{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, p_error_code : UErrorCode*) : UEnumeration
  fun udatpg_replace_field_types = udatpg_replaceFieldTypes{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, pattern : UChar*, pattern_length : Int32T, skeleton : UChar*, skeleton_length : Int32T, dest : UChar*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_replace_field_types_with_options = udatpg_replaceFieldTypesWithOptions{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, pattern : UChar*, pattern_length : Int32T, skeleton : UChar*, skeleton_length : Int32T, options : UDateTimePatternMatchOptions, dest : UChar*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun udatpg_set_append_item_format = udatpg_setAppendItemFormat{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, field : UDateTimePatternField, value : UChar*, length : Int32T)
  fun udatpg_set_append_item_name = udatpg_setAppendItemName{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, field : UDateTimePatternField, value : UChar*, length : Int32T)
  fun udatpg_set_date_time_format = udatpg_setDateTimeFormat{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, dt_format : UChar*, length : Int32T)
  fun udatpg_set_date_time_format_for_style = udatpg_setDateTimeFormatForStyle{{SYMS_SUFFIX.id}}(udtpg : UDateTimePatternGenerator*, style : UDateFormatStyle, date_time_format : UChar*, length : Int32T, p_error_code : UErrorCode*)
  fun udatpg_set_decimal = udatpg_setDecimal{{SYMS_SUFFIX.id}}(dtpg : UDateTimePatternGenerator*, decimal : UChar*, length : Int32T)
  fun udtitvfmt_close = udtitvfmt_close{{SYMS_SUFFIX.id}}(formatter : UDateIntervalFormat)
  fun udtitvfmt_close_result = udtitvfmt_closeResult{{SYMS_SUFFIX.id}}(uresult : UFormattedDateInterval)
  fun udtitvfmt_format = udtitvfmt_format{{SYMS_SUFFIX.id}}(formatter : UDateIntervalFormat, from_date : UDate, to_date : UDate, result : UChar*, result_capacity : Int32T, position : UFieldPosition*, status : UErrorCode*) : Int32T
  fun udtitvfmt_format_calendar_to_result = udtitvfmt_formatCalendarToResult{{SYMS_SUFFIX.id}}(formatter : UDateIntervalFormat, from_calendar : UCalendar*, to_calendar : UCalendar*, result : UFormattedDateInterval, status : UErrorCode*)
  fun udtitvfmt_format_to_result = udtitvfmt_formatToResult{{SYMS_SUFFIX.id}}(formatter : UDateIntervalFormat, from_date : UDate, to_date : UDate, result : UFormattedDateInterval, status : UErrorCode*)
  fun udtitvfmt_get_context = udtitvfmt_getContext{{SYMS_SUFFIX.id}}(formatter : UDateIntervalFormat, type : UDisplayContextType, status : UErrorCode*) : UDisplayContext
  fun udtitvfmt_open = udtitvfmt_open{{SYMS_SUFFIX.id}}(locale : LibC::Char*, skeleton : UChar*, skeleton_length : Int32T, tz_id : UChar*, tz_id_length : Int32T, status : UErrorCode*) : UDateIntervalFormat
  fun udtitvfmt_open_result = udtitvfmt_openResult{{SYMS_SUFFIX.id}}(ec : UErrorCode*) : UFormattedDateInterval
  fun udtitvfmt_result_as_value = udtitvfmt_resultAsValue{{SYMS_SUFFIX.id}}(uresult : UFormattedDateInterval, ec : UErrorCode*) : UFormattedValue
  fun udtitvfmt_set_context = udtitvfmt_setContext{{SYMS_SUFFIX.id}}(formatter : UDateIntervalFormat, value : UDisplayContext, status : UErrorCode*)
  type UDateIntervalFormat = Void*
  type UFormattedDateInterval = Void*
  type UFormattedValue = Void*
  {% end %}
end
