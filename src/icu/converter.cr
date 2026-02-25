# __Codepage Conversion__
#
# Convert text between Unicode and various legacy character encodings (codepages).
#
# `ICU::Converter` wraps a single ICU `UConverter`, which encapsulates a
# specific encoding (e.g. `"ISO-8859-1"`, `"Shift_JIS"`, `"UTF-16BE"`).
# It exposes the most important conversion operations: encoding a `String`
# to raw bytes in the target encoding, and decoding raw bytes back to a
# `String` (which Crystal always stores as UTF-8).
#
# `ICU::ConverterSelector` wraps `UConverterSelector` and lets you quickly
# determine which converters from a given list are able to round-trip a
# particular string without data loss.
#
# __Usage__
# ```
# cnv = ICU::Converter.new("ISO-8859-1")
# cnv.name # => "ISO-8859-1"
# cnv.type # => ICU::Converter::Type::Latin1
#
# # Encode UTF-8 string to ISO-8859-1 bytes
# bytes = cnv.encode("Héllo")
#
# # Decode ISO-8859-1 bytes back to a UTF-8 String
# str = cnv.decode(bytes) # => "Héllo"
#
# # One-shot conversion between two encodings
# result = ICU::Converter.convert("UTF-8", "ISO-8859-1", bytes)
# ```
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/conversion/)
# - [Reference C API (ucnv.h)](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/ucnv_8h.html)
# - [Reference C API (ucnvsel.h)](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/ucnvsel_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/converter_spec.cr)
class ICU::Converter
  alias Type = LibICU::UConverterType
  alias Platform = LibICU::UConverterPlatform

  @ucnv : LibICU::UConverter
  @@available_names : Array(String)?

  # Opens a converter for the named encoding.
  #
  # The *name* may be a canonical name, an alias, or a MIME/IANA name as
  # recognized by ICU (e.g. `"UTF-8"`, `"ISO-8859-1"`, `"windows-1252"`).
  #
  # Raises `ICU::Error` if the encoding is unknown.
  #
  # ```
  # ICU::Converter.new("UTF-8")
  # ICU::Converter.new("Shift_JIS")
  # ```
  def initialize(name : String)
    ustatus = LibICU::UErrorCode::UZeroError
    @ucnv = LibICU.ucnv_open(name, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def finalize
    @ucnv.try { |cnv| LibICU.ucnv_close(cnv) }
  end

  def to_unsafe
    @ucnv
  end

  # Returns the canonical name of this converter.
  #
  # ```
  # ICU::Converter.new("latin-1").name # => "ISO-8859-1"
  # ```
  def name : String
    ustatus = LibICU::UErrorCode::UZeroError
    ptr = LibICU.ucnv_get_name(@ucnv, pointerof(ustatus))
    ICU.check_error!(ustatus)
    String.new(ptr)
  end

  # Returns the type of this converter.
  #
  # ```
  # ICU::Converter.new("UTF-8").type # => ICU::Converter::Type::Utf8
  # ```
  def type : Type
    LibICU.ucnv_get_type(@ucnv)
  end

  # Returns the minimum number of bytes used per character.
  def min_char_size : Int32
    LibICU.ucnv_get_min_char_size(@ucnv).to_i32
  end

  # Returns the maximum number of bytes used per character.
  def max_char_size : Int32
    LibICU.ucnv_get_max_char_size(@ucnv).to_i32
  end

  # Returns `true` if the converter has an ambiguous character mapping (e.g.
  # encodings where the same byte sequences mean different things depending
  # on context or locale).
  def ambiguous? : Bool
    LibICU.ucnv_is_ambiguous(@ucnv) != 0
  end

  # Returns `true` if every character in this encoding has a fixed byte width.
  def fixed_width? : Bool
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.ucnv_is_fixed_width(@ucnv, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret != 0
  end

  # Resets the converter to its initial state, discarding any partial
  # conversion state.
  def reset : self
    LibICU.ucnv_reset(@ucnv)
    self
  end

  # Encodes the given UTF-8 *string* to bytes using this converter's encoding.
  #
  # ```
  # cnv = ICU::Converter.new("ISO-8859-1")
  # cnv.encode("Héllo") # => Bytes[...]
  # ```
  def encode(string : String) : Bytes
    src = string.to_uchars
    # Worst case: max_char_size bytes per UChar
    capacity = src.size * max_char_size + 1
    dest = Bytes.new(capacity)
    ustatus = LibICU::UErrorCode::UZeroError
    size = LibICU.ucnv_from_u_chars(@ucnv, dest, capacity, src, src.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    dest[0, size]
  end

  # Decodes the given *bytes* (in this converter's encoding) to a UTF-8 `String`.
  #
  # ```
  # cnv = ICU::Converter.new("ISO-8859-1")
  # bytes = cnv.encode("Héllo")
  # cnv.decode(bytes) # => "Héllo"
  # ```
  def decode(bytes : Bytes) : String
    # Each source byte could expand to at most 4 UChars (surrogates)
    capacity = bytes.size * 4 + 1
    dest = UChars.new(capacity)
    ustatus = LibICU::UErrorCode::UZeroError
    size = LibICU.ucnv_to_u_chars(@ucnv, dest, capacity, bytes, bytes.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    dest.to_s(size)
  end

  # Returns the list of known aliases for the given encoding name.
  #
  # ```
  # ICU::Converter.aliases("UTF-8") # => ["UTF-8", "unicode-1-1-utf-8", "utf8", ...]
  # ```
  def self.aliases(name : String) : Array(String)
    ustatus = LibICU::UErrorCode::UZeroError
    count = LibICU.ucnv_count_aliases(name, pointerof(ustatus))
    ICU.check_error!(ustatus)

    (0...count.to_i).map do |i|
      ustatus = LibICU::UErrorCode::UZeroError
      ptr = LibICU.ucnv_get_alias(name, i.to_u16, pointerof(ustatus))
      ICU.check_error!(ustatus)
      String.new(ptr)
    end
  end

  # Returns the canonical name for the given alias and standard.
  #
  # ```
  # ICU::Converter.canonical_name("utf8", "IANA") # => "UTF-8"
  # ```
  def self.canonical_name(alias_name : String, standard : String = "IANA") : String?
    ustatus = LibICU::UErrorCode::UZeroError
    ptr = LibICU.ucnv_get_canonical_name(alias_name, standard, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ptr ? String.new(ptr) : nil
  end

  # Returns the list of all available converter names.
  #
  # The list is computed once and cached.
  #
  # ```
  # ICU::Converter.available_names.includes?("UTF-8") # => true
  # ```
  def self.available_names : Array(String)
    @@available_names ||= begin
      count = LibICU.ucnv_count_available
      (0...count).map { |i| String.new(LibICU.ucnv_get_available_name(i)) }
    end
  end

  # Returns the default converter name for the current platform/locale.
  #
  # ```
  # ICU::Converter.default_name # => "UTF-8"
  # ```
  def self.default_name : String
    String.new(LibICU.ucnv_get_default_name)
  end

  # Converts *source* bytes directly from *from_encoding* to *to_encoding*
  # without instantiating two separate converters.
  #
  # Returns the converted bytes.
  #
  # ```
  # utf8_bytes = "Héllo".encode("UTF-8")
  # latin1 = ICU::Converter.convert("UTF-8", "ISO-8859-1", utf8_bytes)
  # ```
  def self.convert(from_encoding : String, to_encoding : String, source : Bytes) : Bytes
    # Allocate a generous output buffer and retry on overflow
    capacity = source.size * 4 + 8
    loop do
      dest = Bytes.new(capacity)
      ustatus = LibICU::UErrorCode::UZeroError
      size = LibICU.ucnv_convert(
        to_encoding, from_encoding,
        dest, capacity,
        source, source.size,
        pointerof(ustatus)
      )
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        capacity = size + 8
        next
      end
      ICU.check_error!(ustatus)
      return dest[0, size]
    end
  end
end

# __Converter Selector__
#
# Given a list of candidate converters, determines which ones can encode
# a particular string without data loss.
#
# __Usage__
# ```
# sel = ICU::ConverterSelector.new(["ISO-8859-1", "ISO-8859-2", "UTF-8"])
# sel.select_for("Hello") # => ["ISO-8859-1", "ISO-8859-2", "UTF-8"]
# sel.select_for("Héllo") # => ["ISO-8859-1", "UTF-8"]
# ```
#
# __See also__
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/ucnvsel_8h.html)
class ICU::ConverterSelector
  @ucnvsel : LibICU::UConverterSelector

  # Creates a selector that will test the given list of converter names.
  #
  # *converters* is an array of encoding names (canonical names or aliases).
  #
  # Raises `ICU::Error` if any converter name is unknown.
  #
  # ```
  # ICU::ConverterSelector.new(["UTF-8", "ISO-8859-1"])
  # ```
  def initialize(converters : Array(String))
    # Build a C-level array of null-terminated strings
    c_strings = converters.map(&.to_unsafe)
    ustatus = LibICU::UErrorCode::UZeroError
    @ucnvsel = LibICU.ucnvsel_open(
      c_strings,
      converters.size,
      nil.as(LibICU::USet),
      LibICU::UConverterUnicodeSet::RoundtripSet,
      pointerof(ustatus)
    )
    ICU.check_error!(ustatus)
  end

  def finalize
    @ucnvsel.try { |sel| LibICU.ucnvsel_close(sel) }
  end

  def to_unsafe
    @ucnvsel
  end

  # Returns the names of all converters (from the list passed at construction)
  # that can encode the given UTF-8 *text* without data loss.
  #
  # ```
  # sel = ICU::ConverterSelector.new(["ISO-8859-1", "ISO-8859-2", "UTF-8"])
  # sel.select_for("Hello") # => ["ISO-8859-1", "ISO-8859-2", "UTF-8"]
  # ```
  def select_for(text : String) : Array(String)
    ustatus = LibICU::UErrorCode::UZeroError
    uenum = LibICU.ucnvsel_select_for_utf8(
      @ucnvsel,
      text,
      text.bytesize,
      pointerof(ustatus)
    )
    ICU.check_error!(ustatus)
    ICU::UEnum.new(uenum, owns: true).to_a
  end
end
