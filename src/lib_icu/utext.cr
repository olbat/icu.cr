@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  fun utext_char32at = utext_char32At_52(ut : UText*, native_index : Int64T) : UChar32
  fun utext_clone = utext_clone_52(dest : UText*, src : UText*, deep : UBool, read_only : UBool, status : UErrorCode*) : UText*
  fun utext_close = utext_close_52(ut : UText*) : UText*
  fun utext_copy = utext_copy_52(ut : UText*, native_start : Int64T, native_limit : Int64T, dest_index : Int64T, move : UBool, status : UErrorCode*)
  fun utext_current32 = utext_current32_52(ut : UText*) : UChar32
  fun utext_equals = utext_equals_52(a : UText*, b : UText*) : UBool
  fun utext_extract = utext_extract_52(ut : UText*, native_start : Int64T, native_limit : Int64T, dest : UChar*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun utext_freeze = utext_freeze_52(ut : UText*)
  fun utext_get_native_index = utext_getNativeIndex_52(ut : UText*) : Int64T
  fun utext_get_previous_native_index = utext_getPreviousNativeIndex_52(ut : UText*) : Int64T
  fun utext_has_meta_data = utext_hasMetaData_52(ut : UText*) : UBool
  fun utext_is_length_expensive = utext_isLengthExpensive_52(ut : UText*) : UBool
  fun utext_is_writable = utext_isWritable_52(ut : UText*) : UBool
  fun utext_move_index32 = utext_moveIndex32_52(ut : UText*, delta : Int32T) : UBool
  fun utext_native_length = utext_nativeLength_52(ut : UText*) : Int64T
  fun utext_next32 = utext_next32_52(ut : UText*) : UChar32
  fun utext_next32from = utext_next32From_52(ut : UText*, native_index : Int64T) : UChar32
  fun utext_open_u_chars = utext_openUChars_52(ut : UText*, s : UChar*, length : Int64T, status : UErrorCode*) : UText*
  fun utext_open_ut_f8 = utext_openUTF8_52(ut : UText*, s : LibC::Char*, length : Int64T, status : UErrorCode*) : UText*
  fun utext_previous32 = utext_previous32_52(ut : UText*) : UChar32
  fun utext_previous32from = utext_previous32From_52(ut : UText*, native_index : Int64T) : UChar32
  fun utext_replace = utext_replace_52(ut : UText*, native_start : Int64T, native_limit : Int64T, replacement_text : UChar*, replacement_length : Int32T, status : UErrorCode*) : Int32T
  fun utext_set_native_index = utext_setNativeIndex_52(ut : UText*, native_index : Int64T)
  fun utext_setup = utext_setup_52(ut : UText*, extra_space : Int32T, status : UErrorCode*) : UText*
end
