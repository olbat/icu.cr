class ICU::BreakIterator
  include Enumerable(String)

  DONE = -1

  @ubrk : LibICU::UBreakIterator
  @chars : Array(UInt16)

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

    @chars = text.chars.map { |c| c.ord.to_u16 }

    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.ubrk_set_text(@ubrk, @chars.to_unsafe, @chars.size, pointerof(ustatus))
    ICU.check_error!(ustatus) { free }
  end

  def free
    unless @finalized
      @finalized = true
      LibICU.ubrk_close(@ubrk) unless @ubrk.null?
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

  def each
    unsafe_text = @text.to_unsafe
    low = LibICU.ubrk_first(@ubrk)
    while (high = LibICU.ubrk_next(@ubrk)) != DONE
      s = String.build { |io| (low...high).each { |i| io << @chars[i].chr } }
      yield(s)
      low = high
    end
    self
  end
end
