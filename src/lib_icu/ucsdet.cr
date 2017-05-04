@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  fun ucsdet_close = ucsdet_close{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector)
  fun ucsdet_detect = ucsdet_detect{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector, status : UErrorCode*) : UCharsetMatch
  fun ucsdet_detect_all = ucsdet_detectAll{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector, matches_found : Int32T*, status : UErrorCode*) : UCharsetMatch*
  fun ucsdet_enable_input_filter = ucsdet_enableInputFilter{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector, filter : UBool) : UBool
  fun ucsdet_get_all_detectable_charsets = ucsdet_getAllDetectableCharsets{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector, status : UErrorCode*) : UEnumeration
  fun ucsdet_get_confidence = ucsdet_getConfidence{{SYMS_SUFFIX.id}}(ucsm : UCharsetMatch, status : UErrorCode*) : Int32T
  fun ucsdet_get_detectable_charsets = ucsdet_getDetectableCharsets{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector, status : UErrorCode*) : UEnumeration
  fun ucsdet_get_language = ucsdet_getLanguage{{SYMS_SUFFIX.id}}(ucsm : UCharsetMatch, status : UErrorCode*) : LibC::Char*
  fun ucsdet_get_name = ucsdet_getName{{SYMS_SUFFIX.id}}(ucsm : UCharsetMatch, status : UErrorCode*) : LibC::Char*
  fun ucsdet_get_u_chars = ucsdet_getUChars{{SYMS_SUFFIX.id}}(ucsm : UCharsetMatch, buf : UChar*, cap : Int32T, status : UErrorCode*) : Int32T
  fun ucsdet_is_input_filter_enabled = ucsdet_isInputFilterEnabled{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector) : UBool
  fun ucsdet_open = ucsdet_open{{SYMS_SUFFIX.id}}(status : UErrorCode*) : UCharsetDetector
  fun ucsdet_set_declared_encoding = ucsdet_setDeclaredEncoding{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector, encoding : LibC::Char*, length : Int32T, status : UErrorCode*)
  fun ucsdet_set_detectable_charset = ucsdet_setDetectableCharset{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector, encoding : LibC::Char*, enabled : UBool, status : UErrorCode*)
  fun ucsdet_set_text = ucsdet_setText{{SYMS_SUFFIX.id}}(ucsd : UCharsetDetector, text_in : LibC::Char*, len : Int32T, status : UErrorCode*)
  type UCharsetDetector = Void*
  type UCharsetMatch = Void*
  {% end %}
end
