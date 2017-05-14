class ICU::BreakIterator
  include Enumerable(String)

  DONE = -1

  @ubrk : LibICU::UBreakIterator
  @utext : LibICU::UText*

  LOCALES = begin
    locales = (0...LibICU.ubrk_count_available).map do |i|
      String.new(LibICU.ubrk_get_available i)
    end
    Set(String).new(locales)
  end

  def initialize(@text : String, break_type : LibICU::UBreakIteratorType, locale : String? = nil)
    @finalized = false

    if locale
      raise ICU::Error.new("unknown locale #{locale}") unless LOCALES.includes?(locale)
    end

    ustatus = LibICU::UErrorCode::UZeroError
    @ubrk = LibICU.ubrk_open(break_type, locale, nil, 0, pointerof(ustatus))
    ICU.check_error!(ustatus) { free }

    ustatus = LibICU::UErrorCode::UZeroError
    @utext = LibICU.utext_open_ut_f8(nil, @text.to_unsafe, @text.bytesize, pointerof(ustatus))
    ICU.check_error!(ustatus) { free }

    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.ubrk_set_u_text(@ubrk, @utext, pointerof(ustatus))
    ICU.check_error!(ustatus) { free }
  end

  def free
    unless @finalized
      @finalized = true
      LibICU.ubrk_close(@ubrk) unless @ubrk.null?
      LibICU.utext_close(@utext) unless @utext.null?
    end
  end

  def finalize
    free
  end

  def each_bound
    i = LibICU.ubrk_first(@ubrk)
    while i != DONE
      yield i
      i = LibICU.ubrk_next(@ubrk)
    end
    self
  end

  def each_slice
    unsafe_text = @text.to_unsafe
    low = LibICU.ubrk_first(@ubrk)
    while (high = LibICU.ubrk_next(@ubrk)) != DONE
      yield(Bytes.new(unsafe_text + low, high - low))
      low = high
    end
    self
  end

  def each
    each_slice { |slice| yield String.new(slice) }
  end
end
