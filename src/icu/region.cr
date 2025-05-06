{% if compare_versions(LibICU::VERSION, "52.0.0") >= 0 %}
  # Territory containment and mapping
  #
  # See also:
  # - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/uregion_8h.html)
  # - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/region_spec.cr)
  class ICU::Region
    @uregion : LibICU::URegion
    @code : String?
    @numeric_code : Int32?

    def initialize(code : String)
      ustatus = LibICU::UErrorCode::UZeroError
      @uregion = LibICU.uregion_get_region_from_code(code, pointerof(ustatus))
      ICU.check_error!(ustatus)
    end

    def initialize(code : Int32)
      ustatus = LibICU::UErrorCode::UZeroError
      @uregion = LibICU.uregion_get_region_from_numeric_code(code, pointerof(ustatus))
      ICU.check_error!(ustatus)
    end

    def initialize(@uregion : LibICU::URegion)
    end

    def to_unsafe
      @uregion
    end

    def code : String
      @code ||= String.new(LibICU.uregion_get_region_code(@uregion))
    end

    def numeric_code : Int32
      @numeric_code ||= LibICU.uregion_get_numeric_code(@uregion)
    end

    def ==(other : Region)
      LibICU.uregion_are_equal(@uregion, other.@uregion) != 0
    end

    def contains?(other : Region)
      LibICU.uregion_contains(@uregion, other.@uregion) != 0
    end

    def containing_region : Region
      self.class.new(LibICU.uregion_get_containing_region(@uregion))
    end

    def contained_regions : Array(Region)
      ustatus = LibICU::UErrorCode::UZeroError
      uenum = LibICU.uregion_get_contained_regions(@uregion, pointerof(ustatus))
      ICU.check_error!(ustatus)
      regions = UEnum.new(uenum).to_a
      LibICU.uenum_close(uenum)
      regions.map { |r| self.class.new(r) }
    end
  end
{% end %}
