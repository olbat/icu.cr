@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UStringPrepProfileType
    UsprepRfC3491Nameprep            =  0
    UsprepRfC3530NfS4CsPrep          =  1
    UsprepRfC3530NfS4CsPrepCi        =  2
    UsprepRfC3530NfS4CisPrep         =  3
    UsprepRfC3530NfS4MixedPrepPrefix =  4
    UsprepRfC3530NfS4MixedPrepSuffix =  5
    UsprepRfC3722Iscsi               =  6
    UsprepRfC3920Nodeprep            =  7
    UsprepRfC3920Resourceprep        =  8
    UsprepRfC4011Mib                 =  9
    UsprepRfC4013Saslprep            = 10
    UsprepRfC4505Trace               = 11
    UsprepRfC4518Ldap                = 12
    UsprepRfC4518LdapCi              = 13
  end
  fun usprep_close = usprep_close{{SYMS_SUFFIX.id}}(profile : UStringPrepProfile)
  fun usprep_open = usprep_open{{SYMS_SUFFIX.id}}(path : LibC::Char*, file_name : LibC::Char*, status : UErrorCode*) : UStringPrepProfile
  fun usprep_open_by_type = usprep_openByType{{SYMS_SUFFIX.id}}(type : UStringPrepProfileType, status : UErrorCode*) : UStringPrepProfile
  fun usprep_prepare = usprep_prepare{{SYMS_SUFFIX.id}}(prep : UStringPrepProfile, src : UChar*, src_length : Int32T, dest : UChar*, dest_capacity : Int32T, options : Int32T, parse_error : UParseError*, status : UErrorCode*) : Int32T
  type UStringPrepProfile = Void*
  {% end %}
end
