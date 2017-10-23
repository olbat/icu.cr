# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/usearch_8h.html)
# - [user guide](http://userguide.icu-project.org/collation/icu-string-search-service)
class ICU::StringSearch
  alias Position = Range(Int32, Int32)
  alias Attribute = LibICU::USearchAttribute
  alias AttributeValue = LibICU::USearchAttributeValue

  include Iterator(Position)

  ON      = AttributeValue::On
  OFF     = AttributeValue::Off
  DEFAULT = AttributeValue::Default
  DONE    = -1

  @uss : LibICU::UStringSearch
  @text : String
  @collator : Collator?
  @break_iterator : BreakIterator?
  getter :collator, :break_iterator

  def initialize(pattern : String, @text : String, locale : String = Locale::DEFAULT_LOCALE, break_iterator : BreakIterator? = nil)
    pattern = pattern.to_uchars
    text = text.to_uchars

    ustatus = LibICU::UErrorCode::UZeroError
    @uss = LibICU.usearch_open(pattern, pattern.size, text, text.size, locale, break_iterator, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def initialize(pattern : String, @text : String, @collator : Collator, @break_iterator : BreakIterator? = nil)
    pattern = pattern.to_uchars
    text = text.to_uchars

    ustatus = LibICU::UErrorCode::UZeroError
    @uss = LibICU.usearch_open_from_collator(pattern, pattern.size, text, text.size, collator, break_iterator, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  # Get the value of the specified attribute
  def [](attribute : Attribute) : AttributeValue
    LibICU.usearch_get_attribute(@uss, attribute)
  end

  # Set a value to the specified attribute
  def []=(attribute : Attribute, value : AttributeValue)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.usearch_set_attribute(@uss, attribute, value, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  def pattern : String
    size = 0
    ret = LibICU.usearch_get_pattern(@uss, pointerof(size))
    UChars.new(ret, size).to_s
  end

  def pattern=(pattern : String)
    ustatus = LibICU::UErrorCode::UZeroError
    pattern = pattern.to_uchars
    LibICU.usearch_set_pattern(@uss, pattern, pattern.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  def text : String
    size = 0
    ret = LibICU.usearch_get_text(@uss, pointerof(size))
    UChars.new(ret, size).to_s
  end

  def text=(text : String)
    ustatus = LibICU::UErrorCode::UZeroError
    text = text.to_uchars
    LibICU.usearch_set_text(@uss, text, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  def offset : Int32
    LibICU.usearch_get_offset(@uss)
  end

  def offset=(offset : Int32)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.usearch_set_offset(@uss, offset, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  def collator=(collator : Collator)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.usearch_set_collator(@uss, collator, pointerof(ustatus))
    ICU.check_error!(ustatus)
    @collator = collator
    self
  end

  def break_iterator=(break_iterator : BreakIterator)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.usearch_set_break_iterator(@uss, break_iterator, pointerof(ustatus))
    ICU.check_error!(ustatus)
    @break_iterator = break_iterator
    self
  end

  def next
    ustatus = LibICU::UErrorCode::UZeroError
    offset = LibICU.usearch_next(@uss, pointerof(ustatus))
    ICU.check_error!(ustatus)

    if offset == DONE
      stop
    else
      (offset...offset + self.matched_length)
    end
  end

  def previous
    ustatus = LibICU::UErrorCode::UZeroError
    offset = LibICU.usearch_previous(@uss, pointerof(ustatus))
    ICU.check_error!(ustatus)

    if offset == DONE
      stop
    else
      (offset...offset + self.matched_length)
    end
  end

  def reset
    LibICU.usearch_reset(@uss)
    self
  end

  def rewind
    self.offset = 0
    self
  end

  def first : Position?
    ustatus = LibICU::UErrorCode::UZeroError
    offset = LibICU.usearch_first(@uss, pointerof(ustatus))
    ICU.check_error!(ustatus)

    if offset == DONE
      nil
    else
      (offset...offset + self.matched_length)
    end
  end

  def last : Position?
    ustatus = LibICU::UErrorCode::UZeroError
    offset = LibICU.usearch_last(@uss, pointerof(ustatus))
    ICU.check_error!(ustatus)

    if offset == DONE
      nil
    else
      (offset...offset + self.matched_length)
    end
  end

  def preceding(position : Int) : Position?
    ustatus = LibICU::UErrorCode::UZeroError
    offset = LibICU.usearch_preceding(@uss, position, pointerof(ustatus))
    ICU.check_error!(ustatus)

    if offset == DONE
      nil
    else
      (offset...offset + self.matched_length)
    end
  end

  def following(position : Int) : Position?
    ustatus = LibICU::UErrorCode::UZeroError
    offset = LibICU.usearch_following(@uss, position, pointerof(ustatus))
    ICU.check_error!(ustatus)

    if offset == DONE
      nil
    else
      (offset...offset + self.matched_length)
    end
  end

  # FIXME: useless ?
  #
  # def search(offset : Int = 0) : Position?
  #   match_start = match_end = 0

  #   ustatus = LibICU::UErrorCode::UZeroError
  #   LibICU.usearch_search(@uss, offset, pointerof(match_start), pointerof(match_end), pointerof(ustatus))
  #   ICU.check_error!(ustatus)

  #   if match_start
  #     (match_start...match_end)
  #   else
  #     nil
  #   end
  # end
  #
  # def search_backwards(offset : Int = 0) : Position?
  #   match_start = match_end = 0

  #   ustatus = LibICU::UErrorCode::UZeroError
  #   LibICU.usearch_search_backwards(@uss, offset, pointerof(match_start), pointerof(match_end), pointerof(ustatus))
  #   ICU.check_error!(ustatus)

  #   if match_start
  #     (match_start...match_end)
  #   else
  #     nil
  #   end
  # end

  protected def matched_length : Int32
    LibICU.usearch_get_matched_length(@uss)
  end
end
