@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  enum UPluralType
    UpluralTypeCardinal = 0
    UpluralTypeOrdinal  = 1
    UpluralTypeCount    = 2
  end
  fun uplrules_close = uplrules_close_52(uplrules : UPluralRules)
  fun uplrules_open = uplrules_open_52(locale : LibC::Char*, status : UErrorCode*) : UPluralRules
  fun uplrules_open_for_type = uplrules_openForType_52(locale : LibC::Char*, type : UPluralType, status : UErrorCode*) : UPluralRules
  fun uplrules_select = uplrules_select_52(uplrules : UPluralRules, number : LibC::Double, keyword : UChar*, capacity : Int32T, status : UErrorCode*) : Int32T
  type UPluralRules = Void*
end
