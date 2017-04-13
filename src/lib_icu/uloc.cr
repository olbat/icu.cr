@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  enum UAcceptResult
    UlocAcceptFailed   = 0
    UlocAcceptValid    = 1
    UlocAcceptFallback = 2
  end
  enum ULayoutType
    UlocLayoutLtr     = 0
    UlocLayoutRtl     = 1
    UlocLayoutTtb     = 2
    UlocLayoutBtt     = 3
    UlocLayoutUnknown = 4
  end
  enum ULocaleDataDelimiterType
    UlocdataQuotationStart    = 0
    UlocdataQuotationEnd      = 1
    UlocdataAltQuotationStart = 2
    UlocdataAltQuotationEnd   = 3
    UlocdataDelimiterCount    = 4
  end
  enum ULocaleDataExemplarSetType
    UlocdataEsStandard    = 0
    UlocdataEsAuxiliary   = 1
    UlocdataEsIndex       = 2
    UlocdataEsPunctuation = 3
    UlocdataEsCount       = 4
  end
  enum UMeasurementSystem
    UmsSi    = 0
    UmsUs    = 1
    UmsLimit = 2
  end
  fun uloc_accept_language = uloc_acceptLanguage_52(result : LibC::Char*, result_available : Int32T, out_result : UAcceptResult*, accept_list : LibC::Char**, accept_list_count : Int32T, available_locales : UEnumeration, status : UErrorCode*) : Int32T
  fun uloc_accept_language_from_http = uloc_acceptLanguageFromHTTP_52(result : LibC::Char*, result_available : Int32T, out_result : UAcceptResult*, http_accept_language : LibC::Char*, available_locales : UEnumeration, status : UErrorCode*) : Int32T
  fun uloc_add_likely_subtags = uloc_addLikelySubtags_52(locale_id : LibC::Char*, maximized_locale_id : LibC::Char*, maximized_locale_id_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_canonicalize = uloc_canonicalize_52(locale_id : LibC::Char*, name : LibC::Char*, name_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_count_available = uloc_countAvailable_52 : Int32T
  fun uloc_for_language_tag = uloc_forLanguageTag_52(langtag : LibC::Char*, locale_id : LibC::Char*, locale_id_capacity : Int32T, parsed_length : Int32T*, err : UErrorCode*) : Int32T
  fun uloc_get_available = uloc_getAvailable_52(n : Int32T) : LibC::Char*
  fun uloc_get_base_name = uloc_getBaseName_52(locale_id : LibC::Char*, name : LibC::Char*, name_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_character_orientation = uloc_getCharacterOrientation_52(locale_id : LibC::Char*, status : UErrorCode*) : ULayoutType
  fun uloc_get_country = uloc_getCountry_52(locale_id : LibC::Char*, country : LibC::Char*, country_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_default = uloc_getDefault_52 : LibC::Char*
  fun uloc_get_display_country = uloc_getDisplayCountry_52(locale : LibC::Char*, display_locale : LibC::Char*, country : UChar*, country_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_keyword = uloc_getDisplayKeyword_52(keyword : LibC::Char*, display_locale : LibC::Char*, dest : UChar*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_keyword_value = uloc_getDisplayKeywordValue_52(locale : LibC::Char*, keyword : LibC::Char*, display_locale : LibC::Char*, dest : UChar*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_language = uloc_getDisplayLanguage_52(locale : LibC::Char*, display_locale : LibC::Char*, language : UChar*, language_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_name = uloc_getDisplayName_52(locale_id : LibC::Char*, in_locale_id : LibC::Char*, result : UChar*, max_result_size : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_display_script = uloc_getDisplayScript_52(locale : LibC::Char*, display_locale : LibC::Char*, script : UChar*, script_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_variant = uloc_getDisplayVariant_52(locale : LibC::Char*, display_locale : LibC::Char*, variant : UChar*, variant_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_is_o3country = uloc_getISO3Country_52(locale_id : LibC::Char*) : LibC::Char*
  fun uloc_get_is_o3language = uloc_getISO3Language_52(locale_id : LibC::Char*) : LibC::Char*
  fun uloc_get_iso_countries = uloc_getISOCountries_52 : LibC::Char**
  fun uloc_get_iso_languages = uloc_getISOLanguages_52 : LibC::Char**
  fun uloc_get_keyword_value = uloc_getKeywordValue_52(locale_id : LibC::Char*, keyword_name : LibC::Char*, buffer : LibC::Char*, buffer_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_language = uloc_getLanguage_52(locale_id : LibC::Char*, language : LibC::Char*, language_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_lcid = uloc_getLCID_52(locale_id : LibC::Char*) : Uint32T
  fun uloc_get_line_orientation = uloc_getLineOrientation_52(locale_id : LibC::Char*, status : UErrorCode*) : ULayoutType
  fun uloc_get_locale_for_lcid = uloc_getLocaleForLCID_52(host_id : Uint32T, locale : LibC::Char*, locale_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_name = uloc_getName_52(locale_id : LibC::Char*, name : LibC::Char*, name_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_parent = uloc_getParent_52(locale_id : LibC::Char*, parent : LibC::Char*, parent_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_script = uloc_getScript_52(locale_id : LibC::Char*, script : LibC::Char*, script_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_variant = uloc_getVariant_52(locale_id : LibC::Char*, variant : LibC::Char*, variant_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_minimize_subtags = uloc_minimizeSubtags_52(locale_id : LibC::Char*, minimized_locale_id : LibC::Char*, minimized_locale_id_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_open_keywords = uloc_openKeywords_52(locale_id : LibC::Char*, status : UErrorCode*) : UEnumeration
  fun uloc_set_default = uloc_setDefault_52(locale_id : LibC::Char*, status : UErrorCode*)
  fun uloc_set_keyword_value = uloc_setKeywordValue_52(keyword_name : LibC::Char*, keyword_value : LibC::Char*, buffer : LibC::Char*, buffer_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_to_language_tag = uloc_toLanguageTag_52(locale_id : LibC::Char*, langtag : LibC::Char*, langtag_capacity : Int32T, strict : UBool, err : UErrorCode*) : Int32T
  fun ulocdata_close = ulocdata_close_52(uld : ULocaleData)
  fun ulocdata_get_cldr_version = ulocdata_getCLDRVersion_52(version_array : UVersionInfo, status : UErrorCode*)
  fun ulocdata_get_delimiter = ulocdata_getDelimiter_52(uld : ULocaleData, type : ULocaleDataDelimiterType, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ulocdata_get_exemplar_set = ulocdata_getExemplarSet_52(uld : ULocaleData, fill_in : USet, options : Uint32T, extype : ULocaleDataExemplarSetType, status : UErrorCode*) : USet
  fun ulocdata_get_locale_display_pattern = ulocdata_getLocaleDisplayPattern_52(uld : ULocaleData, pattern : UChar*, pattern_capacity : Int32T, status : UErrorCode*) : Int32T
  fun ulocdata_get_locale_separator = ulocdata_getLocaleSeparator_52(uld : ULocaleData, separator : UChar*, separator_capacity : Int32T, status : UErrorCode*) : Int32T
  fun ulocdata_get_measurement_system = ulocdata_getMeasurementSystem_52(locale_id : LibC::Char*, status : UErrorCode*) : UMeasurementSystem
  fun ulocdata_get_no_substitute = ulocdata_getNoSubstitute_52(uld : ULocaleData) : UBool
  fun ulocdata_get_paper_size = ulocdata_getPaperSize_52(locale_id : LibC::Char*, height : Int32T*, width : Int32T*, status : UErrorCode*)
  fun ulocdata_open = ulocdata_open_52(locale_id : LibC::Char*, status : UErrorCode*) : ULocaleData
  fun ulocdata_set_no_substitute = ulocdata_setNoSubstitute_52(uld : ULocaleData, setting : UBool)
  type ULocaleData = Void*
end
