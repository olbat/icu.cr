class ICU::BreakIterator
  include Enumerable(String)

  alias Type = LibICU::UBreakIteratorType

  DONE = -1

  @ubrk : LibICU::UBreakIterator
  @uchars : UChars

  LOCALES = begin
    locales = (0...LibICU.ubrk_count_available).map do |i|
      String.new(LibICU.ubrk_get_available i)
    end
    Set(String).new(locales)
  end

  def initialize(@text : String, break_type : Type, locale : String? = nil)
    if locale
      raise ICU::Error.new("unknown locale #{locale}") unless LOCALES.includes?(locale)
    end

    ustatus = LibICU::UErrorCode::UZeroError
    @ubrk = LibICU.ubrk_open(break_type, locale, nil, 0, pointerof(ustatus))
    ICU.check_error!(ustatus)

    @uchars = @text.to_uchars

    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.ubrk_set_text(@ubrk, @uchars, @uchars.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def finalize
    @ubrk.try { |ubrk| LibICU.ubrk_close(ubrk) }
  end

  def to_unsafe
    @ubrk
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
    low = LibICU.ubrk_first(@ubrk)
    while (high = LibICU.ubrk_next(@ubrk)) != DONE
      s = String.build { |io| (low...high).each { |i| io << @uchars[i].chr } }
      yield(s)
      low = high
    end
    self
  end
end
