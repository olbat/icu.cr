# not thread-safe
class ICU::UEnum
  include Enumerable(String)

  @free = true

  def initialize(@uenum : LibICU::UEnumeration)
    @free = false
  end

  def initialize(elements : Array(String))
    @uenum = LibICU.uenum_open_char_strings_enumeration(elements.map(&.to_unsafe), elements.size, out ustatus)
    ICU.check_error!(ustatus)
  end

  def finalize
    LibICU.uenum_close(@uenum) if @free
  end

  def each
    ustatus = uninitialized LibICU::UErrorCode

    LibICU.uenum_reset(@uenum, pointerof(ustatus))
    ICU.check_error!(ustatus)

    count = LibICU.uenum_count(@uenum, pointerof(ustatus))
    ICU.check_error!(ustatus)

    count.times do
      elem = LibICU.uenum_next(@uenum, out size, pointerof(ustatus))
      ICU.check_error!(ustatus)
      yield String.new(elem, size)
    end
  end
end
