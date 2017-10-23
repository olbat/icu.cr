# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/uenum_8h.html)
class ICU::UEnum
  include Enumerable(String)

  @free = true

  def initialize(@uenum : LibICU::UEnumeration)
    @free = false
  end

  # FIXME: not thread-safe
  def initialize(elements : Array(String))
    ustatus = LibICU::UErrorCode::UZeroError
    @uenum = LibICU.uenum_open_char_strings_enumeration(elements.map(&.to_unsafe), elements.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def finalize
    LibICU.uenum_close(@uenum) if @free
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
