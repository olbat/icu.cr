@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  enum UCalendarAttribute
    UcalLenient                = 0
    UcalFirstDayOfWeek         = 1
    UcalMinimalDaysInFirstWeek = 2
    UcalRepeatedWallTime       = 3
    UcalSkippedWallTime        = 4
  end
  enum UCalendarDaysOfWeek
    UcalSunday    = 1
    UcalMonday    = 2
    UcalTuesday   = 3
    UcalWednesday = 4
    UcalThursday  = 5
    UcalFriday    = 6
    UcalSaturday  = 7
  end
  enum UCalendarDisplayNameType
    UcalStandard      = 0
    UcalShortStandard = 1
    UcalDst           = 2
    UcalShortDst      = 3
  end
  enum UCalendarLimitType
    UcalMinimum         = 0
    UcalMaximum         = 1
    UcalGreatestMinimum = 2
    UcalLeastMaximum    = 3
    UcalActualMinimum   = 4
    UcalActualMaximum   = 5
  end
  enum UCalendarType
    UcalTraditional = 0
    UcalDefault     = 0
    UcalGregorian   = 1
  end
  enum UCalendarWeekdayType
    UcalWeekday      = 0
    UcalWeekend      = 1
    UcalWeekendOnset = 2
    UcalWeekendCease = 3
  end
  enum USystemTimeZoneType
    UcalZoneTypeAny               = 0
    UcalZoneTypeCanonical         = 1
    UcalZoneTypeCanonicalLocation = 2
  end
  enum UTimeZoneTransitionType
    UcalTzTransitionNext              = 0
    UcalTzTransitionNextInclusive     = 1
    UcalTzTransitionPrevious          = 2
    UcalTzTransitionPreviousInclusive = 3
  end
  fun ucal_add = ucal_add_52(cal : UCalendar*, field : UCalendarDateFields, amount : Int32T, status : UErrorCode*)
  fun ucal_clear = ucal_clear_52(calendar : UCalendar*)
  fun ucal_clear_field = ucal_clearField_52(cal : UCalendar*, field : UCalendarDateFields)
  fun ucal_clone = ucal_clone_52(cal : UCalendar*, status : UErrorCode*) : UCalendar*
  fun ucal_close = ucal_close_52(cal : UCalendar*)
  fun ucal_count_available = ucal_countAvailable_52 : Int32T
  fun ucal_equivalent_to = ucal_equivalentTo_52(cal1 : UCalendar*, cal2 : UCalendar*) : UBool
  fun ucal_get = ucal_get_52(cal : UCalendar*, field : UCalendarDateFields, status : UErrorCode*) : Int32T
  fun ucal_get_attribute = ucal_getAttribute_52(cal : UCalendar*, attr : UCalendarAttribute) : Int32T
  fun ucal_get_available = ucal_getAvailable_52(locale_index : Int32T) : LibC::Char*
  fun ucal_get_canonical_time_zone_id = ucal_getCanonicalTimeZoneID_52(id : UChar*, len : Int32T, result : UChar*, result_capacity : Int32T, is_system_id : UBool*, status : UErrorCode*) : Int32T
  fun ucal_get_day_of_week_type = ucal_getDayOfWeekType_52(cal : UCalendar*, day_of_week : UCalendarDaysOfWeek, status : UErrorCode*) : UCalendarWeekdayType
  fun ucal_get_default_time_zone = ucal_getDefaultTimeZone_52(result : UChar*, result_capacity : Int32T, ec : UErrorCode*) : Int32T
  fun ucal_get_dst_savings = ucal_getDSTSavings_52(zone_id : UChar*, ec : UErrorCode*) : Int32T
  fun ucal_get_field_difference = ucal_getFieldDifference_52(cal : UCalendar*, target : UDate, field : UCalendarDateFields, status : UErrorCode*) : Int32T
  fun ucal_get_gregorian_change = ucal_getGregorianChange_52(cal : UCalendar*, p_error_code : UErrorCode*) : UDate
  fun ucal_get_keyword_values_for_locale = ucal_getKeywordValuesForLocale_52(key : LibC::Char*, locale : LibC::Char*, commonly_used : UBool, status : UErrorCode*) : UEnumeration
  fun ucal_get_limit = ucal_getLimit_52(cal : UCalendar*, field : UCalendarDateFields, type : UCalendarLimitType, status : UErrorCode*) : Int32T
  fun ucal_get_locale_by_type = ucal_getLocaleByType_52(cal : UCalendar*, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun ucal_get_millis = ucal_getMillis_52(cal : UCalendar*, status : UErrorCode*) : UDate
  fun ucal_get_now = ucal_getNow_52 : UDate
  fun ucal_get_time_zone_display_name = ucal_getTimeZoneDisplayName_52(cal : UCalendar*, type : UCalendarDisplayNameType, locale : LibC::Char*, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ucal_get_time_zone_id = ucal_getTimeZoneID_52(cal : UCalendar*, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ucal_get_time_zone_id_for_windows_id = ucal_getTimeZoneIDForWindowsID_52(winid : UChar*, len : Int32T, region : LibC::Char*, id : UChar*, id_capacity : Int32T, status : UErrorCode*) : Int32T
  fun ucal_get_time_zone_transition_date = ucal_getTimeZoneTransitionDate_52(cal : UCalendar*, type : UTimeZoneTransitionType, transition : UDate*, status : UErrorCode*) : UBool
  fun ucal_get_type = ucal_getType_52(cal : UCalendar*, status : UErrorCode*) : LibC::Char*
  fun ucal_get_tz_data_version = ucal_getTZDataVersion_52(status : UErrorCode*) : LibC::Char*
  fun ucal_get_weekend_transition = ucal_getWeekendTransition_52(cal : UCalendar*, day_of_week : UCalendarDaysOfWeek, status : UErrorCode*) : Int32T
  fun ucal_get_windows_time_zone_id = ucal_getWindowsTimeZoneID_52(id : UChar*, len : Int32T, winid : UChar*, winid_capacity : Int32T, status : UErrorCode*) : Int32T
  fun ucal_in_daylight_time = ucal_inDaylightTime_52(cal : UCalendar*, status : UErrorCode*) : UBool
  fun ucal_is_set = ucal_isSet_52(cal : UCalendar*, field : UCalendarDateFields) : UBool
  fun ucal_is_weekend = ucal_isWeekend_52(cal : UCalendar*, date : UDate, status : UErrorCode*) : UBool
  fun ucal_open = ucal_open_52(zone_id : UChar*, len : Int32T, locale : LibC::Char*, type : UCalendarType, status : UErrorCode*) : UCalendar*
  fun ucal_open_country_time_zones = ucal_openCountryTimeZones_52(country : LibC::Char*, ec : UErrorCode*) : UEnumeration
  fun ucal_open_time_zone_id_enumeration = ucal_openTimeZoneIDEnumeration_52(zone_type : USystemTimeZoneType, region : LibC::Char*, raw_offset : Int32T*, ec : UErrorCode*) : UEnumeration
  fun ucal_open_time_zones = ucal_openTimeZones_52(ec : UErrorCode*) : UEnumeration
  fun ucal_roll = ucal_roll_52(cal : UCalendar*, field : UCalendarDateFields, amount : Int32T, status : UErrorCode*)
  fun ucal_set = ucal_set_52(cal : UCalendar*, field : UCalendarDateFields, value : Int32T)
  fun ucal_set_attribute = ucal_setAttribute_52(cal : UCalendar*, attr : UCalendarAttribute, new_value : Int32T)
  fun ucal_set_date = ucal_setDate_52(cal : UCalendar*, year : Int32T, month : Int32T, date : Int32T, status : UErrorCode*)
  fun ucal_set_date_time = ucal_setDateTime_52(cal : UCalendar*, year : Int32T, month : Int32T, date : Int32T, hour : Int32T, minute : Int32T, second : Int32T, status : UErrorCode*)
  fun ucal_set_default_time_zone = ucal_setDefaultTimeZone_52(zone_id : UChar*, ec : UErrorCode*)
  fun ucal_set_gregorian_change = ucal_setGregorianChange_52(cal : UCalendar*, date : UDate, p_error_code : UErrorCode*)
  fun ucal_set_millis = ucal_setMillis_52(cal : UCalendar*, date_time : UDate, status : UErrorCode*)
  fun ucal_set_time_zone = ucal_setTimeZone_52(cal : UCalendar*, zone_id : UChar*, len : Int32T, status : UErrorCode*)
end
