# Normalization
#
# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/unorm2_8h.html)
# - [user guide](http://userguide.icu-project.org/transforms/normalization)
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

  def initialize(type : Symbol)
    unless @type = TYPES[type]
      raise ICU::Error.new("unknown type #{type}")
    end

    ustatus = LibICU::UErrorCode::UZeroError
    @unorm = LibICU.unorm2_get_instance(nil, @type[:name], @type[:mode], pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def finalize
    # nothing since singleton instances retrieved from unorm2_getInstance does not have to be freed
  end

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

  def normalized?(text : String) : Bool
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.unorm2_is_normalized(@unorm, text.to_uchars, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret != 0
  end

  def normalized_quick?(text : String) : CheckResult
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.unorm2_quick_check(@unorm, text.to_uchars, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret.as(CheckResult)
  end

  def inert?(chr : Char) : Bool
    LibICU.unorm2_is_inert(@unorm, chr.to_uchar) != 0
  end

  def decomposition(chr : Char) : String
    dec = ICU::UChars.new(8)

    ustatus = LibICU::UErrorCode::UZeroError
    size = LibICU.unorm2_get_decomposition(@unorm, chr.to_uchar, dec, dec.size, pointerof(ustatus))
    ICU.check_error!(ustatus)

    dec.to_s(size)
  end
end

class ICU::NFCNormalizer < ICU::Normalizer
  def initialize
    super(:NFC)
  end
end

class ICU::NFDNormalizer < ICU::Normalizer
  def initialize
    super(:NFD)
  end
end

class ICU::NFKCNormalizer < ICU::Normalizer
  def initialize
    super(:NFKC)
  end
end

class ICU::NFKDNormalizer < ICU::Normalizer
  def initialize
    super(:NFKD)
  end
end

class ICU::NFKCCFNormalizer < ICU::Normalizer
  def initialize
    super(:NFKCCF)
  end
end
