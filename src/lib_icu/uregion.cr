@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
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
  fun uregion_are_equal = uregion_areEqual_52(uregion : URegion, other_region : URegion) : UBool
  fun uregion_contains = uregion_contains_52(uregion : URegion, other_region : URegion) : UBool
  fun uregion_get_available = uregion_getAvailable_52(type : URegionType, status : UErrorCode*) : UEnumeration
  fun uregion_get_contained_regions = uregion_getContainedRegions_52(uregion : URegion, status : UErrorCode*) : UEnumeration
  fun uregion_get_contained_regions_of_type = uregion_getContainedRegionsOfType_52(uregion : URegion, type : URegionType, status : UErrorCode*) : UEnumeration
  fun uregion_get_containing_region = uregion_getContainingRegion_52(uregion : URegion) : URegion
  fun uregion_get_containing_region_of_type = uregion_getContainingRegionOfType_52(uregion : URegion, type : URegionType) : URegion
  fun uregion_get_numeric_code = uregion_getNumericCode_52(uregion : URegion) : Int32T
  fun uregion_get_preferred_values = uregion_getPreferredValues_52(uregion : URegion, status : UErrorCode*) : UEnumeration
  fun uregion_get_region_code = uregion_getRegionCode_52(uregion : URegion) : LibC::Char*
  fun uregion_get_region_from_code = uregion_getRegionFromCode_52(region_code : LibC::Char*, status : UErrorCode*) : URegion
  fun uregion_get_region_from_numeric_code = uregion_getRegionFromNumericCode_52(code : Int32T, status : UErrorCode*) : URegion
  fun uregion_get_type = uregion_getType_52(uregion : URegion) : URegionType
  type URegion = Void*
end
