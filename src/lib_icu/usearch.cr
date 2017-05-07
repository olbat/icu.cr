@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum USearchAttribute
    Overlap           = 0
    CanonicalMatch    = 1
    ElementComparison = 2
    AttributeCount    = 3
  end
  enum USearchAttributeValue
    Default                     = -1
    Off                         =  0
    On                          =  1
    StandardElementComparison   =  2
    PatternBaseWeightIsWildcard =  3
    AnyBaseWeightIsWildcard     =  4
    AttributeValueCount         =  5
  end
  fun usearch_close = usearch_close{{SYMS_SUFFIX.id}}(searchiter : UStringSearch)
  fun usearch_first = usearch_first{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, status : UErrorCode*) : Int32T
  fun usearch_following = usearch_following{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, position : Int32T, status : UErrorCode*) : Int32T
  fun usearch_get_attribute = usearch_getAttribute{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, attribute : USearchAttribute) : USearchAttributeValue
  fun usearch_get_break_iterator = usearch_getBreakIterator{{SYMS_SUFFIX.id}}(strsrch : UStringSearch) : UBreakIterator
  fun usearch_get_collator = usearch_getCollator{{SYMS_SUFFIX.id}}(strsrch : UStringSearch) : UCollator
  fun usearch_get_matched_length = usearch_getMatchedLength{{SYMS_SUFFIX.id}}(strsrch : UStringSearch) : Int32T
  fun usearch_get_matched_start = usearch_getMatchedStart{{SYMS_SUFFIX.id}}(strsrch : UStringSearch) : Int32T
  fun usearch_get_matched_text = usearch_getMatchedText{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, result : UChar*, result_capacity : Int32T, status : UErrorCode*) : Int32T
  fun usearch_get_offset = usearch_getOffset{{SYMS_SUFFIX.id}}(strsrch : UStringSearch) : Int32T
  fun usearch_get_pattern = usearch_getPattern{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, length : Int32T*) : UChar*
  fun usearch_get_text = usearch_getText{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, length : Int32T*) : UChar*
  fun usearch_last = usearch_last{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, status : UErrorCode*) : Int32T
  fun usearch_next = usearch_next{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, status : UErrorCode*) : Int32T
  fun usearch_open = usearch_open{{SYMS_SUFFIX.id}}(pattern : UChar*, patternlength : Int32T, text : UChar*, textlength : Int32T, locale : LibC::Char*, breakiter : UBreakIterator, status : UErrorCode*) : UStringSearch
  fun usearch_open_from_collator = usearch_openFromCollator{{SYMS_SUFFIX.id}}(pattern : UChar*, patternlength : Int32T, text : UChar*, textlength : Int32T, collator : UCollator, breakiter : UBreakIterator, status : UErrorCode*) : UStringSearch
  fun usearch_preceding = usearch_preceding{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, position : Int32T, status : UErrorCode*) : Int32T
  fun usearch_previous = usearch_previous{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, status : UErrorCode*) : Int32T
  fun usearch_reset = usearch_reset{{SYMS_SUFFIX.id}}(strsrch : UStringSearch)
  fun usearch_search = usearch_search{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, start_idx : Int32T, match_start : Int32T*, match_limit : Int32T*, status : UErrorCode*) : UBool
  fun usearch_search_backwards = usearch_searchBackwards{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, start_idx : Int32T, match_start : Int32T*, match_limit : Int32T*, status : UErrorCode*) : UBool
  fun usearch_set_attribute = usearch_setAttribute{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, attribute : USearchAttribute, value : USearchAttributeValue, status : UErrorCode*)
  fun usearch_set_break_iterator = usearch_setBreakIterator{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, breakiter : UBreakIterator, status : UErrorCode*)
  fun usearch_set_collator = usearch_setCollator{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, collator : UCollator, status : UErrorCode*)
  fun usearch_set_offset = usearch_setOffset{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, position : Int32T, status : UErrorCode*)
  fun usearch_set_pattern = usearch_setPattern{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, pattern : UChar*, patternlength : Int32T, status : UErrorCode*)
  fun usearch_set_text = usearch_setText{{SYMS_SUFFIX.id}}(strsrch : UStringSearch, text : UChar*, textlength : Int32T, status : UErrorCode*)
  type UStringSearch = Void*
  {% end %}
end
