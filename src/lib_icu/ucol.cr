@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  alias UCollationStrength = UColAttributeValue
  enum UColAttribute
    FrenchCollation        = 0
    AlternateHandling      = 1
    CaseFirst              = 2
    CaseLevel              = 3
    NormalizationMode      = 4
    DecompositionMode      = 4
    Strength               = 5
    HiraganaQuaternaryMode = 6
    NumericCollation       = 7
    AttributeCount         = 8
  end
  enum UColAttributeValue
    Default             = -1
    Primary             =  0
    Secondary           =  1
    Tertiary            =  2
    DefaultStrength     =  2
    CeStrengthLimit     =  3
    Quaternary          =  3
    Identical           = 15
    StrengthLimit       = 16
    Off                 = 16
    On                  = 17
    Shifted             = 20
    NonIgnorable        = 21
    LowerFirst          = 24
    UpperFirst          = 25
    AttributeValueCount = 26
  end
  enum UColBoundMode
    BoundLower      = 0
    BoundUpper      = 1
    BoundUpperLong  = 2
    BoundValueCount = 3
  end
  enum UColRuleOption
    TailoringOnly = 0
    FullRules     = 1
  end
  enum UCollationResult
    Equal   =  0
    Greater =  1
    Less    = -1
  end
  fun ucol_clone_binary = ucol_cloneBinary{{SYMS_SUFFIX.id}}(coll : UCollator, buffer : Uint8T*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun ucol_close = ucol_close{{SYMS_SUFFIX.id}}(coll : UCollator)
  fun ucol_count_available = ucol_countAvailable{{SYMS_SUFFIX.id}} : Int32T
  fun ucol_equal = ucol_equal{{SYMS_SUFFIX.id}}(coll : UCollator, source : UChar*, source_length : Int32T, target : UChar*, target_length : Int32T) : UBool
  fun ucol_equals = ucol_equals{{SYMS_SUFFIX.id}}(source : UCollator, target : UCollator) : UBool
  fun ucol_forget_uca = ucol_forgetUCA{{SYMS_SUFFIX.id}}
  fun ucol_get_attribute = ucol_getAttribute{{SYMS_SUFFIX.id}}(coll : UCollator, attr : UColAttribute, status : UErrorCode*) : UColAttributeValue
  fun ucol_get_attribute_or_default = ucol_getAttributeOrDefault{{SYMS_SUFFIX.id}}(coll : UCollator, attr : UColAttribute, status : UErrorCode*) : UColAttributeValue
  fun ucol_get_available = ucol_getAvailable{{SYMS_SUFFIX.id}}(locale_index : Int32T) : LibC::Char*
  fun ucol_get_bound = ucol_getBound{{SYMS_SUFFIX.id}}(source : Uint8T*, source_length : Int32T, bound_type : UColBoundMode, no_of_levels : Uint32T, result : Uint8T*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ucol_get_contractions = ucol_getContractions{{SYMS_SUFFIX.id}}(coll : UCollator, conts : USet, status : UErrorCode*) : Int32T
  fun ucol_get_contractions_and_expansions = ucol_getContractionsAndExpansions{{SYMS_SUFFIX.id}}(coll : UCollator, contractions : USet, expansions : USet, add_prefixes : UBool, status : UErrorCode*)
  fun ucol_get_display_name = ucol_getDisplayName{{SYMS_SUFFIX.id}}(obj_loc : LibC::Char*, disp_loc : LibC::Char*, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ucol_get_equivalent_reorder_codes = ucol_getEquivalentReorderCodes{{SYMS_SUFFIX.id}}(reorder_code : Int32T, dest : Int32T*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucol_get_functional_equivalent = ucol_getFunctionalEquivalent{{SYMS_SUFFIX.id}}(result : LibC::Char*, result_capacity : Int32T, keyword : LibC::Char*, locale : LibC::Char*, is_available : UBool*, status : UErrorCode*) : Int32T
  fun ucol_get_keyword_values = ucol_getKeywordValues{{SYMS_SUFFIX.id}}(keyword : LibC::Char*, status : UErrorCode*) : UEnumeration
  fun ucol_get_keyword_values_for_locale = ucol_getKeywordValuesForLocale{{SYMS_SUFFIX.id}}(key : LibC::Char*, locale : LibC::Char*, commonly_used : UBool, status : UErrorCode*) : UEnumeration
  fun ucol_get_keywords = ucol_getKeywords{{SYMS_SUFFIX.id}}(status : UErrorCode*) : UEnumeration
  fun ucol_get_locale = ucol_getLocale{{SYMS_SUFFIX.id}}(coll : UCollator, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun ucol_get_locale_by_type = ucol_getLocaleByType{{SYMS_SUFFIX.id}}(coll : UCollator, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun ucol_get_reorder_codes = ucol_getReorderCodes{{SYMS_SUFFIX.id}}(coll : UCollator, dest : Int32T*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucol_get_rules = ucol_getRules{{SYMS_SUFFIX.id}}(coll : UCollator, length : Int32T*) : UChar*
  fun ucol_get_rules_ex = ucol_getRulesEx{{SYMS_SUFFIX.id}}(coll : UCollator, delta : UColRuleOption, buffer : UChar*, buffer_len : Int32T) : Int32T
  fun ucol_get_short_definition_string = ucol_getShortDefinitionString{{SYMS_SUFFIX.id}}(coll : UCollator, locale : LibC::Char*, buffer : LibC::Char*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun ucol_get_sort_key = ucol_getSortKey{{SYMS_SUFFIX.id}}(coll : UCollator, source : UChar*, source_length : Int32T, result : Uint8T*, result_length : Int32T) : Int32T
  fun ucol_get_strength = ucol_getStrength{{SYMS_SUFFIX.id}}(coll : UCollator) : UCollationStrength
  fun ucol_get_tailored_set = ucol_getTailoredSet{{SYMS_SUFFIX.id}}(coll : UCollator, status : UErrorCode*) : USet
  fun ucol_get_uca_version = ucol_getUCAVersion{{SYMS_SUFFIX.id}}(coll : UCollator, info : UVersionInfo)
  fun ucol_get_unsafe_set = ucol_getUnsafeSet{{SYMS_SUFFIX.id}}(coll : UCollator, unsafe : USet, status : UErrorCode*) : Int32T
  fun ucol_get_variable_top = ucol_getVariableTop{{SYMS_SUFFIX.id}}(coll : UCollator, status : UErrorCode*) : Uint32T
  fun ucol_get_version = ucol_getVersion{{SYMS_SUFFIX.id}}(coll : UCollator, info : UVersionInfo)
  fun ucol_greater = ucol_greater{{SYMS_SUFFIX.id}}(coll : UCollator, source : UChar*, source_length : Int32T, target : UChar*, target_length : Int32T) : UBool
  fun ucol_greater_or_equal = ucol_greaterOrEqual{{SYMS_SUFFIX.id}}(coll : UCollator, source : UChar*, source_length : Int32T, target : UChar*, target_length : Int32T) : UBool
  fun ucol_merge_sortkeys = ucol_mergeSortkeys{{SYMS_SUFFIX.id}}(src1 : Uint8T*, src1length : Int32T, src2 : Uint8T*, src2length : Int32T, dest : Uint8T*, dest_capacity : Int32T) : Int32T
  fun ucol_next_sort_key_part = ucol_nextSortKeyPart{{SYMS_SUFFIX.id}}(coll : UCollator, iter : UCharIterator*, state : Uint32T[2], dest : Uint8T*, count : Int32T, status : UErrorCode*) : Int32T
  fun ucol_normalize_short_definition_string = ucol_normalizeShortDefinitionString{{SYMS_SUFFIX.id}}(source : LibC::Char*, destination : LibC::Char*, capacity : Int32T, parse_error : UParseError*, status : UErrorCode*) : Int32T
  fun ucol_open = ucol_open{{SYMS_SUFFIX.id}}(loc : LibC::Char*, status : UErrorCode*) : UCollator
  fun ucol_open_available_locales = ucol_openAvailableLocales{{SYMS_SUFFIX.id}}(status : UErrorCode*) : UEnumeration
  fun ucol_open_binary = ucol_openBinary{{SYMS_SUFFIX.id}}(bin : Uint8T*, length : Int32T, base : UCollator, status : UErrorCode*) : UCollator
  fun ucol_open_from_short_string = ucol_openFromShortString{{SYMS_SUFFIX.id}}(definition : LibC::Char*, force_defaults : UBool, parse_error : UParseError*, status : UErrorCode*) : UCollator
  fun ucol_open_rules = ucol_openRules{{SYMS_SUFFIX.id}}(rules : UChar*, rules_length : Int32T, normalization_mode : UColAttributeValue, strength : UCollationStrength, parse_error : UParseError*, status : UErrorCode*) : UCollator
  fun ucol_prepare_short_string_open = ucol_prepareShortStringOpen{{SYMS_SUFFIX.id}}(definition : LibC::Char*, force_defaults : UBool, parse_error : UParseError*, status : UErrorCode*)
  fun ucol_restore_variable_top = ucol_restoreVariableTop{{SYMS_SUFFIX.id}}(coll : UCollator, var_top : Uint32T, status : UErrorCode*)
  fun ucol_safe_clone = ucol_safeClone{{SYMS_SUFFIX.id}}(coll : UCollator, stack_buffer : Void*, p_buffer_size : Int32T*, status : UErrorCode*) : UCollator
  fun ucol_set_attribute = ucol_setAttribute{{SYMS_SUFFIX.id}}(coll : UCollator, attr : UColAttribute, value : UColAttributeValue, status : UErrorCode*)
  fun ucol_set_reorder_codes = ucol_setReorderCodes{{SYMS_SUFFIX.id}}(coll : UCollator, reorder_codes : Int32T*, reorder_codes_length : Int32T, p_error_code : UErrorCode*)
  fun ucol_set_strength = ucol_setStrength{{SYMS_SUFFIX.id}}(coll : UCollator, strength : UCollationStrength)
  fun ucol_set_variable_top = ucol_setVariableTop{{SYMS_SUFFIX.id}}(coll : UCollator, var_top : UChar*, len : Int32T, status : UErrorCode*) : Uint32T
  fun ucol_strcoll = ucol_strcoll{{SYMS_SUFFIX.id}}(coll : UCollator, source : UChar*, source_length : Int32T, target : UChar*, target_length : Int32T) : UCollationResult
  fun ucol_strcoll_iter = ucol_strcollIter{{SYMS_SUFFIX.id}}(coll : UCollator, s_iter : UCharIterator*, t_iter : UCharIterator*, status : UErrorCode*) : UCollationResult
  fun ucol_strcoll_ut_f8 = ucol_strcollUTF8{{SYMS_SUFFIX.id}}(coll : UCollator, source : LibC::Char*, source_length : Int32T, target : LibC::Char*, target_length : Int32T, status : UErrorCode*) : UCollationResult
  {% end %}
end
