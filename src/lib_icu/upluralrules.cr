@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  alias UFormattedNumber = Void
  alias UFormattedNumberRange = Void
  enum UPluralType
    TypeCardinal = 0
    TypeOrdinal  = 1
    TypeCount    = 2
  end
  fun uplrules_close = uplrules_close{{SYMS_SUFFIX.id}}(uplrules : UPluralRules)
  fun uplrules_get_keywords = uplrules_getKeywords{{SYMS_SUFFIX.id}}(uplrules : UPluralRules, status : UErrorCode*) : UEnumeration
  fun uplrules_open = uplrules_open{{SYMS_SUFFIX.id}}(locale : LibC::Char*, status : UErrorCode*) : UPluralRules
  fun uplrules_open_for_type = uplrules_openForType{{SYMS_SUFFIX.id}}(locale : LibC::Char*, type : UPluralType, status : UErrorCode*) : UPluralRules
  fun uplrules_select = uplrules_select{{SYMS_SUFFIX.id}}(uplrules : UPluralRules, number : LibC::Double, keyword : UChar*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun uplrules_select_for_range = uplrules_selectForRange{{SYMS_SUFFIX.id}}(uplrules : UPluralRules, urange : UFormattedNumberRange*, keyword : UChar*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun uplrules_select_formatted = uplrules_selectFormatted{{SYMS_SUFFIX.id}}(uplrules : UPluralRules, number : UFormattedNumber*, keyword : UChar*, capacity : Int32T, status : UErrorCode*) : Int32T
  fun uplrules_select_with_format = uplrules_selectWithFormat{{SYMS_SUFFIX.id}}(uplrules : UPluralRules, number : LibC::Double, fmt : UNumberFormat*, keyword : UChar*, capacity : Int32T, status : UErrorCode*) : Int32T
  type UPluralRules = Void*
  {% end %}
end
