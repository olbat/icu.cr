@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
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
  fun uloc_accept_language = uloc_acceptLanguage{{SYMS_SUFFIX.id}}(result : LibC::Char*, result_available : Int32T, out_result : UAcceptResult*, accept_list : LibC::Char**, accept_list_count : Int32T, available_locales : UEnumeration, status : UErrorCode*) : Int32T
  fun uloc_accept_language_from_http = uloc_acceptLanguageFromHTTP{{SYMS_SUFFIX.id}}(result : LibC::Char*, result_available : Int32T, out_result : UAcceptResult*, http_accept_language : LibC::Char*, available_locales : UEnumeration, status : UErrorCode*) : Int32T
  fun uloc_add_likely_subtags = uloc_addLikelySubtags{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, maximized_locale_id : LibC::Char*, maximized_locale_id_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_canonicalize = uloc_canonicalize{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, name : LibC::Char*, name_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_count_available = uloc_countAvailable{{SYMS_SUFFIX.id}} : Int32T
  fun uloc_for_language_tag = uloc_forLanguageTag{{SYMS_SUFFIX.id}}(langtag : LibC::Char*, locale_id : LibC::Char*, locale_id_capacity : Int32T, parsed_length : Int32T*, err : UErrorCode*) : Int32T
  fun uloc_get_available = uloc_getAvailable{{SYMS_SUFFIX.id}}(n : Int32T) : LibC::Char*
  fun uloc_get_base_name = uloc_getBaseName{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, name : LibC::Char*, name_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_character_orientation = uloc_getCharacterOrientation{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, status : UErrorCode*) : ULayoutType
  fun uloc_get_country = uloc_getCountry{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, country : LibC::Char*, country_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_default = uloc_getDefault{{SYMS_SUFFIX.id}} : LibC::Char*
  fun uloc_get_display_country = uloc_getDisplayCountry{{SYMS_SUFFIX.id}}(locale : LibC::Char*, display_locale : LibC::Char*, country : UChar*, country_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_keyword = uloc_getDisplayKeyword{{SYMS_SUFFIX.id}}(keyword : LibC::Char*, display_locale : LibC::Char*, dest : UChar*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_keyword_value = uloc_getDisplayKeywordValue{{SYMS_SUFFIX.id}}(locale : LibC::Char*, keyword : LibC::Char*, display_locale : LibC::Char*, dest : UChar*, dest_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_language = uloc_getDisplayLanguage{{SYMS_SUFFIX.id}}(locale : LibC::Char*, display_locale : LibC::Char*, language : UChar*, language_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_name = uloc_getDisplayName{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, in_locale_id : LibC::Char*, result : UChar*, max_result_size : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_display_script = uloc_getDisplayScript{{SYMS_SUFFIX.id}}(locale : LibC::Char*, display_locale : LibC::Char*, script : UChar*, script_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_display_variant = uloc_getDisplayVariant{{SYMS_SUFFIX.id}}(locale : LibC::Char*, display_locale : LibC::Char*, variant : UChar*, variant_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_is_o3country = uloc_getISO3Country{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*) : LibC::Char*
  fun uloc_get_is_o3language = uloc_getISO3Language{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*) : LibC::Char*
  fun uloc_get_iso_countries = uloc_getISOCountries{{SYMS_SUFFIX.id}} : LibC::Char**
  fun uloc_get_iso_languages = uloc_getISOLanguages{{SYMS_SUFFIX.id}} : LibC::Char**
  fun uloc_get_keyword_value = uloc_getKeywordValue{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, keyword_name : LibC::Char*, buffer : LibC::Char*, buffer_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_language = uloc_getLanguage{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, language : LibC::Char*, language_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_lcid = uloc_getLCID{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*) : Uint32T
  fun uloc_get_line_orientation = uloc_getLineOrientation{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, status : UErrorCode*) : ULayoutType
  fun uloc_get_locale_for_lcid = uloc_getLocaleForLCID{{SYMS_SUFFIX.id}}(host_id : Uint32T, locale : LibC::Char*, locale_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_get_name = uloc_getName{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, name : LibC::Char*, name_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_parent = uloc_getParent{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, parent : LibC::Char*, parent_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_script = uloc_getScript{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, script : LibC::Char*, script_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_get_variant = uloc_getVariant{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, variant : LibC::Char*, variant_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_minimize_subtags = uloc_minimizeSubtags{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, minimized_locale_id : LibC::Char*, minimized_locale_id_capacity : Int32T, err : UErrorCode*) : Int32T
  fun uloc_open_keywords = uloc_openKeywords{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, status : UErrorCode*) : UEnumeration
  fun uloc_set_default = uloc_setDefault{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, status : UErrorCode*)
  fun uloc_set_keyword_value = uloc_setKeywordValue{{SYMS_SUFFIX.id}}(keyword_name : LibC::Char*, keyword_value : LibC::Char*, buffer : LibC::Char*, buffer_capacity : Int32T, status : UErrorCode*) : Int32T
  fun uloc_to_language_tag = uloc_toLanguageTag{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, langtag : LibC::Char*, langtag_capacity : Int32T, strict : UBool, err : UErrorCode*) : Int32T
  fun ulocdata_close = ulocdata_close{{SYMS_SUFFIX.id}}(uld : ULocaleData)
  fun ulocdata_get_cldr_version = ulocdata_getCLDRVersion{{SYMS_SUFFIX.id}}(version_array : UVersionInfo, status : UErrorCode*)
  fun ulocdata_get_delimiter = ulocdata_getDelimiter{{SYMS_SUFFIX.id}}(uld : ULocaleData, type : ULocaleDataDelimiterType, result : UChar*, result_length : Int32T, status : UErrorCode*) : Int32T
  fun ulocdata_get_exemplar_set = ulocdata_getExemplarSet{{SYMS_SUFFIX.id}}(uld : ULocaleData, fill_in : USet, options : Uint32T, extype : ULocaleDataExemplarSetType, status : UErrorCode*) : USet
  fun ulocdata_get_locale_display_pattern = ulocdata_getLocaleDisplayPattern{{SYMS_SUFFIX.id}}(uld : ULocaleData, pattern : UChar*, pattern_capacity : Int32T, status : UErrorCode*) : Int32T
  fun ulocdata_get_locale_separator = ulocdata_getLocaleSeparator{{SYMS_SUFFIX.id}}(uld : ULocaleData, separator : UChar*, separator_capacity : Int32T, status : UErrorCode*) : Int32T
  fun ulocdata_get_measurement_system = ulocdata_getMeasurementSystem{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, status : UErrorCode*) : UMeasurementSystem
  fun ulocdata_get_no_substitute = ulocdata_getNoSubstitute{{SYMS_SUFFIX.id}}(uld : ULocaleData) : UBool
  fun ulocdata_get_paper_size = ulocdata_getPaperSize{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, height : Int32T*, width : Int32T*, status : UErrorCode*)
  fun ulocdata_open = ulocdata_open{{SYMS_SUFFIX.id}}(locale_id : LibC::Char*, status : UErrorCode*) : ULocaleData
  fun ulocdata_set_no_substitute = ulocdata_setNoSubstitute{{SYMS_SUFFIX.id}}(uld : ULocaleData, setting : UBool)
  type ULocaleData = Void*
  {% end %}
end
