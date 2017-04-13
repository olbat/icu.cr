@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  alias Int16T = LibC::Short
  fun uidna_close = uidna_close_52(idna : Uidna)
  fun uidna_compare = uidna_compare_52(s1 : UChar*, length1 : Int32T, s2 : UChar*, length2 : Int32T, options : Int32T, status : UErrorCode*) : Int32T
  fun uidna_idn_to_ascii = uidna_IDNToASCII_52(src : UChar*, src_length : Int32T, dest : UChar*, dest_capacity : Int32T, options : Int32T, parse_error : UParseError*, status : UErrorCode*) : Int32T
  fun uidna_idn_to_unicode = uidna_IDNToUnicode_52(src : UChar*, src_length : Int32T, dest : UChar*, dest_capacity : Int32T, options : Int32T, parse_error : UParseError*, status : UErrorCode*) : Int32T
  fun uidna_label_to_ascii = uidna_labelToASCII_52(idna : Uidna, label : UChar*, length : Int32T, dest : UChar*, capacity : Int32T, p_info : UidnaInfo*, p_error_code : UErrorCode*) : Int32T
  fun uidna_label_to_ascii_ut_f8 = uidna_labelToASCII_UTF8_52(idna : Uidna, label : LibC::Char*, length : Int32T, dest : LibC::Char*, capacity : Int32T, p_info : UidnaInfo*, p_error_code : UErrorCode*) : Int32T
  fun uidna_label_to_unicode = uidna_labelToUnicode_52(idna : Uidna, label : UChar*, length : Int32T, dest : UChar*, capacity : Int32T, p_info : UidnaInfo*, p_error_code : UErrorCode*) : Int32T
  fun uidna_label_to_unicode_ut_f8 = uidna_labelToUnicodeUTF8_52(idna : Uidna, label : LibC::Char*, length : Int32T, dest : LibC::Char*, capacity : Int32T, p_info : UidnaInfo*, p_error_code : UErrorCode*) : Int32T
  fun uidna_name_to_ascii = uidna_nameToASCII_52(idna : Uidna, name : UChar*, length : Int32T, dest : UChar*, capacity : Int32T, p_info : UidnaInfo*, p_error_code : UErrorCode*) : Int32T
  fun uidna_name_to_ascii_ut_f8 = uidna_nameToASCII_UTF8_52(idna : Uidna, name : LibC::Char*, length : Int32T, dest : LibC::Char*, capacity : Int32T, p_info : UidnaInfo*, p_error_code : UErrorCode*) : Int32T
  fun uidna_name_to_unicode = uidna_nameToUnicode_52(idna : Uidna, name : UChar*, length : Int32T, dest : UChar*, capacity : Int32T, p_info : UidnaInfo*, p_error_code : UErrorCode*) : Int32T
  fun uidna_name_to_unicode_ut_f8 = uidna_nameToUnicodeUTF8_52(idna : Uidna, name : LibC::Char*, length : Int32T, dest : LibC::Char*, capacity : Int32T, p_info : UidnaInfo*, p_error_code : UErrorCode*) : Int32T
  fun uidna_open_ut_s46 = uidna_openUTS46_52(options : Uint32T, p_error_code : UErrorCode*) : Uidna
  fun uidna_to_ascii = uidna_toASCII_52(src : UChar*, src_length : Int32T, dest : UChar*, dest_capacity : Int32T, options : Int32T, parse_error : UParseError*, status : UErrorCode*) : Int32T
  fun uidna_to_unicode = uidna_toUnicode_52(src : UChar*, src_length : Int32T, dest : UChar*, dest_capacity : Int32T, options : Int32T, parse_error : UParseError*, status : UErrorCode*) : Int32T

  struct UidnaInfo
    size : Int16T
    is_transitional_different : UBool
    reserved_b3 : UBool
    errors : Uint32T
    reserved_i2 : Int32T
    reserved_i3 : Int32T
  end

  type Uidna = Void*
end
