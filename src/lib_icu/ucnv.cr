@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  alias UConverterFromUCallback = (Void*, UConverterFromUnicodeArgs*, UChar*, Int32T, UChar32, UConverterCallbackReason, UErrorCode* -> Void)
  alias UConverterToUCallback = (Void*, UConverterToUnicodeArgs*, LibC::Char*, Int32T, UConverterCallbackReason, UErrorCode* -> Void)
  enum UConverterCallbackReason
    UcnvUnassigned = 0
    UcnvIllegal    = 1
    UcnvIrregular  = 2
    UcnvReset      = 3
    UcnvClose      = 4
    UcnvClone      = 5
  end
  enum UConverterPlatform
    UcnvUnknown = -1
    UcnvIbm     =  0
  end
  enum UConverterType
    UcnvUnsupportedConverter            = -1
    UcnvSbcs                            =  0
    UcnvDbcs                            =  1
    UcnvMbcs                            =  2
    UcnvLatin1                          =  3
    UcnvUtF8                            =  4
    UcnvUtF16BigEndian                  =  5
    UcnvUtF16LittleEndian               =  6
    UcnvUtF32BigEndian                  =  7
    UcnvUtF32LittleEndian               =  8
    UcnvEbcdicStateful                  =  9
    UcnvIso2022                         = 10
    UcnvLmbcs1                          = 11
    UcnvLmbcs2                          = 12
    UcnvLmbcs3                          = 13
    UcnvLmbcs4                          = 14
    UcnvLmbcs5                          = 15
    UcnvLmbcs6                          = 16
    UcnvLmbcs8                          = 17
    UcnvLmbcs11                         = 18
    UcnvLmbcs16                         = 19
    UcnvLmbcs17                         = 20
    UcnvLmbcs18                         = 21
    UcnvLmbcs19                         = 22
    UcnvLmbcsLast                       = 22
    UcnvHz                              = 23
    UcnvScsu                            = 24
    UcnvIscii                           = 25
    UcnvUsAscii                         = 26
    UcnvUtF7                            = 27
    UcnvBocU1                           = 28
    UcnvUtF16                           = 29
    UcnvUtF32                           = 30
    UcnvCesU8                           = 31
    UcnvImapMailbox                     = 32
    UcnvCompoundText                    = 33
    UcnvNumberOfSupportedConverterTypes = 34
  end
  enum UConverterUnicodeSet
    UcnvRoundtripSet            = 0
    UcnvRoundtripAndFallbackSet = 1
    UcnvSetCount                = 2
  end
  fun ucnv_close = ucnv_close_52(converter : UConverter)
  fun ucnv_compare_names = ucnv_compareNames_52(name1 : LibC::Char*, name2 : LibC::Char*) : LibC::Int
  fun ucnv_convert = ucnv_convert_52(to_converter_name : LibC::Char*, from_converter_name : LibC::Char*, target : LibC::Char*, target_capacity : Int32T, source : LibC::Char*, source_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_convert_ex = ucnv_convertEx_52(target_cnv : UConverter, source_cnv : UConverter, target : LibC::Char**, target_limit : LibC::Char*, source : LibC::Char**, source_limit : LibC::Char*, pivot_start : UChar*, pivot_source : UChar**, pivot_target : UChar**, pivot_limit : UChar*, reset : UBool, flush : UBool, p_error_code : UErrorCode*)
  fun ucnv_count_aliases = ucnv_countAliases_52(alias : LibC::Char*, p_error_code : UErrorCode*) : Uint16T
  fun ucnv_count_available = ucnv_countAvailable_52 : Int32T
  fun ucnv_count_standards = ucnv_countStandards_52 : Uint16T
  fun ucnv_detect_unicode_signature = ucnv_detectUnicodeSignature_52(source : LibC::Char*, source_length : Int32T, signature_length : Int32T*, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_fix_file_separator = ucnv_fixFileSeparator_52(cnv : UConverter, source : UChar*, source_len : Int32T)
  fun ucnv_flush_cache = ucnv_flushCache_52 : Int32T
  fun ucnv_from_algorithmic = ucnv_fromAlgorithmic_52(cnv : UConverter, algorithmic_type : UConverterType, target : LibC::Char*, target_capacity : Int32T, source : LibC::Char*, source_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_from_u_chars = ucnv_fromUChars_52(cnv : UConverter, dest : LibC::Char*, dest_capacity : Int32T, src : UChar*, src_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_from_u_count_pending = ucnv_fromUCountPending_52(cnv : UConverter, status : UErrorCode*) : Int32T
  fun ucnv_from_unicode = ucnv_fromUnicode_52(converter : UConverter, target : LibC::Char**, target_limit : LibC::Char*, source : UChar**, source_limit : UChar*, offsets : Int32T*, flush : UBool, err : UErrorCode*)
  fun ucnv_get_alias = ucnv_getAlias_52(alias : LibC::Char*, n : Uint16T, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_get_aliases = ucnv_getAliases_52(alias : LibC::Char*, aliases : LibC::Char**, p_error_code : UErrorCode*)
  fun ucnv_get_available_name = ucnv_getAvailableName_52(n : Int32T) : LibC::Char*
  fun ucnv_get_canonical_name = ucnv_getCanonicalName_52(alias : LibC::Char*, standard : LibC::Char*, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_get_ccsid = ucnv_getCCSID_52(converter : UConverter, err : UErrorCode*) : Int32T
  fun ucnv_get_default_name = ucnv_getDefaultName_52 : LibC::Char*
  fun ucnv_get_display_name = ucnv_getDisplayName_52(converter : UConverter, display_locale : LibC::Char*, display_name : UChar*, display_name_capacity : Int32T, err : UErrorCode*) : Int32T
  fun ucnv_get_from_u_call_back = ucnv_getFromUCallBack_52(converter : UConverter, action : UConverterFromUCallback*, context : Void**)
  fun ucnv_get_invalid_chars = ucnv_getInvalidChars_52(converter : UConverter, err_bytes : LibC::Char*, len : Int8T*, err : UErrorCode*)
  fun ucnv_get_invalid_u_chars = ucnv_getInvalidUChars_52(converter : UConverter, err_u_chars : UChar*, len : Int8T*, err : UErrorCode*)
  fun ucnv_get_max_char_size = ucnv_getMaxCharSize_52(converter : UConverter) : Int8T
  fun ucnv_get_min_char_size = ucnv_getMinCharSize_52(converter : UConverter) : Int8T
  fun ucnv_get_name = ucnv_getName_52(converter : UConverter, err : UErrorCode*) : LibC::Char*
  fun ucnv_get_next_u_char = ucnv_getNextUChar_52(converter : UConverter, source : LibC::Char**, source_limit : LibC::Char*, err : UErrorCode*) : UChar32
  fun ucnv_get_platform = ucnv_getPlatform_52(converter : UConverter, err : UErrorCode*) : UConverterPlatform
  fun ucnv_get_standard = ucnv_getStandard_52(n : Uint16T, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_get_standard_name = ucnv_getStandardName_52(name : LibC::Char*, standard : LibC::Char*, p_error_code : UErrorCode*) : LibC::Char*
  fun ucnv_get_starters = ucnv_getStarters_52(converter : UConverter, starters : UBool[256], err : UErrorCode*)
  fun ucnv_get_subst_chars = ucnv_getSubstChars_52(converter : UConverter, sub_chars : LibC::Char*, len : Int8T*, err : UErrorCode*)
  fun ucnv_get_to_u_call_back = ucnv_getToUCallBack_52(converter : UConverter, action : UConverterToUCallback*, context : Void**)
  fun ucnv_get_type = ucnv_getType_52(converter : UConverter) : UConverterType
  fun ucnv_get_unicode_set = ucnv_getUnicodeSet_52(cnv : UConverter, set_fill_in : USet, which_set : UConverterUnicodeSet, p_error_code : UErrorCode*)
  fun ucnv_is_ambiguous = ucnv_isAmbiguous_52(cnv : UConverter) : UBool
  fun ucnv_is_fixed_width = ucnv_isFixedWidth_52(cnv : UConverter, status : UErrorCode*) : UBool
  fun ucnv_open = ucnv_open_52(converter_name : LibC::Char*, err : UErrorCode*) : UConverter
  fun ucnv_open_all_names = ucnv_openAllNames_52(p_error_code : UErrorCode*) : UEnumeration
  fun ucnv_open_ccsid = ucnv_openCCSID_52(codepage : Int32T, platform : UConverterPlatform, err : UErrorCode*) : UConverter
  fun ucnv_open_package = ucnv_openPackage_52(package_name : LibC::Char*, converter_name : LibC::Char*, err : UErrorCode*) : UConverter
  fun ucnv_open_standard_names = ucnv_openStandardNames_52(conv_name : LibC::Char*, standard : LibC::Char*, p_error_code : UErrorCode*) : UEnumeration
  fun ucnv_open_u = ucnv_openU_52(name : UChar*, err : UErrorCode*) : UConverter
  fun ucnv_reset = ucnv_reset_52(converter : UConverter)
  fun ucnv_reset_from_unicode = ucnv_resetFromUnicode_52(converter : UConverter)
  fun ucnv_reset_to_unicode = ucnv_resetToUnicode_52(converter : UConverter)
  fun ucnv_safe_clone = ucnv_safeClone_52(cnv : UConverter, stack_buffer : Void*, p_buffer_size : Int32T*, status : UErrorCode*) : UConverter
  fun ucnv_set_default_name = ucnv_setDefaultName_52(name : LibC::Char*)
  fun ucnv_set_fallback = ucnv_setFallback_52(cnv : UConverter, uses_fallback : UBool)
  fun ucnv_set_from_u_call_back = ucnv_setFromUCallBack_52(converter : UConverter, new_action : UConverterFromUCallback, new_context : Void*, old_action : UConverterFromUCallback*, old_context : Void**, err : UErrorCode*)
  fun ucnv_set_subst_chars = ucnv_setSubstChars_52(converter : UConverter, sub_chars : LibC::Char*, len : Int8T, err : UErrorCode*)
  fun ucnv_set_subst_string = ucnv_setSubstString_52(cnv : UConverter, s : UChar*, length : Int32T, err : UErrorCode*)
  fun ucnv_set_to_u_call_back = ucnv_setToUCallBack_52(converter : UConverter, new_action : UConverterToUCallback, new_context : Void*, old_action : UConverterToUCallback*, old_context : Void**, err : UErrorCode*)
  fun ucnv_to_algorithmic = ucnv_toAlgorithmic_52(algorithmic_type : UConverterType, cnv : UConverter, target : LibC::Char*, target_capacity : Int32T, source : LibC::Char*, source_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_to_u_chars = ucnv_toUChars_52(cnv : UConverter, dest : UChar*, dest_capacity : Int32T, src : LibC::Char*, src_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun ucnv_to_u_count_pending = ucnv_toUCountPending_52(cnv : UConverter, status : UErrorCode*) : Int32T
  fun ucnv_to_unicode = ucnv_toUnicode_52(converter : UConverter, target : UChar**, target_limit : UChar*, source : LibC::Char**, source_limit : LibC::Char*, offsets : Int32T*, flush : UBool, err : UErrorCode*)
  fun ucnv_uses_fallback = ucnv_usesFallback_52(cnv : UConverter) : UBool
  fun ucnvsel_close = ucnvsel_close_52(sel : UConverterSelector)
  fun ucnvsel_open = ucnvsel_open_52(converter_list : LibC::Char**, converter_list_size : Int32T, excluded_code_points : USet, which_set : UConverterUnicodeSet, status : UErrorCode*) : UConverterSelector
  fun ucnvsel_open_from_serialized = ucnvsel_openFromSerialized_52(buffer : Void*, length : Int32T, status : UErrorCode*) : UConverterSelector
  fun ucnvsel_select_for_string = ucnvsel_selectForString_52(sel : UConverterSelector, s : UChar*, length : Int32T, status : UErrorCode*) : UEnumeration
  fun ucnvsel_select_for_ut_f8 = ucnvsel_selectForUTF8_52(sel : UConverterSelector, s : LibC::Char*, length : Int32T, status : UErrorCode*) : UEnumeration
  fun ucnvsel_serialize = ucnvsel_serialize_52(sel : UConverterSelector, buffer : Void*, buffer_capacity : Int32T, status : UErrorCode*) : Int32T

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
end
