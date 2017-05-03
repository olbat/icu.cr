class ICU::Region
  alias Type = LibICU::URegionType

  @uregion : LibICU::URegion
  @code : String?
  @numeric_code : Int32?
  @type : Type?
  @@regions = {} of Type => Array(String)

  def self.regions(type : Type = Type::UrgnWorld)
    ustatus = uninitialized LibICU::UErrorCode
    uenum = LibICU.uregion_get_available(type, pointerof(ustatus))
    ICU.check_error!(ustatus)
    regions = UEnum.new(uenum).to_a
    LibICU.uenum_close(uenum)
    @@regions[type] ||= regions
  end

  def initialize(code : String)
    ustatus = uninitialized LibICU::UErrorCode
    @uregion = LibICU.uregion_get_region_from_code(code, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def initialize(code : Int32)
    ustatus = uninitialized LibICU::UErrorCode
    @uregion = LibICU.uregion_get_region_from_numeric_code(code, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def initialize(@uregion : LibICU::URegion)
  end

  def code : String
    @code ||= String.new(LibICU.uregion_get_region_code(@uregion))
  end

  def numeric_code : Int32
    @numeric_code ||= LibICU.uregion_get_numeric_code(@uregion)
  end

  def type : Type
    @type ||= LibICU.uregion_get_type(@uregion).as(Type)
  end

  def ==(other : typeof(self))
    LibICU.uregion_are_equal(@uregion, other.@uregion) != 0
  end

  def contains?(other : typeof(self))
    LibICU.uregion_contains(@uregion, other.@uregion) != 0
  end

  def containing_region : Region
    self.class.new(LibICU.uregion_get_containing_region(@uregion))
  end

  def contained_regions : Array(Region)
    ustatus = uninitialized LibICU::UErrorCode
    uenum = LibICU.uregion_get_contained_regions(@uregion, pointerof(ustatus))
    ICU.check_error!(ustatus)
    regions = UEnum.new(uenum).to_a
    LibICU.uenum_close(uenum)
    regions.map { |r| self.class.new(r) }
  end
end
