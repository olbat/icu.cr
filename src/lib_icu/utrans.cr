@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  alias UReplaceable = Void*
  alias UTransliterator = Void*
  enum UTransDirection
    Forward = 0
    Reverse = 1
  end
  fun utrans_clone = utrans_clone{{SYMS_SUFFIX.id}}(trans : UTransliterator*, status : UErrorCode*) : UTransliterator*
  fun utrans_close = utrans_close{{SYMS_SUFFIX.id}}(trans : UTransliterator*)
  fun utrans_count_available_i_ds = utrans_countAvailableIDs{{SYMS_SUFFIX.id}} : Int32T
  fun utrans_get_available_id = utrans_getAvailableID{{SYMS_SUFFIX.id}}(index : Int32T, buf : LibC::Char*, buf_capacity : Int32T) : Int32T
  fun utrans_get_id = utrans_getID{{SYMS_SUFFIX.id}}(trans : UTransliterator*, buf : LibC::Char*, buf_capacity : Int32T) : Int32T
  fun utrans_get_source_set = utrans_getSourceSet{{SYMS_SUFFIX.id}}(trans : UTransliterator*, ignore_filter : UBool, fill_in : USet, status : UErrorCode*) : USet
  fun utrans_get_unicode_id = utrans_getUnicodeID{{SYMS_SUFFIX.id}}(trans : UTransliterator*, result_length : Int32T*) : UChar*
  fun utrans_open = utrans_open{{SYMS_SUFFIX.id}}(id : LibC::Char*, dir : UTransDirection, rules : UChar*, rules_length : Int32T, parse_error : UParseError*, status : UErrorCode*) : UTransliterator*
  fun utrans_open_i_ds = utrans_openIDs{{SYMS_SUFFIX.id}}(p_error_code : UErrorCode*) : UEnumeration
  fun utrans_open_inverse = utrans_openInverse{{SYMS_SUFFIX.id}}(trans : UTransliterator*, status : UErrorCode*) : UTransliterator*
  fun utrans_open_u = utrans_openU{{SYMS_SUFFIX.id}}(id : UChar*, id_length : Int32T, dir : UTransDirection, rules : UChar*, rules_length : Int32T, parse_error : UParseError*, p_error_code : UErrorCode*) : UTransliterator*
  fun utrans_register = utrans_register{{SYMS_SUFFIX.id}}(adopted_trans : UTransliterator*, status : UErrorCode*)
  fun utrans_set_filter = utrans_setFilter{{SYMS_SUFFIX.id}}(trans : UTransliterator*, filter_pattern : UChar*, filter_pattern_len : Int32T, status : UErrorCode*)
  fun utrans_to_rules = utrans_toRules{{SYMS_SUFFIX.id}}(trans : UTransliterator*, escape_unprintable : UBool, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun utrans_trans = utrans_trans{{SYMS_SUFFIX.id}}(trans : UTransliterator*, rep : UReplaceable*, rep_func : UReplaceableCallbacks*, start : Int32T, limit : Int32T*, status : UErrorCode*)
  fun utrans_trans_incremental = utrans_transIncremental{{SYMS_SUFFIX.id}}(trans : UTransliterator*, rep : UReplaceable*, rep_func : UReplaceableCallbacks*, pos : UTransPosition*, status : UErrorCode*)
  fun utrans_trans_incremental_u_chars = utrans_transIncrementalUChars{{SYMS_SUFFIX.id}}(trans : UTransliterator*, text : UChar*, text_length : Int32T*, text_capacity : Int32T, pos : UTransPosition*, status : UErrorCode*)
  fun utrans_trans_u_chars = utrans_transUChars{{SYMS_SUFFIX.id}}(trans : UTransliterator*, text : UChar*, text_length : Int32T*, text_capacity : Int32T, start : Int32T, limit : Int32T*, status : UErrorCode*)
  fun utrans_unregister = utrans_unregister{{SYMS_SUFFIX.id}}(id : LibC::Char*)
  fun utrans_unregister_id = utrans_unregisterID{{SYMS_SUFFIX.id}}(id : UChar*, id_length : Int32T)

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
  {% end %}
end
