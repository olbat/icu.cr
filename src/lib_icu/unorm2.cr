@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UNormalization2Mode
    Compose           = 0
    Decompose         = 1
    Fcd               = 2
    ComposeContiguous = 3
  end
  enum UNormalizationCheckResult
    No    = 0
    Yes   = 1
    Maybe = 2
  end
  fun unorm2_append = unorm2_append{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, first : UChar*, first_length : Int32T, first_capacity : Int32T, second : UChar*, second_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_close = unorm2_close{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2)
  fun unorm2_compose_pair = unorm2_composePair{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, a : UChar32, b : UChar32) : UChar32
  fun unorm2_get_combining_class = unorm2_getCombiningClass{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, c : UChar32) : Uint8T
  fun unorm2_get_decomposition = unorm2_getDecomposition{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, c : UChar32, decomposition : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_get_instance = unorm2_getInstance{{SYMS_SUFFIX.id}}(package_name : LibC::Char*, name : LibC::Char*, mode : UNormalization2Mode, p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfc_instance = unorm2_getNFCInstance{{SYMS_SUFFIX.id}}(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfd_instance = unorm2_getNFDInstance{{SYMS_SUFFIX.id}}(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfkc_casefold_instance = unorm2_getNFKCCasefoldInstance{{SYMS_SUFFIX.id}}(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfkc_instance = unorm2_getNFKCInstance{{SYMS_SUFFIX.id}}(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfkd_instance = unorm2_getNFKDInstance{{SYMS_SUFFIX.id}}(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_raw_decomposition = unorm2_getRawDecomposition{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, c : UChar32, decomposition : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_has_boundary_after = unorm2_hasBoundaryAfter{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, c : UChar32) : UBool
  fun unorm2_has_boundary_before = unorm2_hasBoundaryBefore{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, c : UChar32) : UBool
  fun unorm2_is_inert = unorm2_isInert{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, c : UChar32) : UBool
  fun unorm2_is_normalized = unorm2_isNormalized{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, s : UChar*, length : Int32T, p_error_code : UErrorCode*) : UBool
  fun unorm2_normalize = unorm2_normalize{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, src : UChar*, length : Int32T, dest : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_normalize_second_and_append = unorm2_normalizeSecondAndAppend{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, first : UChar*, first_length : Int32T, first_capacity : Int32T, second : UChar*, second_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_open_filtered = unorm2_openFiltered{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, filter_set : USet, p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_quick_check = unorm2_quickCheck{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, s : UChar*, length : Int32T, p_error_code : UErrorCode*) : UNormalizationCheckResult
  fun unorm2_span_quick_check_yes = unorm2_spanQuickCheckYes{{SYMS_SUFFIX.id}}(norm2 : UNormalizer2, s : UChar*, length : Int32T, p_error_code : UErrorCode*) : Int32T
  type UNormalizer2 = Void*
  {% end %}
end
