# __Text Boundary Analysis__ (Break Iteration)

# This class defines methods for finding the location
# of -line, sentense and word- boundaries in text.
#
# __Usage__
# ```
# str = "หน้าแรก"
# bi = ICU::BreakIterator.new(str, ICU::BreakIterator::Type::Word)
# bi.each { |s| p s }
# # => "หน้า"
# # => "แรก"
# bi.to_a # => ["หน้า", "แรก"]
# ```
#
# __See also__
# - [reference implementation](http://icu-project.org/apiref/icu4c/ubrk_8h.html)
# - [user guide](http://userguide.icu-project.org/boundaryanalysis)
# - [unit tests](https://github.com/olbat/icu.cr/blob/master/spec/break_iterator_spec.cr)
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

  # Create a new BreakIterator
  #
  # ```
  # bi = ICU::BreakIterator.new(ICU::BreakIterator::Type::Word)
  # bi.text = "abc def ghi"
  # bi.to_a # => ["abc", " ", "def", " ", "ghi"]
  # ```
  def initialize(break_type : Type, locale : String? = nil)
    if locale
      raise ICU::Error.new("unknown locale #{locale}") unless LOCALES.includes?(locale)
    end

    ustatus = LibICU::UErrorCode::UZeroError
    @ubrk = LibICU.ubrk_open(break_type, locale, nil, 0, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  # Creates a new BreakIterator specifying some text
  #
  # ```
  # str = "Some text. More text."
  # bi = ICU::BreakIterator.new(str, ICU::BreakIterator::Type::Sentence)
  # bi.to_a # => ["Some text. ", "More text."]
  # ```
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

  # :nodoc:
  def text=(text : UChars)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.ubrk_set_text(@ubrk, text, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    @text = text
    self
  end

  # Change the text that's being iterated on
  def text=(text : String)
    self.text = text.to_uchars
  end

  # Iterate on text boundaries indices
  #
  # ```
  # str = "abc def"
  # bi = ICU::BreakIterator.new(str, ICU::BreakIterator::Type::Word)
  # bi.each_bound { |i| p i }
  # # => 0
  # # => 3
  # # => 4
  # # => 7
  # ```
  def each_bound
    i = LibICU.ubrk_first(@ubrk)
    while i != DONE
      yield i
      i = LibICU.ubrk_next(@ubrk)
    end
    self
  end

  # Iterate on text boundaries
  #
  # ```
  # str = "abc def ghi"
  # bi = ICU::BreakIterator.new(str, ICU::BreakIterator::Type::Word)
  # bi.to_a # => ["abc", " ", "def", " ", "ghi"]
  # bi.each { |s| p s }
  # # => "abc"
  # # => " "
  # # => "def"
  # # => " "
  # # => "ghi"
  # ```
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
