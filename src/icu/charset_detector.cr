# __Charset detection__
#
# This class provides a facility for detecting the
# charset or encoding of character data in an unknown text format.
#
# __Usage__
# ```
# csdet = ICU::CharsetDetector.new
# csm = csdet.detect("Sôme text")
# csm.name       # => "UTF-8"
# csm.confidence # => 80
# ```
#
# __See also__
# - [reference implementation](http://icu-project.org/apiref/icu4c/ucsdet_8h.html)
# - [user guide](http://userguide.icu-project.org/conversion/detection)
# - [unit tests](https://github.com/olbat/icu.cr/blob/master/spec/charset_detector_spec.cr)
class ICU::CharsetDetector
  class CharsetMatch
    getter name : String
    getter language : String
    getter confidence : Int32

    def initialize(csmatch : LibICU::UCharsetMatch)
      ustatus = LibICU::UErrorCode::UZeroError
      name = LibICU.ucsdet_get_name(csmatch, pointerof(ustatus))
      ICU.check_error!(ustatus)
      @name = String.new(name)

      ustatus = LibICU::UErrorCode::UZeroError
      language = LibICU.ucsdet_get_language(csmatch, pointerof(ustatus))
      ICU.check_error!(ustatus)
      @language = String.new(language)

      ustatus = LibICU::UErrorCode::UZeroError
      @confidence = LibICU.ucsdet_get_confidence(csmatch, pointerof(ustatus))
      ICU.check_error!(ustatus)
    end
  end

  @csdet : LibICU::UCharsetDetector
  @@detectable_charsets : Array(String)?

  def initialize
    ustatus = LibICU::UErrorCode::UZeroError
    @csdet = LibICU.ucsdet_open(pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def finalize
    @csdet.try { |csdet| LibICU.ucsdet_close(csdet) }
  end

  def to_unsafe
    @csdet
  end

  # Return the charset that best matches the supplied input data
  #
  # ```
  # csdet = ICU::CharsetDetector.new
  #
  # csm = csdet.detect("Some text")
  # csm.name       # => "ISO-8859-1"
  # csm.confidence # => 30
  #
  # csm = csdet.detect("Sôme other text")
  # csm.name       # => "UTF-8"
  # csm.confidence # => 80
  # ```
  #
  # FIXME: not thread-safe
  def detect(text : String) : CharsetMatch
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.ucsdet_set_text(@csdet, text, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)

    ustatus = LibICU::UErrorCode::UZeroError
    ucsmatch = LibICU.ucsdet_detect(@csdet, pointerof(ustatus))
    ICU.check_error!(ustatus)

    CharsetMatch.new(ucsmatch.not_nil!)
  end

  # Find all charset matches that appear to be consistent with the input.
  # The results are ordered with the best quality match first.
  #
  # ```
  # csms = csdet.detect_all("Some text")
  # csdet.detect_all(str).map { |csm| {name: csm.name, confidence: csm.confidence} }
  # # => [{name: "ISO-8859-1", confidence: 30},
  # #     {name: "ISO-8859-2", confidence: 30},
  # #     {name: "UTF-8", confidence: 15},
  # #     {name: "UTF-16BE", confidence: 10},
  # #     {name: "UTF-16LE", confidence: 10}]
  # ```
  #
  # FIXME: not thread-safe
  def detect_all(text : String) : Array(CharsetMatch)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.ucsdet_set_text(@csdet, text, text.size, pointerof(ustatus))
    ICU.check_error!(ustatus)

    ustatus = LibICU::UErrorCode::UZeroError
    ucsmatchs = LibICU.ucsdet_detect_all(@csdet, out num, pointerof(ustatus))
    ICU.check_error!(ustatus)

    Slice(LibICU::UCharsetMatch).new(ucsmatchs, num).map do |ucsmatch|
      CharsetMatch.new(ucsmatch.not_nil!)
    end.to_a
  end

  # Returns the list of detectable charsets
  #
  # ```
  # ICU::CharsetDetector.new.detectable_charsets
  # # => ["UTF-8",
  # #     "UTF-16BE",
  # #     "UTF-16LE",
  # #     ...]
  # ```
  def detectable_charsets : Array(String)
    unless @@detectable_charsets
      ustatus = LibICU::UErrorCode::UZeroError
      uenum = LibICU.ucsdet_get_all_detectable_charsets(@csdet, pointerof(ustatus))
      ICU.check_error!(ustatus)
      @@detectable_charsets = UEnum.new(uenum).to_a
      LibICU.uenum_close(uenum)
    end
    @@detectable_charsets.not_nil!
  end

  # Returns the list of detectable charsets
  #
  # (see `ICU::CharsetDetector#detectable_charsets`)
  def self.detectable_charsets : Array(String)
    @@detectable_charsets ||= new.detectable_charsets
  end
end
