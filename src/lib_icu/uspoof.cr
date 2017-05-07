@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum URestrictionLevel
    Ascii                 =  268435456
    HighlyRestrictive     =  536870912
    ModeratelyRestrictive =  805306368
    MinimallyRestrictive  = 1073741824
    Unrestrictive         = 1342177280
  end
  fun uspoof_are_confusable = uspoof_areConfusable{{SYMS_SUFFIX.id}}(sc : USpoofChecker, id1 : UChar*, length1 : Int32T, id2 : UChar*, length2 : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_are_confusable_ut_f8 = uspoof_areConfusableUTF8{{SYMS_SUFFIX.id}}(sc : USpoofChecker, id1 : LibC::Char*, length1 : Int32T, id2 : LibC::Char*, length2 : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_check = uspoof_check{{SYMS_SUFFIX.id}}(sc : USpoofChecker, id : UChar*, length : Int32T, position : Int32T*, status : UErrorCode*) : Int32T
  fun uspoof_check_ut_f8 = uspoof_checkUTF8{{SYMS_SUFFIX.id}}(sc : USpoofChecker, id : LibC::Char*, length : Int32T, position : Int32T*, status : UErrorCode*) : Int32T
  fun uspoof_clone = uspoof_clone{{SYMS_SUFFIX.id}}(sc : USpoofChecker, status : UErrorCode*) : USpoofChecker
  fun uspoof_close = uspoof_close{{SYMS_SUFFIX.id}}(sc : USpoofChecker)
  fun uspoof_get_allowed_chars = uspoof_getAllowedChars{{SYMS_SUFFIX.id}}(sc : USpoofChecker, status : UErrorCode*) : USet
  fun uspoof_get_allowed_locales = uspoof_getAllowedLocales{{SYMS_SUFFIX.id}}(sc : USpoofChecker, status : UErrorCode*) : LibC::Char*
  fun uspoof_get_checks = uspoof_getChecks{{SYMS_SUFFIX.id}}(sc : USpoofChecker, status : UErrorCode*) : Int32T
  fun uspoof_get_inclusion_set = uspoof_getInclusionSet{{SYMS_SUFFIX.id}}(status : UErrorCode*) : USet
  fun uspoof_get_recommended_set = uspoof_getRecommendedSet{{SYMS_SUFFIX.id}}(status : UErrorCode*) : USet
  fun uspoof_get_restriction_level = uspoof_getRestrictionLevel{{SYMS_SUFFIX.id}}(sc : USpoofChecker) : URestrictionLevel
  fun uspoof_get_skeleton = uspoof_getSkeleton{{SYMS_SUFFIX.id}}(sc : USpoofChecker, type : Uint32T, id : UChar*, length : Int32T, dest : UChar*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_get_skeleton_ut_f8 = uspoof_getSkeletonUTF8{{SYMS_SUFFIX.id}}(sc : USpoofChecker, type : Uint32T, id : LibC::Char*, length : Int32T, dest : LibC::Char*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_open = uspoof_open{{SYMS_SUFFIX.id}}(status : UErrorCode*) : USpoofChecker
  fun uspoof_open_from_serialized = uspoof_openFromSerialized{{SYMS_SUFFIX.id}}(data : Void*, length : Int32T, p_actual_length : Int32T*, p_error_code : UErrorCode*) : USpoofChecker
  fun uspoof_open_from_source = uspoof_openFromSource{{SYMS_SUFFIX.id}}(confusables : LibC::Char*, confusables_len : Int32T, confusables_whole_script : LibC::Char*, confusables_whole_script_len : Int32T, err_type : Int32T*, pe : UParseError*, status : UErrorCode*) : USpoofChecker
  fun uspoof_serialize = uspoof_serialize{{SYMS_SUFFIX.id}}(sc : USpoofChecker, data : Void*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_set_allowed_chars = uspoof_setAllowedChars{{SYMS_SUFFIX.id}}(sc : USpoofChecker, chars : USet, status : UErrorCode*)
  fun uspoof_set_allowed_locales = uspoof_setAllowedLocales{{SYMS_SUFFIX.id}}(sc : USpoofChecker, locales_list : LibC::Char*, status : UErrorCode*)
  fun uspoof_set_checks = uspoof_setChecks{{SYMS_SUFFIX.id}}(sc : USpoofChecker, checks : Int32T, status : UErrorCode*)
  fun uspoof_set_restriction_level = uspoof_setRestrictionLevel{{SYMS_SUFFIX.id}}(sc : USpoofChecker, restriction_level : URestrictionLevel)
  type USpoofChecker = Void*
  {% end %}
end
