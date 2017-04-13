@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  alias UReplaceable = Void*
  alias UTransliterator = Void*
  enum UTransDirection
    UtransForward = 0
    UtransReverse = 1
  end
  fun utrans_clone = utrans_clone_52(trans : UTransliterator*, status : UErrorCode*) : UTransliterator*
  fun utrans_close = utrans_close_52(trans : UTransliterator*)
  fun utrans_count_available_i_ds = utrans_countAvailableIDs_52 : Int32T
  fun utrans_get_available_id = utrans_getAvailableID_52(index : Int32T, buf : LibC::Char*, buf_capacity : Int32T) : Int32T
  fun utrans_get_id = utrans_getID_52(trans : UTransliterator*, buf : LibC::Char*, buf_capacity : Int32T) : Int32T
  fun utrans_get_unicode_id = utrans_getUnicodeID_52(trans : UTransliterator*, result_length : Int32T*) : UChar*
  fun utrans_open = utrans_open_52(id : LibC::Char*, dir : UTransDirection, rules : UChar*, rules_length : Int32T, parse_error : UParseError*, status : UErrorCode*) : UTransliterator*
  fun utrans_open_i_ds = utrans_openIDs_52(p_error_code : UErrorCode*) : UEnumeration
  fun utrans_open_inverse = utrans_openInverse_52(trans : UTransliterator*, status : UErrorCode*) : UTransliterator*
  fun utrans_open_u = utrans_openU_52(id : UChar*, id_length : Int32T, dir : UTransDirection, rules : UChar*, rules_length : Int32T, parse_error : UParseError*, p_error_code : UErrorCode*) : UTransliterator*
  fun utrans_register = utrans_register_52(adopted_trans : UTransliterator*, status : UErrorCode*)
  fun utrans_set_filter = utrans_setFilter_52(trans : UTransliterator*, filter_pattern : UChar*, filter_pattern_len : Int32T, status : UErrorCode*)
  fun utrans_trans = utrans_trans_52(trans : UTransliterator*, rep : UReplaceable*, rep_func : UReplaceableCallbacks*, start : Int32T, limit : Int32T*, status : UErrorCode*)
  fun utrans_trans_incremental = utrans_transIncremental_52(trans : UTransliterator*, rep : UReplaceable*, rep_func : UReplaceableCallbacks*, pos : UTransPosition*, status : UErrorCode*)
  fun utrans_trans_incremental_u_chars = utrans_transIncrementalUChars_52(trans : UTransliterator*, text : UChar*, text_length : Int32T*, text_capacity : Int32T, pos : UTransPosition*, status : UErrorCode*)
  fun utrans_trans_u_chars = utrans_transUChars_52(trans : UTransliterator*, text : UChar*, text_length : Int32T*, text_capacity : Int32T, start : Int32T, limit : Int32T*, status : UErrorCode*)
  fun utrans_unregister = utrans_unregister_52(id : LibC::Char*)
  fun utrans_unregister_id = utrans_unregisterID_52(id : UChar*, id_length : Int32T)

  struct UReplaceableCallbacks
    length : (UReplaceable* -> Int32T)
    char_at : (UReplaceable*, Int32T -> UChar)
    char32at : (UReplaceable*, Int32T -> UChar32)
    replace : (UReplaceable*, Int32T, Int32T, UChar*, Int32T -> Void)
    extract : (UReplaceable*, Int32T, Int32T, UChar* -> Void)
    copy : (UReplaceable*, Int32T, Int32T, Int32T -> Void)
  end

  struct UTransPosition
    context_start : Int32T
    context_limit : Int32T
    start : Int32T
    limit : Int32T
  end
end
