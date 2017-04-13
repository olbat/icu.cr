@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  enum URestrictionLevel
    UspoofAscii                 =  268435456
    UspoofHighlyRestrictive     =  536870912
    UspoofModeratelyRestrictive =  805306368
    UspoofMinimallyRestrictive  = 1073741824
    UspoofUnrestrictive         = 1342177280
  end
  fun uspoof_are_confusable = uspoof_areConfusable_52(sc : USpoofChecker, id1 : UChar*, length1 : Int32T, id2 : UChar*, length2 : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_are_confusable_ut_f8 = uspoof_areConfusableUTF8_52(sc : USpoofChecker, id1 : LibC::Char*, length1 : Int32T, id2 : LibC::Char*, length2 : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_check = uspoof_check_52(sc : USpoofChecker, id : UChar*, length : Int32T, position : Int32T*, status : UErrorCode*) : Int32T
  fun uspoof_check_ut_f8 = uspoof_checkUTF8_52(sc : USpoofChecker, id : LibC::Char*, length : Int32T, position : Int32T*, status : UErrorCode*) : Int32T
  fun uspoof_clone = uspoof_clone_52(sc : USpoofChecker, status : UErrorCode*) : USpoofChecker
  fun uspoof_close = uspoof_close_52(sc : USpoofChecker)
  fun uspoof_get_allowed_chars = uspoof_getAllowedChars_52(sc : USpoofChecker, status : UErrorCode*) : USet
  fun uspoof_get_allowed_locales = uspoof_getAllowedLocales_52(sc : USpoofChecker, status : UErrorCode*) : LibC::Char*
  fun uspoof_get_checks = uspoof_getChecks_52(sc : USpoofChecker, status : UErrorCode*) : Int32T
  fun uspoof_get_inclusion_set = uspoof_getInclusionSet_52(status : UErrorCode*) : USet
  fun uspoof_get_recommended_set = uspoof_getRecommendedSet_52(status : UErrorCode*) : USet
  fun uspoof_get_restriction_level = uspoof_getRestrictionLevel_52(sc : USpoofChecker) : URestrictionLevel
  fun uspoof_get_skeleton = uspoof_getSkeleton_52(sc : USpoofChecker, type : Uint32T, id : UChar*, length : Int32T, dest : UChar*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_get_skeleton_ut_f8 = uspoof_getSkeletonUTF8_52(sc : USpoofChecker, type : Uint32T, id : LibC::Char*, length : Int32T, dest : LibC::Char*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_open = uspoof_open_52(status : UErrorCode*) : USpoofChecker
  fun uspoof_open_from_serialized = uspoof_openFromSerialized_52(data : Void*, length : Int32T, p_actual_length : Int32T*, p_error_code : UErrorCode*) : USpoofChecker
  fun uspoof_open_from_source = uspoof_openFromSource_52(confusables : LibC::Char*, confusables_len : Int32T, confusables_whole_script : LibC::Char*, confusables_whole_script_len : Int32T, err_type : Int32T*, pe : UParseError*, status : UErrorCode*) : USpoofChecker
  fun uspoof_serialize = uspoof_serialize_52(sc : USpoofChecker, data : Void*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun uspoof_set_allowed_chars = uspoof_setAllowedChars_52(sc : USpoofChecker, chars : USet, status : UErrorCode*)
  fun uspoof_set_allowed_locales = uspoof_setAllowedLocales_52(sc : USpoofChecker, locales_list : LibC::Char*, status : UErrorCode*)
  fun uspoof_set_checks = uspoof_setChecks_52(sc : USpoofChecker, checks : Int32T, status : UErrorCode*)
  fun uspoof_set_restriction_level = uspoof_setRestrictionLevel_52(sc : USpoofChecker, restriction_level : URestrictionLevel)
  type USpoofChecker = Void*
end
