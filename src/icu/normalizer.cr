# __Normalization__
#
# Unicode normalization functionality for standard Unicode normalization.
#
# __Usage__
# ```
# str = "À"
# str.bytes # => [65, 204, 128]
# norm = ICU::Normalizer::NFC.new
# norm.normalized?(str)       # => false
# norm.normalized_quick?(str) # => Maybe
# norm.normalize(str).bytes   # => [195, 128]
# ```
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/transforms/normalization/n)
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/unorm2_8h.html)
# - [unit tests](https://github.com/olbat/icu.cr/blob/master/spec/normalizer_spec.cr)
class ICU::Normalizer
  alias Mode = LibICU::UNormalization2Mode
  alias CheckResult = LibICU::UNormalizationCheckResult
  alias Type = NamedTuple(name: String, mode: Mode)

  TYPES = {
    NFC:    {name: "nfc", mode: Mode::Compose},
    NFD:    {name: "nfc", mode: Mode::Decompose},
    NFKC:   {name: "nfkc", mode: Mode::Compose},
    NFKD:   {name: "nfkc", mode: Mode::Decompose},
    NFKCCF: {name: "nfkc_cf", mode: Mode::Compose},
  }

  @unorm : LibICU::UNormalizer2
  @type : Type

  # Create a new normalizer that will use the specified [mode](http://www.unicode.org/unicode/reports/tr15/) (NFC, NFD, NFKC, NFKD, NFKCCF)
  def initialize(type : Symbol)
    if t = TYPES[type]?
      @type = t
    else
      raise ICU::Error.new("unknown type #{type}")
    end

    ustatus = LibICU::UErrorCode::UZeroError
    @unorm = LibICU.unorm2_get_instance(nil, @type[:name], @type[:mode], pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def finalize
    # nothing since singleton instances retrieved from unorm2_getInstance does not have to be freed
  end

  # Normalize some text
  #
  # ```
  # str = "À"
  # str.bytes                                   # => [65, 204, 128]
  # ICU::Normalizer::NFC.new.normalize(str).bytes # => [195, 128]
  # ```
  def normalize(text : String) : String
    # allocate twice the size of the source string to be sure
    src = text.to_uchars
    dest = ICU::UChars.new(text.size * 2)
    size = limit = text.size

    ustatus = LibICU::UErrorCode::UZeroError
    size = LibICU.unorm2_normalize(@unorm, src, text.size, dest, dest.size, pointerof(ustatus))
    ICU.check_error!(ustatus)

    dest.to_s(size)
  end

  # Tests if the string is normalized
  #
  # ```
  # ICU::Normalizer::NFC.new.normalized?("À") # => false
  # ```
  #
  # (see also: `#normalized_quick?`)
  def normalized?(text : String) : Bool
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.unorm2_is_normalized(@unorm, text.to_uchars, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret != 0
  end

  # Tests if the string is normalized (faster but less accurate than `#normalized?`
  #
  # ```
  # ICU::Normalizer::NFC.new.normalized_quick?("À") # => Maybe
  # ```
  def normalized_quick?(text : String) : CheckResult
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.unorm2_quick_check(@unorm, text.to_uchars, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret.as(CheckResult)
  end

  # Tests if the character is normalization-inert
  #
  # ```
  # norm = ICU::Normalizer::NFC.new
  # norm.inert?("À") # => false
  # norm.inert?("A") # => true
  # ```
  def inert?(chr : Char) : Bool
    LibICU.unorm2_is_inert(@unorm, chr.to_uchar) != 0
  end

  # Gets the decomposition mapping of a character
  #
  # ```
  # ICU::Normalizer::NFC.new.decomposition("À") # => [65, 204, 128]
  # ```
  def decomposition(chr : Char) : String
    dec = ICU::UChars.new(8)

    ustatus = LibICU::UErrorCode::UZeroError
    size = LibICU.unorm2_get_decomposition(@unorm, chr.to_uchar, dec, dec.size, pointerof(ustatus))
    ICU.check_error!(ustatus)

    dec.to_s(size)
  end
end

# NFC Normalizer (see `ICU::Normalizer`)
class ICU::Normalizer::NFC < ICU::Normalizer
  def initialize
    super(:NFC)
  end
end

# NFD Normalizer (see `ICU::Normalizer`)
class ICU::Normalizer::NFD < ICU::Normalizer
  def initialize
    super(:NFD)
  end
end

# NFKC Normalizer (see `ICU::Normalizer`)
class ICU::Normalizer::NFKC < ICU::Normalizer
  def initialize
    super(:NFKC)
  end
end

# NFKD Normalizer (see `ICU::Normalizer`)
class ICU::Normalizer::NFKD < ICU::Normalizer
  def initialize
    super(:NFKD)
  end
end

# NFKCC Normalizer (see `ICU::Normalizer`)
class ICU::Normalizer::NFKCCF < ICU::Normalizer
  def initialize
    super(:NFKCCF)
  end
end
