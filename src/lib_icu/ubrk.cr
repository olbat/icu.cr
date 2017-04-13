@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  enum UBreakIteratorType
    UbrkCharacter = 0
    UbrkWord      = 1
    UbrkLine      = 2
    UbrkSentence  = 3
    UbrkTitle     = 4
    UbrkCount     = 5
  end
  fun ubrk_close = ubrk_close_52(bi : UBreakIterator)
  fun ubrk_count_available = ubrk_countAvailable_52 : Int32T
  fun ubrk_current = ubrk_current_52(bi : UBreakIterator) : Int32T
  fun ubrk_first = ubrk_first_52(bi : UBreakIterator) : Int32T
  fun ubrk_following = ubrk_following_52(bi : UBreakIterator, offset : Int32T) : Int32T
  fun ubrk_get_available = ubrk_getAvailable_52(index : Int32T) : LibC::Char*
  fun ubrk_get_locale_by_type = ubrk_getLocaleByType_52(bi : UBreakIterator, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun ubrk_get_rule_status = ubrk_getRuleStatus_52(bi : UBreakIterator) : Int32T
  fun ubrk_get_rule_status_vec = ubrk_getRuleStatusVec_52(bi : UBreakIterator, fill_in_vec : Int32T*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun ubrk_is_boundary = ubrk_isBoundary_52(bi : UBreakIterator, offset : Int32T) : UBool
  fun ubrk_last = ubrk_last_52(bi : UBreakIterator) : Int32T
  fun ubrk_next = ubrk_next_52(bi : UBreakIterator) : Int32T
  fun ubrk_open = ubrk_open_52(type : UBreakIteratorType, locale : LibC::Char*, text : UChar*, text_length : Int32T, status : UErrorCode*) : UBreakIterator
  fun ubrk_open_rules = ubrk_openRules_52(rules : UChar*, rules_length : Int32T, text : UChar*, text_length : Int32T, parse_err : UParseError*, status : UErrorCode*) : UBreakIterator
  fun ubrk_preceding = ubrk_preceding_52(bi : UBreakIterator, offset : Int32T) : Int32T
  fun ubrk_previous = ubrk_previous_52(bi : UBreakIterator) : Int32T
  fun ubrk_refresh_u_text = ubrk_refreshUText_52(bi : UBreakIterator, text : UText*, status : UErrorCode*)
  fun ubrk_safe_clone = ubrk_safeClone_52(bi : UBreakIterator, stack_buffer : Void*, p_buffer_size : Int32T*, status : UErrorCode*) : UBreakIterator
  fun ubrk_set_text = ubrk_setText_52(bi : UBreakIterator, text : UChar*, text_length : Int32T, status : UErrorCode*)
  fun ubrk_set_u_text = ubrk_setUText_52(bi : UBreakIterator, text : UText*, status : UErrorCode*)
end
