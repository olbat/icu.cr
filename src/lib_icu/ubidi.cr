@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  alias UBiDiLevel = Uint8T
  enum UBiDiDirection
    Ltr     = 0
    Rtl     = 1
    Mixed   = 2
    Neutral = 3
  end
  enum UBiDiReorderingMode
    ReorderDefault                  = 0
    ReorderNumbersSpecial           = 1
    ReorderGroupNumbersWithR        = 2
    ReorderRunsOnly                 = 3
    ReorderInverseNumbersAsL        = 4
    ReorderInverseLikeDirect        = 5
    ReorderInverseForNumbersSpecial = 6
    ReorderCount                    = 7
  end
  fun ubidi_close = ubidi_close{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi)
  fun ubidi_count_paragraphs = ubidi_countParagraphs{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : Int32T
  fun ubidi_count_runs = ubidi_countRuns{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, p_error_code : UErrorCode*) : Int32T
  fun ubidi_get_base_direction = ubidi_getBaseDirection{{SYMS_SUFFIX.id}}(text : UChar*, length : Int32T) : UBiDiDirection
  fun ubidi_get_class_callback = ubidi_getClassCallback{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, fn : (Void*, UChar32 -> UCharDirection)*, context : Void**)
  fun ubidi_get_customized_class = ubidi_getCustomizedClass{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, c : UChar32) : UCharDirection
  fun ubidi_get_direction = ubidi_getDirection{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : UBiDiDirection
  fun ubidi_get_length = ubidi_getLength{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : Int32T
  fun ubidi_get_level_at = ubidi_getLevelAt{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, char_index : Int32T) : UBiDiLevel
  fun ubidi_get_levels = ubidi_getLevels{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, p_error_code : UErrorCode*) : UBiDiLevel*
  fun ubidi_get_logical_index = ubidi_getLogicalIndex{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, visual_index : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ubidi_get_logical_map = ubidi_getLogicalMap{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, index_map : Int32T*, p_error_code : UErrorCode*)
  fun ubidi_get_logical_run = ubidi_getLogicalRun{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, logical_position : Int32T, p_logical_limit : Int32T*, p_level : UBiDiLevel*)
  fun ubidi_get_para_level = ubidi_getParaLevel{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : UBiDiLevel
  fun ubidi_get_paragraph = ubidi_getParagraph{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, char_index : Int32T, p_para_start : Int32T*, p_para_limit : Int32T*, p_para_level : UBiDiLevel*, p_error_code : UErrorCode*) : Int32T
  fun ubidi_get_paragraph_by_index = ubidi_getParagraphByIndex{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, para_index : Int32T, p_para_start : Int32T*, p_para_limit : Int32T*, p_para_level : UBiDiLevel*, p_error_code : UErrorCode*)
  fun ubidi_get_processed_length = ubidi_getProcessedLength{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : Int32T
  fun ubidi_get_reordering_mode = ubidi_getReorderingMode{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : UBiDiReorderingMode
  fun ubidi_get_reordering_options = ubidi_getReorderingOptions{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : Uint32T
  fun ubidi_get_result_length = ubidi_getResultLength{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : Int32T
  fun ubidi_get_text = ubidi_getText{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : UChar*
  fun ubidi_get_visual_index = ubidi_getVisualIndex{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, logical_index : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ubidi_get_visual_map = ubidi_getVisualMap{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, index_map : Int32T*, p_error_code : UErrorCode*)
  fun ubidi_get_visual_run = ubidi_getVisualRun{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, run_index : Int32T, p_logical_start : Int32T*, p_length : Int32T*) : UBiDiDirection
  fun ubidi_invert_map = ubidi_invertMap{{SYMS_SUFFIX.id}}(src_map : Int32T*, dest_map : Int32T*, length : Int32T)
  fun ubidi_is_inverse = ubidi_isInverse{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : UBool
  fun ubidi_is_order_paragraphs_ltr = ubidi_isOrderParagraphsLTR{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi) : UBool
  fun ubidi_open = ubidi_open{{SYMS_SUFFIX.id}} : UBiDi
  fun ubidi_open_sized = ubidi_openSized{{SYMS_SUFFIX.id}}(max_length : Int32T, max_run_count : Int32T, p_error_code : UErrorCode*) : UBiDi
  fun ubidi_order_paragraphs_ltr = ubidi_orderParagraphsLTR{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, order_paragraphs_ltr : UBool)
  fun ubidi_reorder_logical = ubidi_reorderLogical{{SYMS_SUFFIX.id}}(levels : UBiDiLevel*, length : Int32T, index_map : Int32T*)
  fun ubidi_reorder_visual = ubidi_reorderVisual{{SYMS_SUFFIX.id}}(levels : UBiDiLevel*, length : Int32T, index_map : Int32T*)
  fun ubidi_set_class_callback = ubidi_setClassCallback{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, new_fn : (Void*, UChar32 -> UCharDirection), new_context : Void*, old_fn : (Void*, UChar32 -> UCharDirection)*, old_context : Void**, p_error_code : UErrorCode*)
  fun ubidi_set_context = ubidi_setContext{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, prologue : UChar*, pro_length : Int32T, epilogue : UChar*, epi_length : Int32T, p_error_code : UErrorCode*)
  fun ubidi_set_inverse = ubidi_setInverse{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, is_inverse : UBool)
  fun ubidi_set_line = ubidi_setLine{{SYMS_SUFFIX.id}}(p_para_bi_di : UBiDi, start : Int32T, limit : Int32T, p_line_bi_di : UBiDi, p_error_code : UErrorCode*)
  fun ubidi_set_para = ubidi_setPara{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, text : UChar*, length : Int32T, para_level : UBiDiLevel, embedding_levels : UBiDiLevel*, p_error_code : UErrorCode*)
  fun ubidi_set_reordering_mode = ubidi_setReorderingMode{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, reordering_mode : UBiDiReorderingMode)
  fun ubidi_set_reordering_options = ubidi_setReorderingOptions{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, reordering_options : Uint32T)
  fun ubidi_write_reordered = ubidi_writeReordered{{SYMS_SUFFIX.id}}(p_bi_di : UBiDi, dest : UChar*, dest_size : Int32T, options : Uint16T, p_error_code : UErrorCode*) : Int32T
  fun ubidi_write_reverse = ubidi_writeReverse{{SYMS_SUFFIX.id}}(src : UChar*, src_length : Int32T, dest : UChar*, dest_size : Int32T, options : Uint16T, p_error_code : UErrorCode*) : Int32T
  type UBiDi = Void*
  {% end %}
end
