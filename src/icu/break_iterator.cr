# Text Boundary Analysis (Break Iteration)
#
# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/ubrk_8h.html)
# - [user guide](http://userguide.icu-project.org/boundaryanalysis)
class ICU::BreakIterator
  include Enumerable(String)

  alias Type = LibICU::UBreakIteratorType

  DONE = -1

  @ubrk : LibICU::UBreakIterator
  @text : UChars?
  getter :text

  LOCALES = begin
    locales = (0...LibICU.ubrk_count_available).map do |i|
      String.new(LibICU.ubrk_get_available i)
    end
    Set(String).new(locales)
  end

  def initialize(break_type : Type, locale : String? = nil)
    if locale
      raise ICU::Error.new("unknown locale #{locale}") unless LOCALES.includes?(locale)
    end

    ustatus = LibICU::UErrorCode::UZeroError
    @ubrk = LibICU.ubrk_open(break_type, locale, nil, 0, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def initialize(text : String, break_type : Type, locale : String? = nil)
    initialize(break_type, locale)
    self.text = text
  end

  def finalize
    @ubrk.try { |ubrk| LibICU.ubrk_close(ubrk) }
  end

  def to_unsafe
    @ubrk
  end

  def text=(text : UChars)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.ubrk_set_text(@ubrk, text, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    @text = text
    self
  end

  def text=(text : String)
    self.text = text.to_uchars
  end

  def each_bound
    i = LibICU.ubrk_first(@ubrk)
    while i != DONE
      yield i
      i = LibICU.ubrk_next(@ubrk)
    end
    self
  end

  def each
    unless (text = @text).nil?
      # FIXME: not thread-safe since the text can be changed using text=
      low = LibICU.ubrk_first(@ubrk)
      while (high = LibICU.ubrk_next(@ubrk)) != DONE
        s = String.build { |io| (low...high).each { |i| io << text[i].chr } }
        yield(s)
        low = high
      end
    end
    self
  end
end
