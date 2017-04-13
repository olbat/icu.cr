@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  fun uenum_close = uenum_close_52(en : UEnumeration)
  fun uenum_count = uenum_count_52(en : UEnumeration, status : UErrorCode*) : Int32T
  fun uenum_next = uenum_next_52(en : UEnumeration, result_length : Int32T*, status : UErrorCode*) : LibC::Char*
  fun uenum_open_char_strings_enumeration = uenum_openCharStringsEnumeration_52(strings : LibC::Char**, count : Int32T, ec : UErrorCode*) : UEnumeration
  fun uenum_open_u_char_strings_enumeration = uenum_openUCharStringsEnumeration_52(strings : UChar**, count : Int32T, ec : UErrorCode*) : UEnumeration
  fun uenum_reset = uenum_reset_52(en : UEnumeration, status : UErrorCode*)
  fun uenum_unext = uenum_unext_52(en : UEnumeration, result_length : Int32T*, status : UErrorCode*) : UChar*
end
