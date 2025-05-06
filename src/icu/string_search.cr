# __String Searching__
#
# Provides language-sensitive text searching.
#
# __Usage__
# ```
# col = ICU::Collator.new("de_DE")
# col.strength = ICU::Collator::Strength::Primary
# search = ICU::StringSearch.new("ß", "...SS...", col)
# search.next # => 3...5
# ```
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/collation/string-search.html)
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/usearch_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/string_search_spec.cr)
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

  # Creates a search iterator specifying a locale language rule set
  #
  # See also: `#break_iterator=`
  def initialize(pattern : String, @text : String, locale : String = "", break_iterator : BreakIterator? = nil)
    pattern = pattern.to_uchars
    text = text.to_uchars

    ustatus = LibICU::UErrorCode::UZeroError
    @uss = LibICU.usearch_open(pattern, pattern.size, text, text.size, locale, break_iterator, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  # Creates a search iterator specifying a collator language rule set
  #
  # See also: `#collator=`, `#break_iterator=`
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
  #
  # ```
  # search = ICU::StringSearch.new("bb", "abbbc")
  # search[ICU::StringSearch::Attribute::Overlap] = ICU::StringSearch::OFF
  # search.to_a # => [(1...3)]
  # search.rewind
  # search[ICU::StringSearch::Attribute::Overlap] = ICU::StringSearch::ON
  # search.to_a # => [(1...3), (2...4)]
  # ```
  def []=(attribute : Attribute, value : AttributeValue)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.usearch_set_attribute(@uss, attribute, value, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  # Returns the value of the search pattern
  def pattern : String
    size = 0
    ret = LibICU.usearch_get_pattern(@uss, pointerof(size))
    UChars.new(ret, size).to_s
  end

  # Sets the pattern used for matching
  def pattern=(pattern : String)
    ustatus = LibICU::UErrorCode::UZeroError
    pattern = pattern.to_uchars
    LibICU.usearch_set_pattern(@uss, pattern, pattern.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  # Return the text to be searched
  def text : String
    size = 0
    ret = LibICU.usearch_get_text(@uss, pointerof(size))
    UChars.new(ret, size).to_s
  end

  # Set the string text to be searched
  def text=(text : String)
    ustatus = LibICU::UErrorCode::UZeroError
    text = text.to_uchars
    LibICU.usearch_set_text(@uss, text, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  # Returns the last index in the text at which it matches the search pattern
  def offset : Int32
    LibICU.usearch_get_offset(@uss)
  end

  # Sets the current position in the text string which the next search will start from
  #
  # ```
  # search = ICU::StringSearch.new("abc", "...abc...abc...")
  # search.offset = 6
  # search.next # => 9...12
  # ```
  def offset=(offset : Int32)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.usearch_set_offset(@uss, offset, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  # Sets the collator used for the language rules
  #
  # ```
  # search = ICU::StringSearch.new("aa", "ab")
  # search.collator = ICU::Collator.new("&b = a".to_uchars)
  # search.next # => 0...2
  # ```
  def collator=(collator : Collator)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.usearch_set_collator(@uss, collator, pointerof(ustatus))
    ICU.check_error!(ustatus)
    @collator = collator
    self
  end

  # Set the BreakIterator that will be used to restrict the points at which
  # matches are detected
  #
  # ```
  # search = ICU::StringSearch.new("ab", "... abc ...")
  # search.break_iterator = ICU::BreakIterator.new(ICU::BreakIterator::Type::Word)
  # search.next # => Iterator::Stop::INSTANCE
  # search.pattern = "abc"
  # search.reset
  # search.next # => 4...6
  # ```
  def break_iterator=(break_iterator : BreakIterator)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.usearch_set_break_iterator(@uss, break_iterator, pointerof(ustatus))
    ICU.check_error!(ustatus)
    @break_iterator = break_iterator
    self
  end

  # Returns the index of the next point at which the string text matches the
  # search pattern, starting from the current position.
  #
  # ```
  # search = ICU::StringSearch.new("abc", "...abc...abc...")
  # search.next # => 3...6
  # search.next # => 9...12
  # ```
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

  # Returns the index of the previous point at which the string text matches
  # the search pattern, starting at the current position.
  #
  # ```
  # search = ICU::StringSearch.new("abc", "...abc...abc...")
  # search.offset = 14
  # search.previous # => 9...12
  # search.previous # => 3...6
  # ```
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

  # Resets the position of the cursor
  #
  # ```
  # search = ICU::StringSearch.new("abc", "...abc...abc...")
  # search.next # => 3...6
  # search.reset
  # search.next # => 3...6
  # ```
  def reset
    LibICU.usearch_reset(@uss)
    self
  end

  def rewind
    self.offset = 0
    self
  end

  # Returns the first index at which the string text matches the search pattern
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

  # Returns the last index in the target text at which it matches
  # the search pattern
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

  # Returns the first index less than _position_ at which
  # the string text matches the search pattern
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

  # Returns the first index greater or equal than _position_ at which
  # the string text matches the search pattern
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
