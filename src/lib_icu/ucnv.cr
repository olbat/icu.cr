@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  alias UConverterFromUCallback = (Void*, UConverterFromUnicodeArgs*, UChar*, Int32T, UChar32, UConverterCallbackReason, UErrorCode* -> Void)
  alias UConverterToUCallback = (Void*, UConverterToUnicodeArgs*, LibC::Char*, Int32T, UConverterCallbackReason, UErrorCode* -> Void)
  enum UConverterCallbackReason
    Unassigned = 0
    Illegal    = 1
    Irregular  = 2
    Reset      = 3
    Close      = 4
    Clone      = 5
  end
  enum UConverterPlatform
    Unknown = -1
    Ibm     =  0
  end
  enum UConverterType
    UnsupportedConverter            = -1
    Sbcs                            =  0
    Dbcs                            =  1
    Mbcs                            =  2
    Latin1                          =  3
    Utf8                            =  4
    Utf16BigEndian                  =  5
    Utf16LittleEndian               =  6
    Utf32BigEndian                  =  7
    Utf32LittleEndian               =  8
    EbcdicStateful                  =  9
    Iso2022                         = 10
    Lmbcs1                          = 11
    Lmbcs2                          = 12
    Lmbcs3                          = 13
    Lmbcs4                          = 14
    Lmbcs5                          = 15
    Lmbcs6                          = 16
    Lmbcs8                          = 17
    Lmbcs11                         = 18
    Lmbcs16                         = 19
    Lmbcs17                         = 20
    Lmbcs18                         = 21
    Lmbcs19                         = 22
    LmbcsLast                       = 22
    Hz                              = 23
    Scsu                            = 24
    Iscii                           = 25
    UsAscii                         = 26
    Utf7                            = 27
    Bocu1                           = 28
    Utf16                           = 29
    Utf32                           = 30
    Cesu8                           = 31
    ImapMailbox                     = 32
    CompoundText                    = 33
    NumberOfSupportedConverterTypes = 34
  end
  enum UConverterUnicodeSet
    RoundtripSet            = 0
    RoundtripAndFallbackSet = 1
    SetCount                = 2
  end
  fun ucnv_close = ucnv_close{{SYMS_SUFFIX.id}}(converter : UConverter)
  fun ucnv_compare_names = ucnv_compareNames{{SYMS_SUFFIX.id}}(name1 : LibC::Char*, name2 : LibC::Char*) : LibC::Int
  fun ucnv_convert = ucnv_convert{{SYMS_SUFFIX.id}}(to_converter_name : LibC::Char*, from_converter_name : LibC::Char*, target : LibC::Char*, target_capacity : Int32T, source : LibC::Char*, source_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_convert_ex = ucnv_convertEx{{SYMS_SUFFIX.id}}(target_cnv : UConverter, source_cnv : UConverter, target : LibC::Char**, target_limit : LibC::Char*, source : LibC::Char**, source_limit : LibC::Char*, pivot_start : UChar*, pivot_source : UChar**, pivot_target : UChar**, pivot_limit : UChar*, reset : UBool, flush : UBool, p_error_code : UErrorCode*)
  fun ucnv_count_aliases = ucnv_countAliases{{SYMS_SUFFIX.id}}(alias : LibC::Char*, p_error_code : UErrorCode*) : Uint16T
  fun ucnv_count_available = ucnv_countAvailable{{SYMS_SUFFIX.id}} : Int32T
  fun ucnv_count_standards = ucnv_countStandards{{SYMS_SUFFIX.id}} : Uint16T
  fun ucnv_detect_unicode_signature = ucnv_detectUnicodeSignature{{SYMS_SUFFIX.id}}(source : LibC::Char*, source_length : Int32T, signature_length : Int32T*, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_fix_file_separator = ucnv_fixFileSeparator{{SYMS_SUFFIX.id}}(cnv : UConverter, source : UChar*, source_len : Int32T)
  fun ucnv_flush_cache = ucnv_flushCache{{SYMS_SUFFIX.id}} : Int32T
  fun ucnv_from_algorithmic = ucnv_fromAlgorithmic{{SYMS_SUFFIX.id}}(cnv : UConverter, algorithmic_type : UConverterType, target : LibC::Char*, target_capacity : Int32T, source : LibC::Char*, source_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_from_u_chars = ucnv_fromUChars{{SYMS_SUFFIX.id}}(cnv : UConverter, dest : LibC::Char*, dest_capacity : Int32T, src : UChar*, src_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_from_u_count_pending = ucnv_fromUCountPending{{SYMS_SUFFIX.id}}(cnv : UConverter, status : UErrorCode*) : Int32T
  fun ucnv_from_unicode = ucnv_fromUnicode{{SYMS_SUFFIX.id}}(converter : UConverter, target : LibC::Char**, target_limit : LibC::Char*, source : UChar**, source_limit : UChar*, offsets : Int32T*, flush : UBool, err : UErrorCode*)
  fun ucnv_get_alias = ucnv_getAlias{{SYMS_SUFFIX.id}}(alias : LibC::Char*, n : Uint16T, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_get_aliases = ucnv_getAliases{{SYMS_SUFFIX.id}}(alias : LibC::Char*, aliases : LibC::Char**, p_error_code : UErrorCode*)
  fun ucnv_get_available_name = ucnv_getAvailableName{{SYMS_SUFFIX.id}}(n : Int32T) : LibC::Char*
  fun ucnv_get_canonical_name = ucnv_getCanonicalName{{SYMS_SUFFIX.id}}(alias : LibC::Char*, standard : LibC::Char*, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_get_ccsid = ucnv_getCCSID{{SYMS_SUFFIX.id}}(converter : UConverter, err : UErrorCode*) : Int32T
  fun ucnv_get_default_name = ucnv_getDefaultName{{SYMS_SUFFIX.id}} : LibC::Char*
  fun ucnv_get_display_name = ucnv_getDisplayName{{SYMS_SUFFIX.id}}(converter : UConverter, display_locale : LibC::Char*, display_name : UChar*, display_name_capacity : Int32T, err : UErrorCode*) : Int32T
  fun ucnv_get_from_u_call_back = ucnv_getFromUCallBack{{SYMS_SUFFIX.id}}(converter : UConverter, action : UConverterFromUCallback*, context : Void**)
  fun ucnv_get_invalid_chars = ucnv_getInvalidChars{{SYMS_SUFFIX.id}}(converter : UConverter, err_bytes : LibC::Char*, len : Int8T*, err : UErrorCode*)
  fun ucnv_get_invalid_u_chars = ucnv_getInvalidUChars{{SYMS_SUFFIX.id}}(converter : UConverter, err_u_chars : UChar*, len : Int8T*, err : UErrorCode*)
  fun ucnv_get_max_char_size = ucnv_getMaxCharSize{{SYMS_SUFFIX.id}}(converter : UConverter) : Int8T
  fun ucnv_get_min_char_size = ucnv_getMinCharSize{{SYMS_SUFFIX.id}}(converter : UConverter) : Int8T
  fun ucnv_get_name = ucnv_getName{{SYMS_SUFFIX.id}}(converter : UConverter, err : UErrorCode*) : LibC::Char*
  fun ucnv_get_next_u_char = ucnv_getNextUChar{{SYMS_SUFFIX.id}}(converter : UConverter, source : LibC::Char**, source_limit : LibC::Char*, err : UErrorCode*) : UChar32
  fun ucnv_get_platform = ucnv_getPlatform{{SYMS_SUFFIX.id}}(converter : UConverter, err : UErrorCode*) : UConverterPlatform
  fun ucnv_get_standard = ucnv_getStandard{{SYMS_SUFFIX.id}}(n : Uint16T, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_get_standard_name = ucnv_getStandardName{{SYMS_SUFFIX.id}}(name : LibC::Char*, standard : LibC::Char*, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_get_starters = ucnv_getStarters{{SYMS_SUFFIX.id}}(converter : UConverter, starters : UBool[256], err : UErrorCode*)
  fun ucnv_get_subst_chars = ucnv_getSubstChars{{SYMS_SUFFIX.id}}(converter : UConverter, sub_chars : LibC::Char*, len : Int8T*, err : UErrorCode*)
  fun ucnv_get_to_u_call_back = ucnv_getToUCallBack{{SYMS_SUFFIX.id}}(converter : UConverter, action : UConverterToUCallback*, context : Void**)
  fun ucnv_get_type = ucnv_getType{{SYMS_SUFFIX.id}}(converter : UConverter) : UConverterType
  fun ucnv_get_unicode_set = ucnv_getUnicodeSet{{SYMS_SUFFIX.id}}(cnv : UConverter, set_fill_in : USet, which_set : UConverterUnicodeSet, p_error_code : UErrorCode*)
  fun ucnv_is_ambiguous = ucnv_isAmbiguous{{SYMS_SUFFIX.id}}(cnv : UConverter) : UBool
  fun ucnv_is_fixed_width = ucnv_isFixedWidth{{SYMS_SUFFIX.id}}(cnv : UConverter, status : UErrorCode*) : UBool
  fun ucnv_open = ucnv_open{{SYMS_SUFFIX.id}}(converter_name : LibC::Char*, err : UErrorCode*) : UConverter
  fun ucnv_open_all_names = ucnv_openAllNames{{SYMS_SUFFIX.id}}(p_error_code : UErrorCode*) : UEnumeration
  fun ucnv_open_ccsid = ucnv_openCCSID{{SYMS_SUFFIX.id}}(codepage : Int32T, platform : UConverterPlatform, err : UErrorCode*) : UConverter
  fun ucnv_open_package = ucnv_openPackage{{SYMS_SUFFIX.id}}(package_name : LibC::Char*, converter_name : LibC::Char*, err : UErrorCode*) : UConverter
  fun ucnv_open_standard_names = ucnv_openStandardNames{{SYMS_SUFFIX.id}}(conv_name : LibC::Char*, standard : LibC::Char*, p_error_code : UErrorCode*) : UEnumeration
  fun ucnv_open_u = ucnv_openU{{SYMS_SUFFIX.id}}(name : UChar*, err : UErrorCode*) : UConverter
  fun ucnv_reset = ucnv_reset{{SYMS_SUFFIX.id}}(converter : UConverter)
  fun ucnv_reset_from_unicode = ucnv_resetFromUnicode{{SYMS_SUFFIX.id}}(converter : UConverter)
  fun ucnv_reset_to_unicode = ucnv_resetToUnicode{{SYMS_SUFFIX.id}}(converter : UConverter)
  fun ucnv_safe_clone = ucnv_safeClone{{SYMS_SUFFIX.id}}(cnv : UConverter, stack_buffer : Void*, p_buffer_size : Int32T*, status : UErrorCode*) : UConverter
  fun ucnv_set_default_name = ucnv_setDefaultName{{SYMS_SUFFIX.id}}(name : LibC::Char*)
  fun ucnv_set_fallback = ucnv_setFallback{{SYMS_SUFFIX.id}}(cnv : UConverter, uses_fallback : UBool)
  fun ucnv_set_from_u_call_back = ucnv_setFromUCallBack{{SYMS_SUFFIX.id}}(converter : UConverter, new_action : UConverterFromUCallback, new_context : Void*, old_action : UConverterFromUCallback*, old_context : Void**, err : UErrorCode*)
  fun ucnv_set_subst_chars = ucnv_setSubstChars{{SYMS_SUFFIX.id}}(converter : UConverter, sub_chars : LibC::Char*, len : Int8T, err : UErrorCode*)
  fun ucnv_set_subst_string = ucnv_setSubstString{{SYMS_SUFFIX.id}}(cnv : UConverter, s : UChar*, length : Int32T, err : UErrorCode*)
  fun ucnv_set_to_u_call_back = ucnv_setToUCallBack{{SYMS_SUFFIX.id}}(converter : UConverter, new_action : UConverterToUCallback, new_context : Void*, old_action : UConverterToUCallback*, old_context : Void**, err : UErrorCode*)
  fun ucnv_to_algorithmic = ucnv_toAlgorithmic{{SYMS_SUFFIX.id}}(algorithmic_type : UConverterType, cnv : UConverter, target : LibC::Char*, target_capacity : Int32T, source : LibC::Char*, source_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_to_u_chars = ucnv_toUChars{{SYMS_SUFFIX.id}}(cnv : UConverter, dest : UChar*, dest_capacity : Int32T, src : LibC::Char*, src_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_to_u_count_pending = ucnv_toUCountPending{{SYMS_SUFFIX.id}}(cnv : UConverter, status : UErrorCode*) : Int32T
  fun ucnv_to_unicode = ucnv_toUnicode{{SYMS_SUFFIX.id}}(converter : UConverter, target : UChar**, target_limit : UChar*, source : LibC::Char**, source_limit : LibC::Char*, offsets : Int32T*, flush : UBool, err : UErrorCode*)
  fun ucnv_uses_fallback = ucnv_usesFallback{{SYMS_SUFFIX.id}}(cnv : UConverter) : UBool
  fun ucnvsel_close = ucnvsel_close{{SYMS_SUFFIX.id}}(sel : UConverterSelector)
  fun ucnvsel_open = ucnvsel_open{{SYMS_SUFFIX.id}}(converter_list : LibC::Char**, converter_list_size : Int32T, excluded_code_points : USet, which_set : UConverterUnicodeSet, status : UErrorCode*) : UConverterSelector
  fun ucnvsel_open_from_serialized = ucnvsel_openFromSerialized{{SYMS_SUFFIX.id}}(buffer : Void*, length : Int32T, status : UErrorCode*) : UConverterSelector
  fun ucnvsel_select_for_string = ucnvsel_selectForString{{SYMS_SUFFIX.id}}(sel : UConverterSelector, s : UChar*, length : Int32T, status : UErrorCode*) : UEnumeration
  fun ucnvsel_select_for_utf8 = ucnvsel_selectForUTF8{{SYMS_SUFFIX.id}}(sel : UConverterSelector, s : LibC::Char*, length : Int32T, status : UErrorCode*) : UEnumeration
  fun ucnvsel_serialize = ucnvsel_serialize{{SYMS_SUFFIX.id}}(sel : UConverterSelector, buffer : Void*, buffer_capacity : Int32T, status : UErrorCode*) : Int32T

  struct UConverterFromUnicodeArgs
    size : Uint16T
    flush : UBool
    converter : UConverter
    source : UChar*
    source_limit : UChar*
    target : LibC::Char*
    target_limit : LibC::Char*
    offsets : Int32T*
  end

  struct UConverterToUnicodeArgs
    size : Uint16T
    flush : UBool
    converter : UConverter
    source : LibC::Char*
    source_limit : LibC::Char*
    target : UChar*
    target_limit : UChar*
    offsets : Int32T*
  end

  type UConverter = Void*
  type UConverterSelector = Void*
  {% end %}
end
