# Locales
#
# This class provides a high-level wrapper around ICU's locale functionality.
# It allows querying locale components, getting display names, canonicalizing
# locale identifiers, and accessing locale-specific data like measurement
# systems and paper sizes.
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/locale/)
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/uloc_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/locale_spec.cr)
class ICU::Locale
  # Alias
  alias DelimiterType = LibICU::ULocaleDataDelimiterType
  alias MeasurementSystem = LibICU::UMeasurementSystem
  alias LayoutType = LibICU::ULayoutType
  alias AcceptResult = LibICU::UAcceptResult

  # Constants
  class Keyword
    SEPARATOR      = '@'
    ASSIGN         = '='
    ITEM_SEPARATOR = ';'
  end

  class Capacity
    LANG_MAX_SIZE                =  12
    COUNTRY_MAX_SIZE             =   4
    FULLNAME_MAX_SIZE            = 157
    SCRIPT_MAX_SIZE              =   6
    KEYWORDS_MAX_SIZE            =  96
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
    get_string_component(Capacity::LANG_MAX_SIZE) do |buff, size, status_ptr|
      LibICU.uloc_get_language(@id, buff, size, status_ptr)
    end
  end

  # Returns the country code for this locale.
  #
  # ```
  # ICU::Locale.new("en_US").country # => "US"
  # ```
  def country : String
    get_string_component(Capacity::COUNTRY_MAX_SIZE) do |buff, size, status_ptr|
      LibICU.uloc_get_country(@id, buff, size, status_ptr)
    end
  end

  # Returns the script code for this locale.
  #
  # ```
  # ICU::Locale.new("zh-Hans-CN").script # => "Hans"
  # ```
  def script : String
    get_string_component(Capacity::SCRIPT_MAX_SIZE) do |buff, size, status_ptr|
      LibICU.uloc_get_script(@id, buff, size, status_ptr)
    end
  end

  # Returns the variant code for this locale.
  #
  # ```
  # ICU::Locale.new("en_US_POSIX").variant # => "POSIX"
  # ```
  def variant : String
    get_string_component(Capacity::FULLNAME_MAX_SIZE) do |buff, size, status_ptr|
      LibICU.uloc_get_variant(@id, buff, size, status_ptr)
    end
  end

  # Returns the base name (language, script, country, variant) for this locale.
  #
  # ```
  # ICU::Locale.new("en_US@collation=phonebook").base_name # => "en_US"
  # ```
  def base_name : String
    get_string_component(Capacity::FULLNAME_MAX_SIZE) do |buff, size, status_ptr|
      LibICU.uloc_get_base_name(@id, buff, size, status_ptr)
    end
  end

  # Returns the full name (identifier) for this locale.
  # Same as `id`.
  #
  # ```
  # ICU::Locale.new("en_US").name # => "en_US"
  # ```
  def name : String
    get_string_component(Capacity::FULLNAME_MAX_SIZE) do |buff, size, status_ptr|
      LibICU.uloc_get_name(@id, buff, size, status_ptr)
    end
  end

  # Returns the display name for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("fr_FR").display_name("en_US") # => "French (France)"
  # ICU::Locale.new("en_US").display_name("fr_FR") # => "anglais (États-Unis)"
  # ```
  def display_name(display_locale : String) : String
    ICU.with_auto_resizing_buffer(64, UChars) do |buff, status_ptr|
      LibICU.uloc_get_display_name(@id, display_locale, buff.as(UChars), buff.size, status_ptr)
    end
  end

  # Returns the display language for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("fr_FR").display_language("en_US") # => "French"
  # ```
  def display_language(display_locale : String) : String
    ICU.with_auto_resizing_buffer(32, UChars) do |buff, status_ptr|
      LibICU.uloc_get_display_language(@id, display_locale, buff.as(UChars), buff.size, status_ptr)
    end
  end

  # Returns the display country for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("fr_FR").display_country("en_US") # => "France"
  # ```
  def display_country(display_locale : String) : String
    ICU.with_auto_resizing_buffer(32, UChars) do |buff, status_ptr|
      LibICU.uloc_get_display_country(@id, display_locale, buff.as(UChars), buff.size, status_ptr)
    end
  end

  # Returns the display script for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("zh-Hans-CN").display_script("en_US") # => "Simplified Han"
  # ```
  def display_script(display_locale : String) : String
    ICU.with_auto_resizing_buffer(32, UChars) do |buff, status_ptr|
      LibICU.uloc_get_display_script(@id, display_locale, buff.as(UChars), buff.size, status_ptr)
    end
  end

  # Returns the display variant for this locale in the specified display locale.
  #
  # ```
  # ICU::Locale.new("en_US_POSIX").display_variant("en_US") # => "POSIX"
  # ```
  def display_variant(display_locale : String) : String
    ICU.with_auto_resizing_buffer(32, UChars) do |buff, status_ptr|
      LibICU.uloc_get_display_variant(@id, display_locale, buff.as(UChars), buff.size, status_ptr)
    end
  end

  # Returns the display name for a keyword value in the specified display locale.
  #
  # ```
  # ICU::Locale.new("fr_FR@collation=phonebook").display_keyword_value("collation", "en_US") # => "Phonebook Collation"
  # ```
  def display_keyword_value(keyword : String, display_locale : String) : String
    ICU.with_auto_resizing_buffer(32, UChars) do |buff, status_ptr|
      LibICU.uloc_get_display_keyword_value(@id, keyword, display_locale, buff.as(UChars), buff.size, status_ptr)
    end
  end

  # Canonicalizes the locale ID.
  #
  # ```
  # ICU::Locale.new("en-us").canonicalize # => ICU::Locale.new("en_US")
  # ```
  def canonicalize : Locale
    # Canonicalization shouldn't increase length significantly, but use retry just in case.
    get_locale_with_retry(Capacity::FULLNAME_MAX_SIZE) do |buff, status_ptr|
      LibICU.uloc_canonicalize(@id, buff, buff.size, status_ptr)
    end
  end

  # Adds likely subtags to the locale ID.
  #
  # ```
  # ICU::Locale.new("en").add_likely_subtags # => ICU::Locale.new("en_Latn_US")
  # ```
  def add_likely_subtags : Locale
    get_locale_with_retry(Capacity::FULLNAME_MAX_SIZE) do |buff, status_ptr|
      LibICU.uloc_add_likely_subtags(@id, buff, buff.size, status_ptr)
    end
  end

  # Minimizes the subtags of the locale ID.
  #
  # ```
  # ICU::Locale.new("en_Latn_US").minimize_subtags # => ICU::Locale.new("en")
  # ```
  def minimize_subtags : Locale
    get_locale_with_retry(Capacity::FULLNAME_MAX_SIZE) do |buff, status_ptr|
      LibICU.uloc_minimize_subtags(@id, buff, buff.size, status_ptr)
    end
  end

  # Sets the value for a keyword in this locale, returning a new Locale instance.
  #
  # ```
  # ICU::Locale.new("fr_FR").set_keyword_value("collation", "phonebook") # => ICU::Locale.new("fr_FR@collation=phonebook")
  # ```
  def add_keyword_value(keyword_name : String, keyword_value : String) : Locale
    # Estimate initial buffer size: original ID + '@' + keyword + '=' + value + ';' + null terminator.
    # Use FULLNAME_MAX_SIZE as a lower bound.
    initial_buff_size = Math.max(
      @id.bytesize + 1 + keyword_name.bytesize + 1 + keyword_value.bytesize + 2,
      Capacity::FULLNAME_MAX_SIZE
    )

    id = ICU.with_auto_resizing_buffer(initial_buff_size, Bytes) do |buff, status_ptr|
      @id.to_slice.copy_to(buff.as(Bytes).to_slice)
      LibICU.uloc_set_keyword_value(keyword_name, keyword_value, buff.as(Bytes), buff.size, status_ptr)
    end

    Locale.new(id)
  end

  # Returns the value for a keyword in this locale.
  # Returns an empty string if the keyword is not found.
  #
  # ```
  # ICU::Locale.new("fr_FR@collation=phonebook;calendar=gregorian").keyword_value("collation") # => "phonebook"
  # ICU::Locale.new("en_US").keyword_value("collation")                                        # => ""
  # ```
  def keyword_value(keyword_name : String) : String
    # Returns empty string if keyword not found (status U_ZERO_ERROR, len 0)
    # which is handled correctly by ICU.with_auto_resizing_buffer.
    ICU.with_auto_resizing_buffer(Capacity::KEYWORDS_AND_VALUES_MAX_SIZE, Bytes) do |buff, status_ptr|
      LibICU.uloc_get_keyword_value(@id, keyword_name, buff.as(Bytes), buff.size, status_ptr)
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
    ICU::UEnum.new(uenum, owns: true)
  end

  # Converts the locale ID to a BCP 47 language tag.
  #
  # ```
  # ICU::Locale.new("en_US").to_language_tag                     # => "en-US"
  # ICU::Locale.new("en_US_POSIX").to_language_tag(strict: true) # => "en-US-posix"
  # ```
  def to_language_tag(strict : Bool = false) : String
    ICU.with_auto_resizing_buffer(Capacity::FULLNAME_MAX_SIZE, Bytes) do |buff, status_ptr|
      LibICU.uloc_to_language_tag(@id, buff.as(Bytes), buff.size, strict ? 1_u8 : 0_u8, status_ptr)
    end
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

  # Returns the delimiter string for the specified type.
  #
  # ```
  # ICU::Locale.new("en_US").delimiter(:QuotationStart) # => "“"
  # ```
  def delimiter(type : DelimiterType) : String
    with_locale_data do |uld|
      ICU.with_auto_resizing_buffer(16, UChars) do |buff, status_ptr|
        LibICU.ulocdata_get_delimiter(uld, type, buff.as(UChars), buff.size, status_ptr)
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
      ICU.with_auto_resizing_buffer(32, UChars) do |buff, status_ptr|
        LibICU.ulocdata_get_locale_display_pattern(uld, buff.as(UChars), buff.size, status_ptr)
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
      ICU.with_auto_resizing_buffer(16, UChars) do |buff, status_ptr|
        LibICU.ulocdata_get_locale_separator(uld, buff.as(UChars), buff.size, status_ptr)
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

  # Creates a Locale from a BCP 47 language tag.
  #
  # ```
  # ICU::Locale.from_language_tag("en-US") # => ICU::Locale.new("en_US")
  # ```
  def self.from_language_tag(langtag : String) : Locale
    # Use the class-level helper which now calls the Utils method
    get_locale_with_retry(Capacity::FULLNAME_MAX_SIZE) do |buff, status_ptr|
      parsed_length = 0_i32 # Needs to be Int32*
      LibICU.uloc_for_language_tag(langtag, buff, buff.size, pointerof(parsed_length), status_ptr)
    end
  end

  # Returns the display name for a keyword in the specified display locale.
  #
  # ```
  # ICU::Locale.display_keyword("collation", "en_US") # => "Collation"
  # ```
  def self.display_keyword(keyword : String, display_locale : String) : String
    ICU.with_auto_resizing_buffer(32, UChars) do |buff, status_ptr|
      LibICU.uloc_get_display_keyword(keyword, display_locale, buff.as(UChars), buff.size, status_ptr)
    end
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
    locales = UEnum.new(uenum, owns: true).to_a
    locales.map { |r| new(r) }
  end

  # ---------------
  # Private Helpers
  # ---------------

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

  # Helper for simple ICU calls filling a fixed-size Bytes buffer.
  private def get_string_component(max_size : Int) : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff = Bytes.new(max_size)
    len = yield buff, buff.size, pointerof(ustatus)
    ICU.check_error!(ustatus)
    String.new(buff.to_slice[0, len])
  end

  # Helper for ICU calls creating a new locale string, with retry on overflow.
  # Uses the shared utility function.
  # The block passed here (&block) is the one that actually calls the ICU C function.
  # The block now only receives the buffer and status pointer.
  private def get_locale_with_retry(initial_size : Int, &block : (Bytes, LibICU::UErrorCode* -> Int32)) : Locale
    string_id = ICU.with_auto_resizing_buffer(initial_size, Bytes) do |buff, status_ptr|
      # Call the original block passed to get_locale_with_retry
      # Use .as(Bytes) because the utility block yields Bytes | UChars
      block.call(buff.as(Bytes), status_ptr)
    end
    Locale.new(string_id)
  end

  # Helper for class methods creating a new locale string, with retry on overflow.
  # Uses the shared utility function.
  # The block passed here (&block) is the one that actually calls the ICU C function.
  # The block now only receives the buffer and status pointer.
  private def self.get_locale_with_retry(initial_size : Int, &block : (Bytes, LibICU::UErrorCode* -> Int32)) : Locale
    string_id = ICU.with_auto_resizing_buffer(initial_size, Bytes) do |buff, status_ptr|
      # Call the original block passed to self.get_locale_with_retry
      # Use .as(Bytes) because the utility block yields Bytes | UChars
      block.call(buff.as(Bytes), status_ptr)
    end
    Locale.new(string_id)
  end

  # Notably missing bindings:
  # - LibICU.uloc_get_iso_languages
  # - LibICU.uloc_get_iso_countries
end
