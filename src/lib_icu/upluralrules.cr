@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UPluralType
    TypeCardinal = 0
    TypeOrdinal  = 1
    TypeCount    = 2
  end
  fun uplrules_close = uplrules_close{{SYMS_SUFFIX.id}}(uplrules : UPluralRules)
  fun uplrules_open = uplrules_open{{SYMS_SUFFIX.id}}(locale : LibC::Char*, status : UErrorCode*) : UPluralRules
  fun uplrules_open_for_type = uplrules_openForType{{SYMS_SUFFIX.id}}(locale : LibC::Char*, type : UPluralType, status : UErrorCode*) : UPluralRules
  fun uplrules_select = uplrules_select{{SYMS_SUFFIX.id}}(uplrules : UPluralRules, number : LibC::Double, keyword : UChar*, capacity : Int32T, status : UErrorCode*) : Int32T
  type UPluralRules = Void*
  {% end %}
end
