@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  enum USearchAttribute
    UsearchOverlap           = 0
    UsearchCanonicalMatch    = 1
    UsearchElementComparison = 2
    UsearchAttributeCount    = 3
  end
  enum USearchAttributeValue
    UsearchDefault                     = -1
    UsearchOff                         =  0
    UsearchOn                          =  1
    UsearchStandardElementComparison   =  2
    UsearchPatternBaseWeightIsWildcard =  3
    UsearchAnyBaseWeightIsWildcard     =  4
    UsearchAttributeValueCount         =  5
  end
  fun usearch_close = usearch_close_52(searchiter : UStringSearch)
  fun usearch_first = usearch_first_52(strsrch : UStringSearch, status : UErrorCode*) : Int32T
  fun usearch_following = usearch_following_52(strsrch : UStringSearch, position : Int32T, status : UErrorCode*) : Int32T
  fun usearch_get_attribute = usearch_getAttribute_52(strsrch : UStringSearch, attribute : USearchAttribute) : USearchAttributeValue
  fun usearch_get_break_iterator = usearch_getBreakIterator_52(strsrch : UStringSearch) : UBreakIterator
  fun usearch_get_collator = usearch_getCollator_52(strsrch : UStringSearch) : UCollator
  fun usearch_get_matched_length = usearch_getMatchedLength_52(strsrch : UStringSearch) : Int32T
  fun usearch_get_matched_start = usearch_getMatchedStart_52(strsrch : UStringSearch) : Int32T
  fun usearch_get_matched_text = usearch_getMatchedText_52(strsrch : UStringSearch, result : UChar*, result_capacity : Int32T, status : UErrorCode*) : Int32T
  fun usearch_get_offset = usearch_getOffset_52(strsrch : UStringSearch) : Int32T
  fun usearch_get_pattern = usearch_getPattern_52(strsrch : UStringSearch, length : Int32T*) : UChar*
  fun usearch_get_text = usearch_getText_52(strsrch : UStringSearch, length : Int32T*) : UChar*
  fun usearch_last = usearch_last_52(strsrch : UStringSearch, status : UErrorCode*) : Int32T
  fun usearch_next = usearch_next_52(strsrch : UStringSearch, status : UErrorCode*) : Int32T
  fun usearch_open = usearch_open_52(pattern : UChar*, patternlength : Int32T, text : UChar*, textlength : Int32T, locale : LibC::Char*, breakiter : UBreakIterator, status : UErrorCode*) : UStringSearch
  fun usearch_open_from_collator = usearch_openFromCollator_52(pattern : UChar*, patternlength : Int32T, text : UChar*, textlength : Int32T, collator : UCollator, breakiter : UBreakIterator, status : UErrorCode*) : UStringSearch
  fun usearch_preceding = usearch_preceding_52(strsrch : UStringSearch, position : Int32T, status : UErrorCode*) : Int32T
  fun usearch_previous = usearch_previous_52(strsrch : UStringSearch, status : UErrorCode*) : Int32T
  fun usearch_reset = usearch_reset_52(strsrch : UStringSearch)
  fun usearch_search = usearch_search_52(strsrch : UStringSearch, start_idx : Int32T, match_start : Int32T*, match_limit : Int32T*, status : UErrorCode*) : UBool
  fun usearch_search_backwards = usearch_searchBackwards_52(strsrch : UStringSearch, start_idx : Int32T, match_start : Int32T*, match_limit : Int32T*, status : UErrorCode*) : UBool
  fun usearch_set_attribute = usearch_setAttribute_52(strsrch : UStringSearch, attribute : USearchAttribute, value : USearchAttributeValue, status : UErrorCode*)
  fun usearch_set_break_iterator = usearch_setBreakIterator_52(strsrch : UStringSearch, breakiter : UBreakIterator, status : UErrorCode*)
  fun usearch_set_collator = usearch_setCollator_52(strsrch : UStringSearch, collator : UCollator, status : UErrorCode*)
  fun usearch_set_offset = usearch_setOffset_52(strsrch : UStringSearch, position : Int32T, status : UErrorCode*)
  fun usearch_set_pattern = usearch_setPattern_52(strsrch : UStringSearch, pattern : UChar*, patternlength : Int32T, status : UErrorCode*)
  fun usearch_set_text = usearch_setText_52(strsrch : UStringSearch, text : UChar*, textlength : Int32T, status : UErrorCode*)
  type UStringSearch = Void*
end
