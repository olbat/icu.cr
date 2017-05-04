@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum URegionType
    UrgnUnknown      = 0
    UrgnTerritory    = 1
    UrgnWorld        = 2
    UrgnContinent    = 3
    UrgnSubcontinent = 4
    UrgnGrouping     = 5
    UrgnDeprecated   = 6
    UrgnLimit        = 7
  end
  fun uregion_are_equal = uregion_areEqual{{SYMS_SUFFIX.id}}(uregion : URegion, other_region : URegion) : UBool
  fun uregion_contains = uregion_contains{{SYMS_SUFFIX.id}}(uregion : URegion, other_region : URegion) : UBool
  fun uregion_get_available = uregion_getAvailable{{SYMS_SUFFIX.id}}(type : URegionType, status : UErrorCode*) : UEnumeration
  fun uregion_get_contained_regions = uregion_getContainedRegions{{SYMS_SUFFIX.id}}(uregion : URegion, status : UErrorCode*) : UEnumeration
  fun uregion_get_contained_regions_of_type = uregion_getContainedRegionsOfType{{SYMS_SUFFIX.id}}(uregion : URegion, type : URegionType, status : UErrorCode*) : UEnumeration
  fun uregion_get_containing_region = uregion_getContainingRegion{{SYMS_SUFFIX.id}}(uregion : URegion) : URegion
  fun uregion_get_containing_region_of_type = uregion_getContainingRegionOfType{{SYMS_SUFFIX.id}}(uregion : URegion, type : URegionType) : URegion
  fun uregion_get_numeric_code = uregion_getNumericCode{{SYMS_SUFFIX.id}}(uregion : URegion) : Int32T
  fun uregion_get_preferred_values = uregion_getPreferredValues{{SYMS_SUFFIX.id}}(uregion : URegion, status : UErrorCode*) : UEnumeration
  fun uregion_get_region_code = uregion_getRegionCode{{SYMS_SUFFIX.id}}(uregion : URegion) : LibC::Char*
  fun uregion_get_region_from_code = uregion_getRegionFromCode{{SYMS_SUFFIX.id}}(region_code : LibC::Char*, status : UErrorCode*) : URegion
  fun uregion_get_region_from_numeric_code = uregion_getRegionFromNumericCode{{SYMS_SUFFIX.id}}(code : Int32T, status : UErrorCode*) : URegion
  fun uregion_get_type = uregion_getType{{SYMS_SUFFIX.id}}(uregion : URegion) : URegionType
  type URegion = Void*
  {% end %}
end
