@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UBreakIteratorType
    UbrkCharacter = 0
    UbrkWord      = 1
    UbrkLine      = 2
    UbrkSentence  = 3
    UbrkTitle     = 4
    UbrkCount     = 5
  end
  fun ubrk_close = ubrk_close{{SYMS_SUFFIX.id}}(bi : UBreakIterator)
  fun ubrk_count_available = ubrk_countAvailable{{SYMS_SUFFIX.id}} : Int32T
  fun ubrk_current = ubrk_current{{SYMS_SUFFIX.id}}(bi : UBreakIterator) : Int32T
  fun ubrk_first = ubrk_first{{SYMS_SUFFIX.id}}(bi : UBreakIterator) : Int32T
  fun ubrk_following = ubrk_following{{SYMS_SUFFIX.id}}(bi : UBreakIterator, offset : Int32T) : Int32T
  fun ubrk_get_available = ubrk_getAvailable{{SYMS_SUFFIX.id}}(index : Int32T) : LibC::Char*
  fun ubrk_get_locale_by_type = ubrk_getLocaleByType{{SYMS_SUFFIX.id}}(bi : UBreakIterator, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun ubrk_get_rule_status = ubrk_getRuleStatus{{SYMS_SUFFIX.id}}(bi : UBreakIterator) : Int32T
  fun ubrk_get_rule_status_vec = ubrk_getRuleStatusVec{{SYMS_SUFFIX.id}}(bi : UBreakIterator, fill_in_vec : Int32T*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun ubrk_is_boundary = ubrk_isBoundary{{SYMS_SUFFIX.id}}(bi : UBreakIterator, offset : Int32T) : UBool
  fun ubrk_last = ubrk_last{{SYMS_SUFFIX.id}}(bi : UBreakIterator) : Int32T
  fun ubrk_next = ubrk_next{{SYMS_SUFFIX.id}}(bi : UBreakIterator) : Int32T
  fun ubrk_open = ubrk_open{{SYMS_SUFFIX.id}}(type : UBreakIteratorType, locale : LibC::Char*, text : UChar*, text_length : Int32T, status : UErrorCode*) : UBreakIterator
  fun ubrk_open_rules = ubrk_openRules{{SYMS_SUFFIX.id}}(rules : UChar*, rules_length : Int32T, text : UChar*, text_length : Int32T, parse_err : UParseError*, status : UErrorCode*) : UBreakIterator
  fun ubrk_preceding = ubrk_preceding{{SYMS_SUFFIX.id}}(bi : UBreakIterator, offset : Int32T) : Int32T
  fun ubrk_previous = ubrk_previous{{SYMS_SUFFIX.id}}(bi : UBreakIterator) : Int32T
  fun ubrk_refresh_u_text = ubrk_refreshUText{{SYMS_SUFFIX.id}}(bi : UBreakIterator, text : UText*, status : UErrorCode*)
  fun ubrk_safe_clone = ubrk_safeClone{{SYMS_SUFFIX.id}}(bi : UBreakIterator, stack_buffer : Void*, p_buffer_size : Int32T*, status : UErrorCode*) : UBreakIterator
  fun ubrk_set_text = ubrk_setText{{SYMS_SUFFIX.id}}(bi : UBreakIterator, text : UChar*, text_length : Int32T, status : UErrorCode*)
  fun ubrk_set_u_text = ubrk_setUText{{SYMS_SUFFIX.id}}(bi : UBreakIterator, text : UText*, status : UErrorCode*)
  {% end %}
end
