@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  fun uenum_close = uenum_close{{SYMS_SUFFIX.id}}(en : UEnumeration)
  fun uenum_count = uenum_count{{SYMS_SUFFIX.id}}(en : UEnumeration, status : UErrorCode*) : Int32T
  fun uenum_next = uenum_next{{SYMS_SUFFIX.id}}(en : UEnumeration, result_length : Int32T*, status : UErrorCode*) : LibC::Char*
  fun uenum_open_char_strings_enumeration = uenum_openCharStringsEnumeration{{SYMS_SUFFIX.id}}(strings : LibC::Char**, count : Int32T, ec : UErrorCode*) : UEnumeration
  fun uenum_open_u_char_strings_enumeration = uenum_openUCharStringsEnumeration{{SYMS_SUFFIX.id}}(strings : UChar**, count : Int32T, ec : UErrorCode*) : UEnumeration
  fun uenum_reset = uenum_reset{{SYMS_SUFFIX.id}}(en : UEnumeration, status : UErrorCode*)
  fun uenum_unext = uenum_unext{{SYMS_SUFFIX.id}}(en : UEnumeration, result_length : Int32T*, status : UErrorCode*) : UChar*
  {% end %}
end
