@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum USetSpanCondition
    SpanNotContained   = 0
    SpanContained      = 1
    SpanSimple         = 2
    SpanConditionCount = 3
  end
  fun uset_add = uset_add{{SYMS_SUFFIX.id}}(set : USet, c : UChar32)
  fun uset_add_all = uset_addAll{{SYMS_SUFFIX.id}}(set : USet, additional_set : USet)
  fun uset_add_all_code_points = uset_addAllCodePoints{{SYMS_SUFFIX.id}}(set : USet, str : UChar*, str_len : Int32T)
  fun uset_add_range = uset_addRange{{SYMS_SUFFIX.id}}(set : USet, start : UChar32, _end : UChar32)
  fun uset_add_string = uset_addString{{SYMS_SUFFIX.id}}(set : USet, str : UChar*, str_len : Int32T)
  fun uset_apply_int_property_value = uset_applyIntPropertyValue{{SYMS_SUFFIX.id}}(set : USet, prop : UProperty, value : Int32T, ec : UErrorCode*)
  fun uset_apply_pattern = uset_applyPattern{{SYMS_SUFFIX.id}}(set : USet, pattern : UChar*, pattern_length : Int32T, options : Uint32T, status : UErrorCode*) : Int32T
  fun uset_apply_property_alias = uset_applyPropertyAlias{{SYMS_SUFFIX.id}}(set : USet, prop : UChar*, prop_length : Int32T, value : UChar*, value_length : Int32T, ec : UErrorCode*)
  fun uset_char_at = uset_charAt{{SYMS_SUFFIX.id}}(set : USet, char_index : Int32T) : UChar32
  fun uset_clear = uset_clear{{SYMS_SUFFIX.id}}(set : USet)
  fun uset_clone = uset_clone{{SYMS_SUFFIX.id}}(set : USet) : USet
  fun uset_clone_as_thawed = uset_cloneAsThawed{{SYMS_SUFFIX.id}}(set : USet) : USet
  fun uset_close = uset_close{{SYMS_SUFFIX.id}}(set : USet)
  fun uset_close_over = uset_closeOver{{SYMS_SUFFIX.id}}(set : USet, attributes : Int32T)
  fun uset_compact = uset_compact{{SYMS_SUFFIX.id}}(set : USet)
  fun uset_complement = uset_complement{{SYMS_SUFFIX.id}}(set : USet)
  fun uset_complement_all = uset_complementAll{{SYMS_SUFFIX.id}}(set : USet, complement : USet)
  fun uset_contains = uset_contains{{SYMS_SUFFIX.id}}(set : USet, c : UChar32) : UBool
  fun uset_contains_all = uset_containsAll{{SYMS_SUFFIX.id}}(set1 : USet, set2 : USet) : UBool
  fun uset_contains_all_code_points = uset_containsAllCodePoints{{SYMS_SUFFIX.id}}(set : USet, str : UChar*, str_len : Int32T) : UBool
  fun uset_contains_none = uset_containsNone{{SYMS_SUFFIX.id}}(set1 : USet, set2 : USet) : UBool
  fun uset_contains_range = uset_containsRange{{SYMS_SUFFIX.id}}(set : USet, start : UChar32, _end : UChar32) : UBool
  fun uset_contains_some = uset_containsSome{{SYMS_SUFFIX.id}}(set1 : USet, set2 : USet) : UBool
  fun uset_contains_string = uset_containsString{{SYMS_SUFFIX.id}}(set : USet, str : UChar*, str_len : Int32T) : UBool
  fun uset_equals = uset_equals{{SYMS_SUFFIX.id}}(set1 : USet, set2 : USet) : UBool
  fun uset_freeze = uset_freeze{{SYMS_SUFFIX.id}}(set : USet)
  fun uset_get_item = uset_getItem{{SYMS_SUFFIX.id}}(set : USet, item_index : Int32T, start : UChar32*, _end : UChar32*, str : UChar*, str_capacity : Int32T, ec : UErrorCode*) : Int32T
  fun uset_get_item_count = uset_getItemCount{{SYMS_SUFFIX.id}}(set : USet) : Int32T
  fun uset_get_serialized_range = uset_getSerializedRange{{SYMS_SUFFIX.id}}(set : USerializedSet*, range_index : Int32T, p_start : UChar32*, p_end : UChar32*) : UBool
  fun uset_get_serialized_range_count = uset_getSerializedRangeCount{{SYMS_SUFFIX.id}}(set : USerializedSet*) : Int32T
  fun uset_get_serialized_set = uset_getSerializedSet{{SYMS_SUFFIX.id}}(fill_set : USerializedSet*, src : Uint16T*, src_length : Int32T) : UBool
  fun uset_index_of = uset_indexOf{{SYMS_SUFFIX.id}}(set : USet, c : UChar32) : Int32T
  fun uset_is_empty = uset_isEmpty{{SYMS_SUFFIX.id}}(set : USet) : UBool
  fun uset_is_frozen = uset_isFrozen{{SYMS_SUFFIX.id}}(set : USet) : UBool
  fun uset_open = uset_open{{SYMS_SUFFIX.id}}(start : UChar32, _end : UChar32) : USet
  fun uset_open_empty = uset_openEmpty{{SYMS_SUFFIX.id}} : USet
  fun uset_open_pattern = uset_openPattern{{SYMS_SUFFIX.id}}(pattern : UChar*, pattern_length : Int32T, ec : UErrorCode*) : USet
  fun uset_open_pattern_options = uset_openPatternOptions{{SYMS_SUFFIX.id}}(pattern : UChar*, pattern_length : Int32T, options : Uint32T, ec : UErrorCode*) : USet
  fun uset_remove = uset_remove{{SYMS_SUFFIX.id}}(set : USet, c : UChar32)
  fun uset_remove_all = uset_removeAll{{SYMS_SUFFIX.id}}(set : USet, remove_set : USet)
  fun uset_remove_all_strings = uset_removeAllStrings{{SYMS_SUFFIX.id}}(set : USet)
  fun uset_remove_range = uset_removeRange{{SYMS_SUFFIX.id}}(set : USet, start : UChar32, _end : UChar32)
  fun uset_remove_string = uset_removeString{{SYMS_SUFFIX.id}}(set : USet, str : UChar*, str_len : Int32T)
  fun uset_resembles_pattern = uset_resemblesPattern{{SYMS_SUFFIX.id}}(pattern : UChar*, pattern_length : Int32T, pos : Int32T) : UBool
  fun uset_retain = uset_retain{{SYMS_SUFFIX.id}}(set : USet, start : UChar32, _end : UChar32)
  fun uset_retain_all = uset_retainAll{{SYMS_SUFFIX.id}}(set : USet, retain : USet)
  fun uset_serialize = uset_serialize{{SYMS_SUFFIX.id}}(set : USet, dest : Uint16T*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun uset_serialized_contains = uset_serializedContains{{SYMS_SUFFIX.id}}(set : USerializedSet*, c : UChar32) : UBool
  fun uset_set = uset_set{{SYMS_SUFFIX.id}}(set : USet, start : UChar32, _end : UChar32)
  fun uset_set_serialized_to_one = uset_setSerializedToOne{{SYMS_SUFFIX.id}}(fill_set : USerializedSet*, c : UChar32)
  fun uset_size = uset_size{{SYMS_SUFFIX.id}}(set : USet) : Int32T
  fun uset_span = uset_span{{SYMS_SUFFIX.id}}(set : USet, s : UChar*, length : Int32T, span_condition : USetSpanCondition) : Int32T
  fun uset_span_back = uset_spanBack{{SYMS_SUFFIX.id}}(set : USet, s : UChar*, length : Int32T, span_condition : USetSpanCondition) : Int32T
  fun uset_span_back_ut_f8 = uset_spanBackUTF8{{SYMS_SUFFIX.id}}(set : USet, s : LibC::Char*, length : Int32T, span_condition : USetSpanCondition) : Int32T
  fun uset_span_ut_f8 = uset_spanUTF8{{SYMS_SUFFIX.id}}(set : USet, s : LibC::Char*, length : Int32T, span_condition : USetSpanCondition) : Int32T
  fun uset_to_pattern = uset_toPattern{{SYMS_SUFFIX.id}}(set : USet, result : UChar*, result_capacity : Int32T, escape_unprintable : UBool, ec : UErrorCode*) : Int32T

  struct USerializedSet
    array : Uint16T*
    bmp_length : Int32T
    length : Int32T
    static_array : Uint16T[8]
  end
  {% end %}
end
