@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  fun utext_char32at = utext_char32At{{SYMS_SUFFIX.id}}(ut : UText*, native_index : Int64T) : UChar32
  fun utext_clone = utext_clone{{SYMS_SUFFIX.id}}(dest : UText*, src : UText*, deep : UBool, read_only : UBool, status : UErrorCode*) : UText*
  fun utext_close = utext_close{{SYMS_SUFFIX.id}}(ut : UText*) : UText*
  fun utext_copy = utext_copy{{SYMS_SUFFIX.id}}(ut : UText*, native_start : Int64T, native_limit : Int64T, dest_index : Int64T, move : UBool, status : UErrorCode*)
  fun utext_current32 = utext_current32{{SYMS_SUFFIX.id}}(ut : UText*) : UChar32
  fun utext_equals = utext_equals{{SYMS_SUFFIX.id}}(a : UText*, b : UText*) : UBool
  fun utext_extract = utext_extract{{SYMS_SUFFIX.id}}(ut : UText*, native_start : Int64T, native_limit : Int64T, dest : UChar*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun utext_freeze = utext_freeze{{SYMS_SUFFIX.id}}(ut : UText*)
  fun utext_get_native_index = utext_getNativeIndex{{SYMS_SUFFIX.id}}(ut : UText*) : Int64T
  fun utext_get_previous_native_index = utext_getPreviousNativeIndex{{SYMS_SUFFIX.id}}(ut : UText*) : Int64T
  fun utext_has_meta_data = utext_hasMetaData{{SYMS_SUFFIX.id}}(ut : UText*) : UBool
  fun utext_is_length_expensive = utext_isLengthExpensive{{SYMS_SUFFIX.id}}(ut : UText*) : UBool
  fun utext_is_writable = utext_isWritable{{SYMS_SUFFIX.id}}(ut : UText*) : UBool
  fun utext_move_index32 = utext_moveIndex32{{SYMS_SUFFIX.id}}(ut : UText*, delta : Int32T) : UBool
  fun utext_native_length = utext_nativeLength{{SYMS_SUFFIX.id}}(ut : UText*) : Int64T
  fun utext_next32 = utext_next32{{SYMS_SUFFIX.id}}(ut : UText*) : UChar32
  fun utext_next32from = utext_next32From{{SYMS_SUFFIX.id}}(ut : UText*, native_index : Int64T) : UChar32
  fun utext_open_u_chars = utext_openUChars{{SYMS_SUFFIX.id}}(ut : UText*, s : UChar*, length : Int64T, status : UErrorCode*) : UText*
  fun utext_open_ut_f8 = utext_openUTF8{{SYMS_SUFFIX.id}}(ut : UText*, s : LibC::Char*, length : Int64T, status : UErrorCode*) : UText*
  fun utext_previous32 = utext_previous32{{SYMS_SUFFIX.id}}(ut : UText*) : UChar32
  fun utext_previous32from = utext_previous32From{{SYMS_SUFFIX.id}}(ut : UText*, native_index : Int64T) : UChar32
  fun utext_replace = utext_replace{{SYMS_SUFFIX.id}}(ut : UText*, native_start : Int64T, native_limit : Int64T, replacement_text : UChar*, replacement_length : Int32T, status : UErrorCode*) : Int32T
  fun utext_set_native_index = utext_setNativeIndex{{SYMS_SUFFIX.id}}(ut : UText*, native_index : Int64T)
  fun utext_setup = utext_setup{{SYMS_SUFFIX.id}}(ut : UText*, extra_space : Int32T, status : UErrorCode*) : UText*
  {% end %}
end
