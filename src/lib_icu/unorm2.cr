@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  enum UNormalization2mode
    UnorM2Compose           = 0
    UnorM2Decompose         = 1
    UnorM2Fcd               = 2
    UnorM2ComposeContiguous = 3
  end
  enum UNormalizationCheckResult
    UnormNo    = 0
    UnormYes   = 1
    UnormMaybe = 2
  end
  fun unorm2_append = unorm2_append_52(norm2 : UNormalizer2, first : UChar*, first_length : Int32T, first_capacity : Int32T, second : UChar*, second_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_close = unorm2_close_52(norm2 : UNormalizer2)
  fun unorm2_compose_pair = unorm2_composePair_52(norm2 : UNormalizer2, a : UChar32, b : UChar32) : UChar32
  fun unorm2_get_combining_class = unorm2_getCombiningClass_52(norm2 : UNormalizer2, c : UChar32) : Uint8T
  fun unorm2_get_decomposition = unorm2_getDecomposition_52(norm2 : UNormalizer2, c : UChar32, decomposition : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_get_instance = unorm2_getInstance_52(package_name : LibC::Char*, name : LibC::Char*, mode : UNormalization2mode, p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfc_instance = unorm2_getNFCInstance_52(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfd_instance = unorm2_getNFDInstance_52(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfkc_casefold_instance = unorm2_getNFKCCasefoldInstance_52(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfkc_instance = unorm2_getNFKCInstance_52(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_nfkd_instance = unorm2_getNFKDInstance_52(p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_get_raw_decomposition = unorm2_getRawDecomposition_52(norm2 : UNormalizer2, c : UChar32, decomposition : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_has_boundary_after = unorm2_hasBoundaryAfter_52(norm2 : UNormalizer2, c : UChar32) : UBool
  fun unorm2_has_boundary_before = unorm2_hasBoundaryBefore_52(norm2 : UNormalizer2, c : UChar32) : UBool
  fun unorm2_is_inert = unorm2_isInert_52(norm2 : UNormalizer2, c : UChar32) : UBool
  fun unorm2_is_normalized = unorm2_isNormalized_52(norm2 : UNormalizer2, s : UChar*, length : Int32T, p_error_code : UErrorCode*) : UBool
  fun unorm2_normalize = unorm2_normalize_52(norm2 : UNormalizer2, src : UChar*, length : Int32T, dest : UChar*, capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_normalize_second_and_append = unorm2_normalizeSecondAndAppend_52(norm2 : UNormalizer2, first : UChar*, first_length : Int32T, first_capacity : Int32T, second : UChar*, second_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun unorm2_open_filtered = unorm2_openFiltered_52(norm2 : UNormalizer2, filter_set : USet, p_error_code : UErrorCode*) : UNormalizer2
  fun unorm2_quick_check = unorm2_quickCheck_52(norm2 : UNormalizer2, s : UChar*, length : Int32T, p_error_code : UErrorCode*) : UNormalizationCheckResult
  fun unorm2_span_quick_check_yes = unorm2_spanQuickCheckYes_52(norm2 : UNormalizer2, s : UChar*, length : Int32T, p_error_code : UErrorCode*) : Int32T
  type UNormalizer2 = Void*
end
