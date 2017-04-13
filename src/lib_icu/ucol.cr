@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  alias UCollationStrength = UColAttributeValue
  enum UColAttribute
    UcolFrenchCollation        = 0
    UcolAlternateHandling      = 1
    UcolCaseFirst              = 2
    UcolCaseLevel              = 3
    UcolNormalizationMode      = 4
    UcolDecompositionMode      = 4
    UcolStrength               = 5
    UcolHiraganaQuaternaryMode = 6
    UcolNumericCollation       = 7
    UcolAttributeCount         = 8
  end
  enum UColAttributeValue
    UcolDefault             = -1
    UcolPrimary             =  0
    UcolSecondary           =  1
    UcolTertiary            =  2
    UcolDefaultStrength     =  2
    UcolCeStrengthLimit     =  3
    UcolQuaternary          =  3
    UcolIdentical           = 15
    UcolStrengthLimit       = 16
    UcolOff                 = 16
    UcolOn                  = 17
    UcolShifted             = 20
    UcolNonIgnorable        = 21
    UcolLowerFirst          = 24
    UcolUpperFirst          = 25
    UcolAttributeValueCount = 26
  end
  enum UColBoundMode
    UcolBoundLower      = 0
    UcolBoundUpper      = 1
    UcolBoundUpperLong  = 2
    UcolBoundValueCount = 3
  end
  enum UColRuleOption
    UcolTailoringOnly = 0
    UcolFullRules     = 1
  end
  enum UCollationResult
    UcolEqual   =  0
    UcolGreater =  1
    UcolLess    = -1
  end
  fun ucol_clone_binary = ucol_cloneBinary_52(coll : UCollator, buffer : Uint8T*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun ucol_close = ucol_close_52(coll : UCollator)
  fun ucol_count_available = ucol_countAvailable_52 : Int32T
  fun ucol_equal = ucol_equal_52(coll : UCollator, source : UChar*, source_length : Int32T, target : UChar*, target_length : Int32T) : UBool
  fun ucol_equals = ucol_equals_52(source : UCollator, target : UCollator) : UBool
  fun ucol_forget_uca = ucol_forgetUCA_52
  fun ucol_get_attribute = ucol_getAttribute_52(coll : UCollator, attr : UColAttribute, status : UErrorCode*) : UColAttributeValue
  fun ucol_get_attribute_or_default = ucol_getAttributeOrDefault_52(coll : UCollator, attr : UColAttribute, status : UErrorCode*) : UColAttributeValue
  fun ucol_get_available = ucol_getAvailable_52(locale_index : Int32T) : LibC::Char*
  fun ucol_get_bound = ucol_getBound_52(source : Uint8T*, source_length : Int32T, bound_type : UColBoundMode, no_of_levels : Uint32T, result : Uint8T*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ucol_get_contractions = ucol_getContractions_52(coll : UCollator, conts : USet, status : UErrorCode*) : Int32T
  fun ucol_get_contractions_and_expansions = ucol_getContractionsAndExpansions_52(coll : UCollator, contractions : USet, expansions : USet, add_prefixes : UBool, status : UErrorCode*)
  fun ucol_get_display_name = ucol_getDisplayName_52(obj_loc : LibC::Char*, disp_loc : LibC::Char*, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ucol_get_equivalent_reorder_codes = ucol_getEquivalentReorderCodes_52(reorder_code : Int32T, dest : Int32T*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucol_get_functional_equivalent = ucol_getFunctionalEquivalent_52(result : LibC::Char*, result_capacity : Int32T, keyword : LibC::Char*, locale : LibC::Char*, is_available : UBool*, status : UErrorCode*) : Int32T
  fun ucol_get_keyword_values = ucol_getKeywordValues_52(keyword : LibC::Char*, status : UErrorCode*) : UEnumeration
  fun ucol_get_keyword_values_for_locale = ucol_getKeywordValuesForLocale_52(key : LibC::Char*, locale : LibC::Char*, commonly_used : UBool, status : UErrorCode*) : UEnumeration
  fun ucol_get_keywords = ucol_getKeywords_52(status : UErrorCode*) : UEnumeration
  fun ucol_get_locale = ucol_getLocale_52(coll : UCollator, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun ucol_get_locale_by_type = ucol_getLocaleByType_52(coll : UCollator, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun ucol_get_reorder_codes = ucol_getReorderCodes_52(coll : UCollator, dest : Int32T*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucol_get_rules = ucol_getRules_52(coll : UCollator, length : Int32T*) : UChar*
  fun ucol_get_rules_ex = ucol_getRulesEx_52(coll : UCollator, delta : UColRuleOption, buffer : UChar*, buffer_len : Int32T) : Int32T
  fun ucol_get_short_definition_string = ucol_getShortDefinitionString_52(coll : UCollator, locale : LibC::Char*, buffer : LibC::Char*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun ucol_get_sort_key = ucol_getSortKey_52(coll : UCollator, source : UChar*, source_length : Int32T, result : Uint8T*, result_length : Int32T) : Int32T
  fun ucol_get_strength = ucol_getStrength_52(coll : UCollator) : UCollationStrength
  fun ucol_get_tailored_set = ucol_getTailoredSet_52(coll : UCollator, status : UErrorCode*) : USet
  fun ucol_get_uca_version = ucol_getUCAVersion_52(coll : UCollator, info : UVersionInfo)
  fun ucol_get_unsafe_set = ucol_getUnsafeSet_52(coll : UCollator, unsafe : USet, status : UErrorCode*) : Int32T
  fun ucol_get_variable_top = ucol_getVariableTop_52(coll : UCollator, status : UErrorCode*) : Uint32T
  fun ucol_get_version = ucol_getVersion_52(coll : UCollator, info : UVersionInfo)
  fun ucol_greater = ucol_greater_52(coll : UCollator, source : UChar*, source_length : Int32T, target : UChar*, target_length : Int32T) : UBool
  fun ucol_greater_or_equal = ucol_greaterOrEqual_52(coll : UCollator, source : UChar*, source_length : Int32T, target : UChar*, target_length : Int32T) : UBool
  fun ucol_merge_sortkeys = ucol_mergeSortkeys_52(src1 : Uint8T*, src1length : Int32T, src2 : Uint8T*, src2length : Int32T, dest : Uint8T*, dest_capacity : Int32T) : Int32T
  fun ucol_next_sort_key_part = ucol_nextSortKeyPart_52(coll : UCollator, iter : UCharIterator*, state : Uint32T[2], dest : Uint8T*, count : Int32T, status : UErrorCode*) : Int32T
  fun ucol_normalize_short_definition_string = ucol_normalizeShortDefinitionString_52(source : LibC::Char*, destination : LibC::Char*, capacity : Int32T, parse_error : UParseError*, status : UErrorCode*) : Int32T
  fun ucol_open = ucol_open_52(loc : LibC::Char*, status : UErrorCode*) : UCollator
  fun ucol_open_available_locales = ucol_openAvailableLocales_52(status : UErrorCode*) : UEnumeration
  fun ucol_open_binary = ucol_openBinary_52(bin : Uint8T*, length : Int32T, base : UCollator, status : UErrorCode*) : UCollator
  fun ucol_open_from_short_string = ucol_openFromShortString_52(definition : LibC::Char*, force_defaults : UBool, parse_error : UParseError*, status : UErrorCode*) : UCollator
  fun ucol_open_rules = ucol_openRules_52(rules : UChar*, rules_length : Int32T, normalization_mode : UColAttributeValue, strength : UCollationStrength, parse_error : UParseError*, status : UErrorCode*) : UCollator
  fun ucol_prepare_short_string_open = ucol_prepareShortStringOpen_52(definition : LibC::Char*, force_defaults : UBool, parse_error : UParseError*, status : UErrorCode*)
  fun ucol_restore_variable_top = ucol_restoreVariableTop_52(coll : UCollator, var_top : Uint32T, status : UErrorCode*)
  fun ucol_safe_clone = ucol_safeClone_52(coll : UCollator, stack_buffer : Void*, p_buffer_size : Int32T*, status : UErrorCode*) : UCollator
  fun ucol_set_attribute = ucol_setAttribute_52(coll : UCollator, attr : UColAttribute, value : UColAttributeValue, status : UErrorCode*)
  fun ucol_set_reorder_codes = ucol_setReorderCodes_52(coll : UCollator, reorder_codes : Int32T*, reorder_codes_length : Int32T, p_error_code : UErrorCode*)
  fun ucol_set_strength = ucol_setStrength_52(coll : UCollator, strength : UCollationStrength)
  fun ucol_set_variable_top = ucol_setVariableTop_52(coll : UCollator, var_top : UChar*, len : Int32T, status : UErrorCode*) : Uint32T
  fun ucol_strcoll = ucol_strcoll_52(coll : UCollator, source : UChar*, source_length : Int32T, target : UChar*, target_length : Int32T) : UCollationResult
  fun ucol_strcoll_iter = ucol_strcollIter_52(coll : UCollator, s_iter : UCharIterator*, t_iter : UCharIterator*, status : UErrorCode*) : UCollationResult
  fun ucol_strcoll_ut_f8 = ucol_strcollUTF8_52(coll : UCollator, source : LibC::Char*, source_length : Int32T, target : LibC::Char*, target_length : Int32T, status : UErrorCode*) : UCollationResult
end
