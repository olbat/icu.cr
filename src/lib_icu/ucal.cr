@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UCalendarAttribute
    Lenient                = 0
    FirstDayOfWeek         = 1
    MinimalDaysInFirstWeek = 2
    RepeatedWallTime       = 3
    SkippedWallTime        = 4
  end
  enum UCalendarDaysOfWeek
    Sunday    = 1
    Monday    = 2
    Tuesday   = 3
    Wednesday = 4
    Thursday  = 5
    Friday    = 6
    Saturday  = 7
  end
  enum UCalendarDisplayNameType
    Standard      = 0
    ShortStandard = 1
    Dst           = 2
    ShortDst      = 3
  end
  enum UCalendarLimitType
    Minimum         = 0
    Maximum         = 1
    GreatestMinimum = 2
    LeastMaximum    = 3
    ActualMinimum   = 4
    ActualMaximum   = 5
  end
  enum UCalendarType
    Traditional = 0
    Default     = 0
    Gregorian   = 1
  end
  enum UCalendarWeekdayType
    Weekday      = 0
    Weekend      = 1
    WeekendOnset = 2
    WeekendCease = 3
  end
  enum USystemTimeZoneType
    ZoneTypeAny               = 0
    ZoneTypeCanonical         = 1
    ZoneTypeCanonicalLocation = 2
  end
  enum UTimeZoneTransitionType
    TzTransitionNext              = 0
    TzTransitionNextInclusive     = 1
    TzTransitionPrevious          = 2
    TzTransitionPreviousInclusive = 3
  end
  fun ucal_add = ucal_add{{SYMS_SUFFIX.id}}(cal : UCalendar*, field : UCalendarDateFields, amount : Int32T, status : UErrorCode*)
  fun ucal_clear = ucal_clear{{SYMS_SUFFIX.id}}(calendar : UCalendar*)
  fun ucal_clear_field = ucal_clearField{{SYMS_SUFFIX.id}}(cal : UCalendar*, field : UCalendarDateFields)
  fun ucal_clone = ucal_clone{{SYMS_SUFFIX.id}}(cal : UCalendar*, status : UErrorCode*) : UCalendar*
  fun ucal_close = ucal_close{{SYMS_SUFFIX.id}}(cal : UCalendar*)
  fun ucal_count_available = ucal_countAvailable{{SYMS_SUFFIX.id}} : Int32T
  fun ucal_equivalent_to = ucal_equivalentTo{{SYMS_SUFFIX.id}}(cal1 : UCalendar*, cal2 : UCalendar*) : UBool
  fun ucal_get = ucal_get{{SYMS_SUFFIX.id}}(cal : UCalendar*, field : UCalendarDateFields, status : UErrorCode*) : Int32T
  fun ucal_get_attribute = ucal_getAttribute{{SYMS_SUFFIX.id}}(cal : UCalendar*, attr : UCalendarAttribute) : Int32T
  fun ucal_get_available = ucal_getAvailable{{SYMS_SUFFIX.id}}(locale_index : Int32T) : LibC::Char*
  fun ucal_get_canonical_time_zone_id = ucal_getCanonicalTimeZoneID{{SYMS_SUFFIX.id}}(id : UChar*, len : Int32T, result : UChar*, result_capacity : Int32T, is_system_id : UBool*, status : UErrorCode*) : Int32T
  fun ucal_get_day_of_week_type = ucal_getDayOfWeekType{{SYMS_SUFFIX.id}}(cal : UCalendar*, day_of_week : UCalendarDaysOfWeek, status : UErrorCode*) : UCalendarWeekdayType
  fun ucal_get_default_time_zone = ucal_getDefaultTimeZone{{SYMS_SUFFIX.id}}(result : UChar*, result_capacity : Int32T, ec : UErrorCode*) : Int32T
  fun ucal_get_dst_savings = ucal_getDSTSavings{{SYMS_SUFFIX.id}}(zone_id : UChar*, ec : UErrorCode*) : Int32T
  fun ucal_get_field_difference = ucal_getFieldDifference{{SYMS_SUFFIX.id}}(cal : UCalendar*, target : UDate, field : UCalendarDateFields, status : UErrorCode*) : Int32T
  fun ucal_get_gregorian_change = ucal_getGregorianChange{{SYMS_SUFFIX.id}}(cal : UCalendar*, p_error_code : UErrorCode*) : UDate
  fun ucal_get_keyword_values_for_locale = ucal_getKeywordValuesForLocale{{SYMS_SUFFIX.id}}(key : LibC::Char*, locale : LibC::Char*, commonly_used : UBool, status : UErrorCode*) : UEnumeration
  fun ucal_get_limit = ucal_getLimit{{SYMS_SUFFIX.id}}(cal : UCalendar*, field : UCalendarDateFields, type : UCalendarLimitType, status : UErrorCode*) : Int32T
  fun ucal_get_locale_by_type = ucal_getLocaleByType{{SYMS_SUFFIX.id}}(cal : UCalendar*, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun ucal_get_millis = ucal_getMillis{{SYMS_SUFFIX.id}}(cal : UCalendar*, status : UErrorCode*) : UDate
  fun ucal_get_now = ucal_getNow{{SYMS_SUFFIX.id}} : UDate
  fun ucal_get_time_zone_display_name = ucal_getTimeZoneDisplayName{{SYMS_SUFFIX.id}}(cal : UCalendar*, type : UCalendarDisplayNameType, locale : LibC::Char*, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ucal_get_time_zone_id = ucal_getTimeZoneID{{SYMS_SUFFIX.id}}(cal : UCalendar*, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ucal_get_time_zone_id_for_windows_id = ucal_getTimeZoneIDForWindowsID{{SYMS_SUFFIX.id}}(winid : UChar*, len : Int32T, region : LibC::Char*, id : UChar*, id_capacity : Int32T, status : UErrorCode*) : Int32T
  fun ucal_get_time_zone_transition_date = ucal_getTimeZoneTransitionDate{{SYMS_SUFFIX.id}}(cal : UCalendar*, type : UTimeZoneTransitionType, transition : UDate*, status : UErrorCode*) : UBool
  fun ucal_get_type = ucal_getType{{SYMS_SUFFIX.id}}(cal : UCalendar*, status : UErrorCode*) : LibC::Char*
  fun ucal_get_tz_data_version = ucal_getTZDataVersion{{SYMS_SUFFIX.id}}(status : UErrorCode*) : LibC::Char*
  fun ucal_get_weekend_transition = ucal_getWeekendTransition{{SYMS_SUFFIX.id}}(cal : UCalendar*, day_of_week : UCalendarDaysOfWeek, status : UErrorCode*) : Int32T
  fun ucal_get_windows_time_zone_id = ucal_getWindowsTimeZoneID{{SYMS_SUFFIX.id}}(id : UChar*, len : Int32T, winid : UChar*, winid_capacity : Int32T, status : UErrorCode*) : Int32T
  fun ucal_in_daylight_time = ucal_inDaylightTime{{SYMS_SUFFIX.id}}(cal : UCalendar*, status : UErrorCode*) : UBool
  fun ucal_is_set = ucal_isSet{{SYMS_SUFFIX.id}}(cal : UCalendar*, field : UCalendarDateFields) : UBool
  fun ucal_is_weekend = ucal_isWeekend{{SYMS_SUFFIX.id}}(cal : UCalendar*, date : UDate, status : UErrorCode*) : UBool
  fun ucal_open = ucal_open{{SYMS_SUFFIX.id}}(zone_id : UChar*, len : Int32T, locale : LibC::Char*, type : UCalendarType, status : UErrorCode*) : UCalendar*
  fun ucal_open_country_time_zones = ucal_openCountryTimeZones{{SYMS_SUFFIX.id}}(country : LibC::Char*, ec : UErrorCode*) : UEnumeration
  fun ucal_open_time_zone_id_enumeration = ucal_openTimeZoneIDEnumeration{{SYMS_SUFFIX.id}}(zone_type : USystemTimeZoneType, region : LibC::Char*, raw_offset : Int32T*, ec : UErrorCode*) : UEnumeration
  fun ucal_open_time_zones = ucal_openTimeZones{{SYMS_SUFFIX.id}}(ec : UErrorCode*) : UEnumeration
  fun ucal_roll = ucal_roll{{SYMS_SUFFIX.id}}(cal : UCalendar*, field : UCalendarDateFields, amount : Int32T, status : UErrorCode*)
  fun ucal_set = ucal_set{{SYMS_SUFFIX.id}}(cal : UCalendar*, field : UCalendarDateFields, value : Int32T)
  fun ucal_set_attribute = ucal_setAttribute{{SYMS_SUFFIX.id}}(cal : UCalendar*, attr : UCalendarAttribute, new_value : Int32T)
  fun ucal_set_date = ucal_setDate{{SYMS_SUFFIX.id}}(cal : UCalendar*, year : Int32T, month : Int32T, date : Int32T, status : UErrorCode*)
  fun ucal_set_date_time = ucal_setDateTime{{SYMS_SUFFIX.id}}(cal : UCalendar*, year : Int32T, month : Int32T, date : Int32T, hour : Int32T, minute : Int32T, second : Int32T, status : UErrorCode*)
  fun ucal_set_default_time_zone = ucal_setDefaultTimeZone{{SYMS_SUFFIX.id}}(zone_id : UChar*, ec : UErrorCode*)
  fun ucal_set_gregorian_change = ucal_setGregorianChange{{SYMS_SUFFIX.id}}(cal : UCalendar*, date : UDate, p_error_code : UErrorCode*)
  fun ucal_set_millis = ucal_setMillis{{SYMS_SUFFIX.id}}(cal : UCalendar*, date_time : UDate, status : UErrorCode*)
  fun ucal_set_time_zone = ucal_setTimeZone{{SYMS_SUFFIX.id}}(cal : UCalendar*, zone_id : UChar*, len : Int32T, status : UErrorCode*)
  {% end %}
end
