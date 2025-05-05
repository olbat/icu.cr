# Locales
#
# This class provides a high-level wrapper around ICU's locale functionality.
# It allows querying locale components, getting display names, canonicalizing
# locale identifiers, and accessing locale-specific data like measurement
# systems and paper sizes.
#
# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/uloc_8h.html)
# - [user guide](http://userguide.icu-project.org/locale)
class ICU::Locale
  # Alias
  alias DelimiterType = LibICU::ULocaleDataDelimiterType
  alias MeasurementSystem = LibICU::UMeasurementSystem
  alias LayoutType = LibICU::ULayoutType
  alias AcceptResult = LibICU::UAcceptResult

  # Constants
  class Keyword
    SEPARATOR = '@'
    ASSIGN = '='
    ITEM_SEPARATOR = ';'
  end

  class Capacity
    LANG_MAX_SIZE =  12
    COUNTRY_MAX_SIZE =   4
    FULLNAME_MAX_SIZE = 157
    SCRIPT_MAX_SIZE =   6
    KEYWORDS_MAX_SIZE =  96
    KEYWORDS_AND_VALUES_MAX_SIZE = 100
  end

  # Represents a locale identifier string.
  getter id : String

  # Creates a new Locale instance.
  #
  # ```
  # locale = ICU::Locale.new("en_US")
  # locale = ICU::Locale.new("fr_FR@collation=phonebook")
  # ```
  def initialize(@id : String)
    # No-op, validation happens in ICU C functions when needed.
  end

  # Returns the language code for this locale.
  #
  # ```
  # ICU::Locale.new("en_US").language # => "en"
  # ```
  def language : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff = Bytes.new(Capacity::LANG_MAX_SIZE)
    len = LibICU.uloc_get_language(@id, buff, buff.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    String.new(buff.to_slice[0, len])
  end

  # Returns the country code for this locale.
  #
  # ```
  # ICU::Locale.new("en_US").country # => "US"
  # ```
  def country : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff = Bytes.new(Capacity::COUNTRY_MAX_SIZE)
    len = LibICU.uloc_get_country(@id, buff, buff.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    String.new(buff.to_slice[0, len])
  end

  # Returns the script code for this locale.
  #
  # ```
  # ICU::Locale.new("zh-Hans-CN").script # => "Hans"
  # ```
  def script : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff = Bytes.new(Capacity::SCRIPT_MAX_SIZE)
    len = LibICU.uloc_get_script(@id, buff, buff.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    String.new(buff.to_slice[0, len])
  end

  # Returns the variant code for this locale.
  #
  # ```
  # ICU::Locale.new("en_US_POSIX").variant # => "POSIX"
  # ```
  def variant : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff = Bytes.new(Capacity::FULLNAME_MAX_SIZE)
    len = LibICU.uloc_get_variant(@id, buff, buff.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    String.new(buff.to_slice[0, len])
  end

  # Returns the base name (language, script, country, variant) for this locale.
  #
  # ```
  # ICU::Locale.new("en_US@collation=phonebook").base_name # => "en_US"
  # ```
  def base_name : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff = Bytes.new(Capacity::FULLNAME_MAX_SIZE)
    len = LibICU.uloc_get_base_name(@id, buff, buff.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    String.new(buff.to_slice[0, len])
  end

  # Returns the full name (identifier) for this locale.
  # Same as `id`.
  #
  # ```
  # ICU::Locale.new("en_US").name # => "en_US"
  # ```
  def name : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff = Bytes.new(Capacity::FULLNAME_MAX_SIZE)
    len = LibICU.uloc_get_name(@id, buff, buff.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    String.new(buff.to_slice[0, len])
  end

  # Returns the display name for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("fr_FR").display_name("en_US") # => "French (France)"
  # ICU::Locale.new("en_US").display_name("fr_FR") # => "anglais (États-Unis)"
  # ```
  def display_name(display_locale : String) : String
    ustatus = LibICU::UErrorCode::UZeroError
    # Estimate buff size, ICU functions return required size if buff is too small
    loop do
      buff = UChars.new(64)
      len = LibICU.uloc_get_display_name(@id, display_locale, buff, buff.size, pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1 # Add 1 for null terminator if needed, though to_s handles length
        ustatus = LibICU::UErrorCode::UZeroError # Reset status
        next # Retry with larger buff
      end
      ICU.check_error!(ustatus)
      return buff.to_s(len)
    end
  end

  # Returns the display language for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("fr_FR").display_language("en_US") # => "French"
  # ```
  def display_language(display_locale : String) : String
    ustatus = LibICU::UErrorCode::UZeroError
    loop do
      buff = UChars.new(32)
      len = LibICU.uloc_get_display_language(@id, display_locale, buff, buff.size, pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return buff.to_s(len)
    end
  end

  # Returns the display country for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("fr_FR").display_country("en_US") # => "France"
  # ```
  def display_country(display_locale : String) : String
    ustatus = LibICU::UErrorCode::UZeroError
    loop do
      buff = UChars.new(32)
      len = LibICU.uloc_get_display_country(@id, display_locale, buff, buff.size, pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return buff.to_s(len)
    end
  end

  # Returns the display script for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("zh-Hans-CN").display_script("en_US") # => "Simplified Han"
  # ```
  def display_script(display_locale : String) : String
    ustatus = LibICU::UErrorCode::UZeroError
    loop do
      buff = UChars.new(32)
      len = LibICU.uloc_get_display_script(@id, display_locale, buff, buff.size, pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return buff.to_s(len)
    end
  end

  # Returns the display variant for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("en_US_POSIX").display_variant("en_US") # => "POSIX"
  # ```
  def display_variant(display_locale : String) : String
    ustatus = LibICU::UErrorCode::UZeroError
    loop do
      buff = UChars.new(32)
      len = LibICU.uloc_get_display_variant(@id, display_locale, buff, buff.size, pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return buff.to_s(len)
    end
  end

  # Returns the display name for a keyword in the specified display locale.
  #
  # ```
  # ICU::Locale.display_keyword("collation", "en_US") # => "Collation"
  # ```
  def self.display_keyword(keyword : String, display_locale : String) : String
    ustatus = LibICU::UErrorCode::UZeroError
    loop do
      buff = UChars.new(32)
      len = LibICU.uloc_get_display_keyword(keyword, display_locale, buff, buff.size, pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return buff.to_s(len)
    end
  end

  # Returns the display name for a keyword value in the specified display locale.
  #
  # ```
  # ICU::Locale.new("fr_FR@collation=phonebook").display_keyword_value("collation", "en_US") # => "Phonebook Collation"
  # ```
  def display_keyword_value(keyword : String, display_locale : String) : String
    ustatus = LibICU::UErrorCode::UZeroError
    loop do
      buff = UChars.new(32)
      len = LibICU.uloc_get_display_keyword_value(@id, keyword, display_locale, buff, buff.size, pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return buff.to_s(len)
    end
  end

  # Canonicalizes the locale ID.
  #
  # ```
  # ICU::Locale.new("en-us").canonicalize # => ICU::Locale.new("en_US")
  # ```
  def canonicalize : Locale
    ustatus = LibICU::UErrorCode::UZeroError
    buff = Bytes.new(Capacity::FULLNAME_MAX_SIZE)
    len = LibICU.uloc_canonicalize(@id, buff, buff.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    Locale.new(String.new(buff.to_slice[0, len]))
  end

  # Adds likely subtags to the locale ID.
  #
  # ```
  # ICU::Locale.new("en").add_likely_subtags # => ICU::Locale.new("en_Latn_US")
  # ```
  def add_likely_subtags : Locale
    ustatus = LibICU::UErrorCode::UZeroError
    buff_size = Capacity::FULLNAME_MAX_SIZE
    loop do
      buff = Bytes.new(buff_size)
      len = LibICU.uloc_add_likely_subtags(@id, buff, buff.size, pointerof(ustatus))
        if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return Locale.new(String.new(buff.to_slice[0, len]))
    end
  end

  # Minimizes the subtags of the locale ID.
  #
  # ```
  # ICU::Locale.new("en_Latn_US").minimize_subtags # => ICU::Locale.new("en")
  # ```
  def minimize_subtags : Locale
    ustatus = LibICU::UErrorCode::UZeroError
    buff_size = Capacity::FULLNAME_MAX_SIZE
    loop do
      buff = Bytes.new(buff_size)
      len = LibICU.uloc_minimize_subtags(@id, buff, buff.size, pointerof(ustatus))
        if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return Locale.new(String.new(buff.to_slice[0, len]))
    end
  end

  # Converts the locale ID to a BCP 47 language tag.
  #
  # ```
  # ICU::Locale.new("en_US").to_language_tag # => "en-US"
  # ICU::Locale.new("en_US_POSIX").to_language_tag(strict: true) # => "en-US-posix"
  # ```
  def to_language_tag(strict : Bool = false) : String
    ustatus = LibICU::UErrorCode::UZeroError
    loop do
      buff = Bytes.new(Capacity::FULLNAME_MAX_SIZE)
      # Convert Bool to UInt8 (UBool)
      len = LibICU.uloc_to_language_tag(@id, buff, buff.size, strict ? 1_u8 : 0_u8, pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return String.new(buff.to_slice[0, len])
    end
  end

  # Creates a Locale from a BCP 47 language tag.
  #
  # ```
  # ICU::Locale.from_language_tag("en-US") # => ICU::Locale.new("en_US")
  # ```
  def self.from_language_tag(langtag : String) : Locale
    ustatus = LibICU::UErrorCode::UZeroError
    loop do
      buff = Bytes.new(Capacity::FULLNAME_MAX_SIZE)
      parsed_length = 0 # Not used in this high-level wrapper
      len = LibICU.uloc_for_language_tag(langtag, buff, buff.size, pointerof(parsed_length), pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return Locale.new(String.new(buff.to_slice[0, len]))
    end
  end

  # Returns the value for a keyword in this locale.
  # Returns an empty string if the keyword is not found.
  #
  # ```
  # ICU::Locale.new("fr_FR@collation=phonebook;calendar=gregorian").keyword_value("collation") # => "phonebook"
  # ICU::Locale.new("en_US").keyword_value("collation") # => ""
  # ```
  def keyword_value(keyword_name : String) : String
    ustatus = LibICU::UErrorCode::UZeroError
    loop do
      buff = Bytes.new(Capacity::KEYWORDS_AND_VALUES_MAX_SIZE)
      len = LibICU.uloc_get_keyword_value(@id, keyword_name, buff, buff.size, pointerof(ustatus))
      # U_BUFFER_OVERFLOW_ERROR is possible, but U_ZERO_ERROR with len=0 means keyword not found.
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      # If len is 0 and status is U_ZERO_ERROR, the keyword was not found.
      return String.new(buff.to_slice[0, len])
    end
  end

  # Sets the value for a keyword in this locale, returning a new Locale instance.
  #
  # ```
  # ICU::Locale.new("fr_FR").set_keyword_value("collation", "phonebook") # => ICU::Locale.new("fr_FR@collation=phonebook")
  # ```
  def set_keyword_value(keyword_name : String, keyword_value : String) : Locale
    ustatus = LibICU::UErrorCode::UZeroError
    # Estimate buff size: original ID + '@' + keyword + '=' + value + ';' + null
    # The C function modifies the buffer in place, so the buffer must contain the original ID.
    buff_size = @id.bytesize + 1 + keyword_name.bytesize + 1 + keyword_value.bytesize + 1 + 1
    # Ensure minimum size
    buff_size = Math.max(buff_size, Capacity::FULLNAME_MAX_SIZE)

    loop do
      buff = Bytes.new(buff_size)
      # Copy the current locale ID into the buffer before calling the C function
      @id.to_slice.copy_to(buff.to_slice)

      len = LibICU.uloc_set_keyword_value(keyword_name, keyword_value, buff, buff.size, pointerof(ustatus))
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1
        ustatus = LibICU::UErrorCode::UZeroError
        next
      end
      ICU.check_error!(ustatus)
      return Locale.new(String.new(buff.to_slice[0, len]))
    end
  end

  # Returns an enumerator for the keywords in this locale.
  #
  # ```
  # ICU::Locale.new("fr_FR@collation=phonebook;calendar=gregorian").keywords.to_a # => ["collation", "calendar"]
  # ```
  def keywords : Enumerable(String)
    ustatus = LibICU::UErrorCode::UZeroError
    uenum = LibICU.uloc_open_keywords(@id, pointerof(ustatus))
    ICU.check_error!(ustatus)
    # Use the correct class name ICU::UEnum
    ICU::UEnum.new(uenum)
  end

  # Returns the character orientation for this locale (Left-to-Right or Right-to-Left).
  #
  # ```
  # ICU::Locale.new("en_US").character_orientation # => :LayoutLtr
  # ```
  def character_orientation : LayoutType
    ustatus = LibICU::UErrorCode::UZeroError
    orientation = LibICU.uloc_get_character_orientation(@id, pointerof(ustatus))
    ICU.check_error!(ustatus)
    orientation
  end

  # Returns the line orientation for this locale (Top-to-Bottom or Bottom-to-Top).
  #
  # ```
  # ICU::Locale.new("en_US").line_orientation # => :LayoutTtb
  # ```
  def line_orientation : LayoutType
    ustatus = LibICU::UErrorCode::UZeroError
    orientation = LibICU.uloc_get_line_orientation(@id, pointerof(ustatus))
    ICU.check_error!(ustatus)
    orientation
  end

  # Checks if the character orientation is Right-to-Left.
  #
  # ```
  # ICU::Locale.new("en_US").right_to_left? # => false
  # ```
  def right_to_left? : Bool
    LibICU.uloc_is_right_to_left(@id) == 1 # UBool is Int8T, 1 for true
  end

  # Returns the measurement system for this locale.
  #
  # ```
  # ICU::Locale.new("en_US").measurement_system # => :Us
  # ```
  def measurement_system : MeasurementSystem
    ustatus = LibICU::UErrorCode::UZeroError
    system = LibICU.ulocdata_get_measurement_system(@id, pointerof(ustatus))
    ICU.check_error!(ustatus)
    system
  end

  # --- Locale Data Access (requires ULocaleData object) ---
  # Helper to open and close ULocaleData
  private def with_locale_data(&block : LibICU::ULocaleData -> T) : T forall T
    ustatus = LibICU::UErrorCode::UZeroError
    uld = LibICU.ulocdata_open(@id, pointerof(ustatus))
    ICU.check_error!(ustatus)
    begin
      yield uld
    ensure
      LibICU.ulocdata_close(uld)
    end
  end

  # Returns the delimiter string for the specified type.
  #
  # ```
  # ICU::Locale.new("en_US").delimiter(:QuotationStart) # => "“"
  # ```
  def delimiter(type : DelimiterType) : String
    with_locale_data do |uld|
      ustatus = LibICU::UErrorCode::UZeroError
      buff_size = 16 # Delimiters are usually short
      loop do
        buff = UChars.new(buff_size)
        len = LibICU.ulocdata_get_delimiter(uld, type, buff, buff.size, pointerof(ustatus))
        if ustatus == LibICU::UErrorCode::UBufferOverflowError
          buff_size = len + 1
          ustatus = LibICU::UErrorCode::UZeroError
          next
        end
        ICU.check_error!(ustatus)
        return buff.to_s(len)
      end
    end
  end

  # Returns the locale display pattern.
  #
  # ```
  # ICU::Locale.new("en_US").locale_display_pattern # => "{0} ({1})"
  # ```
  def locale_display_pattern : String
    with_locale_data do |uld|
      ustatus = LibICU::UErrorCode::UZeroError
      buff_size = 32 # Pattern is usually short
      loop do
        buff = UChars.new(buff_size)
        len = LibICU.ulocdata_get_locale_display_pattern(uld, buff, buff.size, pointerof(ustatus))
        if ustatus == LibICU::UErrorCode::UBufferOverflowError
          buff_size = len + 1
          ustatus = LibICU::UErrorCode::UZeroError
          next
        end
        ICU.check_error!(ustatus)
        return buff.to_s(len)
      end
    end
  end

  # Returns the locale separator string.
  #
  # ```
  # ICU::Locale.new("en_US").locale_separator # => ", "
  # ```
  def locale_separator : String
    with_locale_data do |uld|
      ustatus = LibICU::UErrorCode::UZeroError
      buff_size = 16 # Separator is usually short
      loop do
        buff = UChars.new(buff_size)
        len = LibICU.ulocdata_get_locale_separator(uld, buff, buff.size, pointerof(ustatus))
        if ustatus == LibICU::UErrorCode::UBufferOverflowError
          buff_size = len + 1
          ustatus = LibICU::UErrorCode::UZeroError
          next
        end
        ICU.check_error!(ustatus)
        return buff.to_s(len)
      end
    end
  end

  # Returns the default locale for the system.
  #
  # ```
  # ICU::Locale.default # => ICU::Locale.new("en_US") # or your system's default
  # ```
  def self.default : Locale
    Locale.new(String.new(LibICU.uloc_get_default))
  end

  # Returns an enumerator for all available locale IDs.
  #
  # ```
  # ICU::Locale.available_locales.each { |locale| puts locale.name }
  # ```
  def self.available_locales : Array(Locale)
    ustatus = LibICU::UErrorCode::UZeroError
    uenum = LibICU.uloc_open_available_by_type(LibICU::ULocAvailableType::AvailableDefault, pointerof(ustatus))
    ICU.check_error!(ustatus)
    # Use the correct class name ICU::UEnum
    locales = UEnum.new(uenum).to_a
    LibICU.uenum_close(uenum)
    locales.map { |r| new(r) }
  end

  # Notably missing bindings:
  # - LibICU.uloc_get_iso_languages
  # - LibICU.uloc_get_iso_countries
end
