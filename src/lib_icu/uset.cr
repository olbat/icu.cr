@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  enum USetSpanCondition
    UsetSpanNotContained   = 0
    UsetSpanContained      = 1
    UsetSpanSimple         = 2
    UsetSpanConditionCount = 3
  end
  fun uset_add = uset_add_52(set : USet, c : UChar32)
  fun uset_add_all = uset_addAll_52(set : USet, additional_set : USet)
  fun uset_add_all_code_points = uset_addAllCodePoints_52(set : USet, str : UChar*, str_len : Int32T)
  fun uset_add_range = uset_addRange_52(set : USet, start : UChar32, _end : UChar32)
  fun uset_add_string = uset_addString_52(set : USet, str : UChar*, str_len : Int32T)
  fun uset_apply_int_property_value = uset_applyIntPropertyValue_52(set : USet, prop : UProperty, value : Int32T, ec : UErrorCode*)
  fun uset_apply_pattern = uset_applyPattern_52(set : USet, pattern : UChar*, pattern_length : Int32T, options : Uint32T, status : UErrorCode*) : Int32T
  fun uset_apply_property_alias = uset_applyPropertyAlias_52(set : USet, prop : UChar*, prop_length : Int32T, value : UChar*, value_length : Int32T, ec : UErrorCode*)
  fun uset_char_at = uset_charAt_52(set : USet, char_index : Int32T) : UChar32
  fun uset_clear = uset_clear_52(set : USet)
  fun uset_clone = uset_clone_52(set : USet) : USet
  fun uset_clone_as_thawed = uset_cloneAsThawed_52(set : USet) : USet
  fun uset_close = uset_close_52(set : USet)
  fun uset_close_over = uset_closeOver_52(set : USet, attributes : Int32T)
  fun uset_compact = uset_compact_52(set : USet)
  fun uset_complement = uset_complement_52(set : USet)
  fun uset_complement_all = uset_complementAll_52(set : USet, complement : USet)
  fun uset_contains = uset_contains_52(set : USet, c : UChar32) : UBool
  fun uset_contains_all = uset_containsAll_52(set1 : USet, set2 : USet) : UBool
  fun uset_contains_all_code_points = uset_containsAllCodePoints_52(set : USet, str : UChar*, str_len : Int32T) : UBool
  fun uset_contains_none = uset_containsNone_52(set1 : USet, set2 : USet) : UBool
  fun uset_contains_range = uset_containsRange_52(set : USet, start : UChar32, _end : UChar32) : UBool
  fun uset_contains_some = uset_containsSome_52(set1 : USet, set2 : USet) : UBool
  fun uset_contains_string = uset_containsString_52(set : USet, str : UChar*, str_len : Int32T) : UBool
  fun uset_equals = uset_equals_52(set1 : USet, set2 : USet) : UBool
  fun uset_freeze = uset_freeze_52(set : USet)
  fun uset_get_item = uset_getItem_52(set : USet, item_index : Int32T, start : UChar32*, _end : UChar32*, str : UChar*, str_capacity : Int32T, ec : UErrorCode*) : Int32T
  fun uset_get_item_count = uset_getItemCount_52(set : USet) : Int32T
  fun uset_get_serialized_range = uset_getSerializedRange_52(set : USerializedSet*, range_index : Int32T, p_start : UChar32*, p_end : UChar32*) : UBool
  fun uset_get_serialized_range_count = uset_getSerializedRangeCount_52(set : USerializedSet*) : Int32T
  fun uset_get_serialized_set = uset_getSerializedSet_52(fill_set : USerializedSet*, src : Uint16T*, src_length : Int32T) : UBool
  fun uset_index_of = uset_indexOf_52(set : USet, c : UChar32) : Int32T
  fun uset_is_empty = uset_isEmpty_52(set : USet) : UBool
  fun uset_is_frozen = uset_isFrozen_52(set : USet) : UBool
  fun uset_open = uset_open_52(start : UChar32, _end : UChar32) : USet
  fun uset_open_empty = uset_openEmpty_52 : USet
  fun uset_open_pattern = uset_openPattern_52(pattern : UChar*, pattern_length : Int32T, ec : UErrorCode*) : USet
  fun uset_open_pattern_options = uset_openPatternOptions_52(pattern : UChar*, pattern_length : Int32T, options : Uint32T, ec : UErrorCode*) : USet
  fun uset_remove = uset_remove_52(set : USet, c : UChar32)
  fun uset_remove_all = uset_removeAll_52(set : USet, remove_set : USet)
  fun uset_remove_all_strings = uset_removeAllStrings_52(set : USet)
  fun uset_remove_range = uset_removeRange_52(set : USet, start : UChar32, _end : UChar32)
  fun uset_remove_string = uset_removeString_52(set : USet, str : UChar*, str_len : Int32T)
  fun uset_resembles_pattern = uset_resemblesPattern_52(pattern : UChar*, pattern_length : Int32T, pos : Int32T) : UBool
  fun uset_retain = uset_retain_52(set : USet, start : UChar32, _end : UChar32)
  fun uset_retain_all = uset_retainAll_52(set : USet, retain : USet)
  fun uset_serialize = uset_serialize_52(set : USet, dest : Uint16T*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun uset_serialized_contains = uset_serializedContains_52(set : USerializedSet*, c : UChar32) : UBool
  fun uset_set = uset_set_52(set : USet, start : UChar32, _end : UChar32)
  fun uset_set_serialized_to_one = uset_setSerializedToOne_52(fill_set : USerializedSet*, c : UChar32)
  fun uset_size = uset_size_52(set : USet) : Int32T
  fun uset_span = uset_span_52(set : USet, s : UChar*, length : Int32T, span_condition : USetSpanCondition) : Int32T
  fun uset_span_back = uset_spanBack_52(set : USet, s : UChar*, length : Int32T, span_condition : USetSpanCondition) : Int32T
  fun uset_span_back_ut_f8 = uset_spanBackUTF8_52(set : USet, s : LibC::Char*, length : Int32T, span_condition : USetSpanCondition) : Int32T
  fun uset_span_ut_f8 = uset_spanUTF8_52(set : USet, s : LibC::Char*, length : Int32T, span_condition : USetSpanCondition) : Int32T
  fun uset_to_pattern = uset_toPattern_52(set : USet, result : UChar*, result_capacity : Int32T, escape_unprintable : UBool, ec : UErrorCode*) : Int32T

  struct USerializedSet
    array : Uint16T*
    bmp_length : Int32T
    length : Int32T
    static_array : Uint16T[8]
  end
end
