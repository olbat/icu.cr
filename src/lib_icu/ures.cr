@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UResType
    UresNone      = -1
    UresString    =  0
    UresBinary    =  1
    UresTable     =  2
    UresAlias     =  3
    UresInt       =  7
    UresArray     =  8
    UresIntVector = 14
    ResNone       = -1
    ResString     =  0
    ResBinary     =  1
    ResTable      =  2
    ResAlias      =  3
    ResInt        =  7
    ResArray      =  8
    ResIntVector  = 14
    ResReserved   = 15
    UresLimit     = 16
  end
  fun ures_close = ures_close{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle)
  fun ures_count_array_items = ures_countArrayItems{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, resource_key : LibC::Char*, err : UErrorCode*) : Int32T
  fun ures_get_binary = ures_getBinary{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, len : Int32T*, status : UErrorCode*) : Uint8T*
  fun ures_get_by_index = ures_getByIndex{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, index_r : Int32T, fill_in : UResourceBundle, status : UErrorCode*) : UResourceBundle
  fun ures_get_by_key = ures_getByKey{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, key : LibC::Char*, fill_in : UResourceBundle, status : UErrorCode*) : UResourceBundle
  fun ures_get_int = ures_getInt{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, status : UErrorCode*) : Int32T
  fun ures_get_int_vector = ures_getIntVector{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, len : Int32T*, status : UErrorCode*) : Int32T*
  fun ures_get_key = ures_getKey{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle) : LibC::Char*
  fun ures_get_locale = ures_getLocale{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, status : UErrorCode*) : LibC::Char*
  fun ures_get_locale_by_type = ures_getLocaleByType{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, type : ULocDataLocaleType, status : UErrorCode*) : LibC::Char*
  fun ures_get_next_resource = ures_getNextResource{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, fill_in : UResourceBundle, status : UErrorCode*) : UResourceBundle
  fun ures_get_next_string = ures_getNextString{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, len : Int32T*, key : LibC::Char**, status : UErrorCode*) : UChar*
  fun ures_get_size = ures_getSize{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle) : Int32T
  fun ures_get_string = ures_getString{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, len : Int32T*, status : UErrorCode*) : UChar*
  fun ures_get_string_by_index = ures_getStringByIndex{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, index_s : Int32T, len : Int32T*, status : UErrorCode*) : UChar*
  fun ures_get_string_by_key = ures_getStringByKey{{SYMS_SUFFIX.id}}(res_b : UResourceBundle, key : LibC::Char*, len : Int32T*, status : UErrorCode*) : UChar*
  fun ures_get_type = ures_getType{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle) : UResType
  fun ures_get_u_int = ures_getUInt{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle, status : UErrorCode*) : Uint32T
  fun ures_get_ut_f8string = ures_getUTF8String{{SYMS_SUFFIX.id}}(res_b : UResourceBundle, dest : LibC::Char*, length : Int32T*, force_copy : UBool, status : UErrorCode*) : LibC::Char*
  fun ures_get_ut_f8string_by_index = ures_getUTF8StringByIndex{{SYMS_SUFFIX.id}}(res_b : UResourceBundle, string_index : Int32T, dest : LibC::Char*, p_length : Int32T*, force_copy : UBool, status : UErrorCode*) : LibC::Char*
  fun ures_get_ut_f8string_by_key = ures_getUTF8StringByKey{{SYMS_SUFFIX.id}}(res_b : UResourceBundle, key : LibC::Char*, dest : LibC::Char*, p_length : Int32T*, force_copy : UBool, status : UErrorCode*) : LibC::Char*
  fun ures_get_version = ures_getVersion{{SYMS_SUFFIX.id}}(res_b : UResourceBundle, version_info : UVersionInfo)
  fun ures_get_version_number = ures_getVersionNumber{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle) : LibC::Char*
  fun ures_has_next = ures_hasNext{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle) : UBool
  fun ures_open = ures_open{{SYMS_SUFFIX.id}}(package_name : LibC::Char*, locale : LibC::Char*, status : UErrorCode*) : UResourceBundle
  fun ures_open_available_locales = ures_openAvailableLocales{{SYMS_SUFFIX.id}}(package_name : LibC::Char*, status : UErrorCode*) : UEnumeration
  fun ures_open_direct = ures_openDirect{{SYMS_SUFFIX.id}}(package_name : LibC::Char*, locale : LibC::Char*, status : UErrorCode*) : UResourceBundle
  fun ures_open_fill_in = ures_openFillIn{{SYMS_SUFFIX.id}}(r : UResourceBundle, package_name : LibC::Char*, locale_id : LibC::Char*, status : UErrorCode*)
  fun ures_open_u = ures_openU{{SYMS_SUFFIX.id}}(package_name : UChar*, locale : LibC::Char*, status : UErrorCode*) : UResourceBundle
  fun ures_reset_iterator = ures_resetIterator{{SYMS_SUFFIX.id}}(resource_bundle : UResourceBundle)
  type UResourceBundle = Void*
  {% end %}
end
