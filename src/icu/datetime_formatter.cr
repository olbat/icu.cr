# __DateTime Formatter__
#
# This class provides a facility for formatting and parsing dates and times
# according to locale-specific conventions or custom patterns.
#
# It wraps the ICU `UDateFormat` functionality.
#
# __Usage__
# ```
# # Using styles
# dtf = ICU::DateTimeFormatter.new("en_US", date_style: ICU::DateTimeFormatter::FormatStyle::Short, time_style: ICU::DateTimeFormatter::FormatStyle::Short)
# time = Time.utc(2023, 10, 27, 15, 30, 45)
# dtf.format(time) # => "10/27/23, 3:30 PM" (example, actual output depends on ICU data)
# parsed_time = dtf.parse("10/27/23, 3:30 PM") # => Time object
#
# # Using a pattern
# dtf_pattern = ICU::DateTimeFormatter.new("fr_FR", pattern: "yyyy.MM.dd 'at' HH:mm:ss zzz")
# dtf_pattern.format(time) # => "2023.10.27 at 15:30:45 UTC" (example)
# ```
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/format_parse/datetime/)
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/dev/icu4c/udat_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/datetime_formatter_spec.cr)
class ICU::DateTimeFormatter
  alias FormatStyle = LibICU::UDateFormatStyle

  @udatf : LibICU::UDateFormat*
  @ucal : LibICU::UCalendar*?

  # Creates a new DateTimeFormatter using predefined styles.
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_US", date_style: ICU::DateTimeFormatter::FormatStyle::Short, time_style: ICU::DateTimeFormatter::FormatStyle::Short)
  # dtf_fr = ICU::DateTimeFormatter.new("fr_FR", date_style: ICU::DateTimeFormatter::FormatStyle::Long, time_style: ICU::DateTimeFormatter::FormatStyle::Long, timezone: "Europe/Paris")
  # dtf_date_only = ICU::DateTimeFormatter.new("de_DE", date_style: ICU::DateTimeFormatter::FormatStyle::Medium, time_style: ICU::DateTimeFormatter::FormatStyle::None)
  # ```
  def initialize(locale : String, *, date_style : FormatStyle, time_style : FormatStyle, timezone : String? = nil)
    ustatus = LibICU::UErrorCode::UZeroError
    tz_id = timezone.try &.to_uchars
    tz_id_len = tz_id.try(&.size) || -1

    @udatf = LibICU.udat_open(
      time_style,
      date_style,
      locale,
      tz_id,
      tz_id_len,
      nil, # pattern
      -1,  # patternLength
      pointerof(ustatus)
    )

    @ucal = nil

    ICU.check_error!(ustatus)
  end

  # Creates a new DateTimeFormatter using a custom pattern.
  #
  # The pattern syntax follows the LDML specification.
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_GB", pattern: "dd MMM yyyy HH:mm:ss ZZZZ")
  # dtf_tz = ICU::DateTimeFormatter.new("ja_JP", pattern: "GGGGy年M月d日 H時m分s秒 zzzz", timezone: "Asia/Tokyo")
  # ```
  #
  # __See also__
  # - [LDML Date Field Symbol Table](https://www.unicode.org/reports/tr35/tr35-dates.html#Date_Field_Symbol_Table)
  def initialize(locale : String, *, pattern : String, timezone : String? = nil)
    ustatus = LibICU::UErrorCode::UZeroError
    tz_id = timezone.try &.to_uchars
    tz_id_len = tz_id.try(&.size) || -1
    pattern_uchars = pattern.to_uchars

    @udatf = LibICU.udat_open(
      FormatStyle::Pattern, # timeStyle = UDAT_PATTERN
      FormatStyle::Pattern, # dateStyle = UDAT_PATTERN
      locale,
      tz_id,
      tz_id_len,
      pattern_uchars,
      pattern_uchars.size,
      pointerof(ustatus)
    )

    ICU.check_error!(ustatus)
  end

  def finalize
    @udatf.try { |udatf| LibICU.udat_close(udatf) }
  end

  # Formats a `Time` object into a string according to the formatter's locale and pattern/style.
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_US", date_style: ICU::DateTimeFormatter::FormatStyle::Medium, time_style: ICU::DateTimeFormatter::FormatStyle::Short)
  # time = Time.utc(2023, 10, 27, 15, 30, 0)
  # dtf.format(time) # => "Oct 27, 2023, 3:30 PM" (example)
  # ```
  def format(datetime : Time) : String
    udate = ICU::Date.from(datetime)
    ICU.with_auto_resizing_buffer(64, UChars) do |buff, status_ptr|
      LibICU.udat_format(@udatf, udate, buff.as(UChars), buff.size, nil, status_ptr)
    end
  end

  # Formats the date/time represented by an `ICU::Calendar` object into a string.
  #
  # Note: This method might modify the calendar object if its fields are not fully calculated,
  # but it won't change the logical date and time held by the calendar.
  #
  # ```
  # cal = ICU::Calendar.new("en_US")
  # cal.set(2023, 9, 27, 15, 30, 45) # Month is 0-based (9 = October)
  # dtf = ICU::DateTimeFormatter.new("en_US", pattern: "yyyy-MM-dd HH:mm:ss")
  # dtf.format(cal) # => "2023-10-27 15:30:45" (example)
  # ```
  def format(calendar : ICU::Calendar) : String
    ICU.with_auto_resizing_buffer(64, UChars) do |buff, status_ptr|
      LibICU.udat_format_calendar(@udatf, calendar.to_unsafe, buff.as(UChars), buff.size, nil, status_ptr)
    end
  end

  # Parses a string into a `Time` object according to the formatter's locale and pattern/style.
  #
  # Raises `ICU::Error` if parsing fails or if the entire string is not parsed (in strict mode).
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_US", date_style: ICU::DateTimeFormatter::FormatStyle::Short, time_style: ICU::DateTimeFormatter::FormatStyle::Short)
  # parsed_time = dtf.parse("10/27/23, 3:30 PM")
  # puts parsed_time.year # => 2023
  # ```
  def parse(text : String) : Time
    udate = parse_internal(text) do |text_uchars, parse_pos_ptr, status_ptr|
      LibICU.udat_parse(@udatf, text_uchars, text_uchars.size, parse_pos_ptr, status_ptr)
    end
    Time.unix_ms(udate.to_i64)
  end

  # Parses a string and sets the fields of the provided `ICU::Calendar` object.
  #
  # The calendar's date/time will be updated based on the parsed string.
  # Raises `ICU::Error` if parsing fails or if the entire string is not parsed (in strict mode).
  #
  # ```
  # cal = ICU::Calendar.new("en_US")
  # dtf = ICU::DateTimeFormatter.new("en_US", pattern: "yyyy-MM-dd")
  # dtf.parse("2024-01-15", cal)
  # puts cal.get(ICU::Calendar::DateField::Year) # => 2024
  # puts cal.get(ICU::Calendar::DateField::Month) # => 0 (January)
  # ```
  def parse(text : String, calendar : ICU::Calendar) : Nil
    parse_internal(text) do |text_uchars, parse_pos_ptr, status_ptr|
      LibICU.udat_parse_calendar(@udatf, calendar.to_unsafe, text_uchars, text_uchars.size, parse_pos_ptr, status_ptr)
    end
  end

  # Returns the pattern string used by this formatter.
  #
  # If `localized` is true, the pattern should be localized.
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_US", date_style: ICU::DateTimeFormatter::FormatStyle::Short, time_style: ICU::DateTimeFormatter::FormatStyle::Short)
  # dtf.pattern # => "M/d/yy, h:mm a" (example)
  # ```
  def pattern(localized : Bool = false) : String
    ICU.with_auto_resizing_buffer(64, UChars) do |buff, status_ptr|
      LibICU.udat_to_pattern(@udatf, (localized ? 1 : 0), buff.as(UChars), buff.size, status_ptr)
    end
  end

  # Configures a new pattern for the formatter (not localized)
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_US", date_style: ICU::DateTimeFormatter::FormatStyle::Short, time_style: ICU::DateTimeFormatter::FormatStyle::Short)
  # dtf.pattern= "EEEE, MMMM d, yyyy 'at' h:mm:ss a zzzz"
  # puts dtf.pattern # => "EEEE, MMMM d, yyyy 'at' h:mm:ss a zzzz"
  # ```
  def pattern=(pattern : String) : Nil
    set_pattern(pattern, false)
  end

  # Configures a new pattern for the formatter.
  #
  # If `localized` is true, the pattern is interpreted as potentially containing
  # localized characters (e.g., localized month or day names).
  # Applying an invalid pattern might cause subsequent format/parse calls to fail.
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_US", date_style: ICU::DateTimeFormatter::FormatStyle::Short, time_style: ICU::DateTimeFormatter::FormatStyle::Short)
  # dtf.set_pattern("EEEE, MMMM d, yyyy 'at' h:mm:ss a zzzz", true)
  # puts dtf.pattern # => "EEEE, MMMM d, yyyy 'at' h:mm:ss a zzzz"
  # ```
  def set_pattern(pattern : String, localized : Bool = false) : Nil
    pattern = pattern.to_uchars
    # Note: udat_applyPattern does not return UErrorCode directly in its signature,
    # but it can fail internally if the pattern is invalid. Subsequent format/parse
    # calls would then fail.
    LibICU.udat_apply_pattern(@udatf, (localized ? 1 : 0), pattern, pattern.size)
    # No immediate error check possible here based on C API, rely on subsequent calls.
  end

  # Checks if the formatter uses lenient parsing.
  #
  # Lenient parsing allows the parser to use heuristics to interpret inputs
  # that don't precisely match the pattern. Strict parsing requires exact matches.
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_US", pattern: "yyyy-MM-dd")
  # dtf.lenient? # => true (usually the default)
  # dtf.lenient = false
  # dtf.lenient? # => false
  # ```
  def lenient? : Bool
    LibICU.udat_is_lenient(@udatf) != 0
  end

  # Sets whether the formatter should use lenient parsing.
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_US", pattern: "yy/MM/dd")
  # dtf.lenient = true
  # dtf.parse("23/04/05") # Likely succeeds
  # dtf.lenient = false
  # # dtf.parse("2023/04/05") # Would likely fail if lenient is false
  # ```
  def lenient=(is_lenient : Bool) : Nil
    LibICU.udat_set_lenient(@udatf, (is_lenient ? 1 : 0))
  end

  # Sets the calendar to be used by this formatter.
  #
  # ```
  # dtf = ICU::DateTimeFormatter.new("en_US")
  # gregorian_cal = ICU::Calendar.new("en_US@calendar=gregorian")
  # dtf.calendar = gregorian_cal
  # ```
  def calendar=(calendar : ICU::Calendar) : Nil
    @ucal = calendar.to_unsafe
    @ucal.try{|ucal| LibICU.udat_set_calendar(@udatf, ucal) }
  end

  # Helper to check if parsing consumed the entire string, considering leniency settings.
  private def parse_succeeded?(original_text : String, text_length : Int32, parse_pos : Int32) : Bool
    return true if parse_pos == text_length # Fully parsed

    # If not fully parsed, check if it's okay based on leniency
    return false unless lenient? # Strict mode requires full parse

    # Lenient mode: check if remaining text is just whitespace AND whitespace leniency is enabled
    ustatus = LibICU::UErrorCode::UZeroError
    allow_whitespace_attr = LibICU::UDateFormatBooleanAttribute::ParseAllowWhitespace
    allow_whitespace = LibICU.udat_get_boolean_attribute(@udatf, allow_whitespace_attr, pointerof(ustatus))
    ICU.check_error!(ustatus)

    # Check if remaining characters are all whitespace
    remaining_text = original_text[parse_pos..-1]
    remaining_text.strip.empty?
  end

  # Private helper for formatting methods that use a resizable buffer.
  # Private helper for parsing methods.
  # Takes the input text and a block that performs the actual ICU parsing call.
  # The block receives text UChars, text length, parse position pointer, and status pointer.
  # It should return the result of the parse call (e.g., UDate or Nil).
  private def parse_internal(text : String, &block)
    ustatus = LibICU::UErrorCode::UZeroError
    text_uchars = text.to_uchars
    parse_pos = 0_i32

    # Yield to the block to perform the ICU call
    result = yield text_uchars, pointerof(parse_pos), pointerof(ustatus)

    # Check for ICU errors first
    ICU.check_error!(ustatus)

    # Check if the entire string was parsed according to leniency rules
    unless parse_succeeded?(text, text_uchars.size, parse_pos)
      raise ICU::Error.new("Parsing failed: Unparsed text remaining at index #{parse_pos} in '#{text}'")
    end

    result
  end
end
