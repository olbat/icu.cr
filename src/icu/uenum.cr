# not thread-safe
class ICU::UEnum
  include Enumerable(String)

  def initialize(@uenum : LibICU::UEnumeration)
    @finalized = true
  end

  def initialize(elements : Array(String))
    @finalized = false
    ustatus = LibICU::UErrorCode::UZeroError
    @uenum = LibICU.uenum_open_char_strings_enumeration(elements.map(&.to_unsafe), elements.size, pointerof(ustatus))
    ICU.check_error!(ustatus) { free }
  end

  def finalize
    free
  end

  def free
    unless @finalized
      @finalized = true
      LibICU.uenum_close(@uenum)
    end
  end

  def each
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.uenum_reset(@uenum, pointerof(ustatus))
    ICU.check_error!(ustatus)

    ustatus = LibICU::UErrorCode::UZeroError
    count = LibICU.uenum_count(@uenum, pointerof(ustatus))
    ICU.check_error!(ustatus)

    count.times do
      ustatus = LibICU::UErrorCode::UZeroError
      elem = LibICU.uenum_next(@uenum, out size, pointerof(ustatus))
      ICU.check_error!(ustatus)
      yield String.new(elem, size)
    end
  end
end
