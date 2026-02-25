# String Enumeration
#
# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/uenum_8h.html)
class ICU::UEnum
  include Enumerable(String)

  # Wraps an existing `UEnumeration` handle.
  #
  # Pass `owns: true` to transfer ownership so that the handle is closed when
  # this object is finalized. The default (`owns: false`) leaves lifetime
  # management to the caller.
  def initialize(@uenum : LibICU::UEnumeration, *, owns : Bool = false)
    @free = owns
  end

  # FIXME: not thread-safe
  def initialize(elements : Array(String))
    ustatus = LibICU::UErrorCode::UZeroError
    @uenum = LibICU.uenum_open_char_strings_enumeration(elements.map(&.to_unsafe), elements.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    @free = true
  end

  def finalize
    LibICU.uenum_close(@uenum) if @free
  end

  def each
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.uenum_reset(@uenum, pointerof(ustatus))
    ICU.check_error!(ustatus)

    loop do
      ustatus = LibICU::UErrorCode::UZeroError
      item = LibICU.uenum_next(@uenum, out size, pointerof(ustatus))
      ICU.check_error!(ustatus)

      break unless item

      yield String.new(item, size)
    end
  end
end
