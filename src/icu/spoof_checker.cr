# __Identifier Spoofing & Confusability__
#
# `ICU::SpoofChecker` detects whether identifiers (usernames, domain names,
# source code symbols, etc.) are visually confusable with one another, or
# contain characters that could be used in spoofing attacks.
#
# Two strings are *confusable* if a casual observer might mistake one for the
# other (e.g. the Cyrillic "а" vs the Latin "a"). The checker can also
# validate that an identifier is *safe* — drawn from a single script, using
# only recommended characters, etc.
#
# __Usage__
# ```
# sc = ICU::SpoofChecker.new
#
# sc.confusable?("paypal", "рaypal") # => true  (Cyrillic "р")
# sc.safe?("hello")                  # => true
# sc.safe?("ℋello")                  # => false  (mixed script)
#
# sc.skeleton("рaypal") == sc.skeleton("paypal") # => true
# ```
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/transforms/spoof.html)
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/uspoof_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/spoof_checker_spec.cr)
class ICU::SpoofChecker
  alias RestrictionLevel = LibICU::URestrictionLevel
  alias Direction = LibICU::UBiDiDirection

  # FIXME: should be present in LibICU (not parsed by Libgen)
  #
  # Bitmask flags controlling which spoof checks are performed.
  # Corresponds to ICU's `USpoofChecks` enum.
  # Multiple flags can be combined with `|`.
  @[Flags]
  enum Check : Int32
    # Check that a string is not confusable with another based on a single
    # script (e.g. all-Latin lookalikes).
    SingleScriptConfusable = 1
    # Check that a string is not confusable when comparing across scripts.
    MixedScriptConfusable = 2
    # Check that a string is not whole-script confusable with another.
    WholeScriptConfusable = 4
    # All three confusability checks combined.
    Confusable = 7
    # Apply confusability checks regardless of case.
    AnyCase = 8
    # Check that the string conforms to the configured `restriction_level`.
    RestrictionLevel = 16
    # Deprecated alias for `RestrictionLevel`.
    SingleScript = 16
    # Check for invisible characters (zero-width, etc.).
    Invisible = 32
    # Check that all characters are in the allowed character set.
    CharLimit = 64
    # Check that all numeric characters are from the same decimal system.
    MixedNumbers = 128
    # Check for hidden overlay confusables (BiDi-related).
    HiddenOverlay = 256
    # Enable all checks.
    AllChecks = 0xFFFF
    # Return auxiliary information about the check result.
    AuxInfo = 0x40000000
  end

  # Holds the detailed outcome of a `#check` call.
  #
  # ```
  # result = ICU::SpoofChecker::CheckResult.new
  # sc.check("hello", result)
  # result.restriction_level # => ICU::SpoofChecker::RestrictionLevel::Ascii
  # ```
  class CheckResult
    @res : LibICU::USpoofCheckResult

    def initialize
      ustatus = LibICU::UErrorCode::UZeroError
      @res = LibICU.uspoof_open_check_result(pointerof(ustatus))
      ICU.check_error!(ustatus)
    end

    def finalize
      @res.try { |res| LibICU.uspoof_close_check_result(res) }
    end

    def to_unsafe : LibICU::USpoofCheckResult
      @res
    end

    # Returns the bitmask of failed checks from the last `SpoofChecker#check` call.
    def checks : Int32
      ustatus = LibICU::UErrorCode::UZeroError
      ret = LibICU.uspoof_get_check_result_checks(@res, pointerof(ustatus))
      ICU.check_error!(ustatus)
      ret
    end

    # Returns the restriction level of the identifier from the last `SpoofChecker#check` call.
    def restriction_level : RestrictionLevel
      ustatus = LibICU::UErrorCode::UZeroError
      ret = LibICU.uspoof_get_check_result_restriction_level(@res, pointerof(ustatus))
      ICU.check_error!(ustatus)
      ret
    end

    # Returns the set of numerics from different decimal systems found in the
    # identifier from the last `SpoofChecker#check` call.
    #
    # The returned `USet` is borrowed (not owned); do not hold onto it beyond
    # the lifetime of this `CheckResult`.
    def numerics : Set(Char)
      ustatus = LibICU::UErrorCode::UZeroError
      raw = LibICU.uspoof_get_check_result_numerics(@res, pointerof(ustatus))
      ICU.check_error!(ustatus)
      USet.new(raw, owns: false).to_set
    end
  end

  @sc : LibICU::USpoofChecker

  def initialize
    ustatus = LibICU::UErrorCode::UZeroError
    @sc = LibICU.uspoof_open(pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def finalize
    @sc.try { |sc| LibICU.uspoof_close(sc) }
  end

  def to_unsafe : LibICU::USpoofChecker
    @sc
  end

  # Returns the bitmask of checks currently enabled on this checker.
  def checks : Int32
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.uspoof_get_checks(@sc, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret
  end

  # Sets the checks to perform. Pass a combination of `Check` flags.
  #
  # ```
  # sc.checks = ICU::SpoofChecker::Check::Invisible | ICU::SpoofChecker::Check::MixedNumbers
  # ```
  def checks=(value : Int32)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.uspoof_set_checks(@sc, value, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  # Returns the restriction level currently configured on this checker.
  def restriction_level : RestrictionLevel
    LibICU.uspoof_get_restriction_level(@sc)
  end

  # Sets the restriction level.
  #
  # ```
  # sc.restriction_level = ICU::SpoofChecker::RestrictionLevel::HighlyRestrictive
  # ```
  def restriction_level=(level : RestrictionLevel)
    LibICU.uspoof_set_restriction_level(@sc, level)
    self
  end

  # Returns the comma-separated list of allowed locales, or an empty string if
  # no locale restriction is set.
  def allowed_locales : String
    ustatus = LibICU::UErrorCode::UZeroError
    ptr = LibICU.uspoof_get_allowed_locales(@sc, pointerof(ustatus))
    ICU.check_error!(ustatus)
    String.new(ptr)
  end

  # Restricts the set of allowed characters to those belonging to the given
  # comma-separated list of locale script(s).
  #
  # ```
  # sc.allowed_locales = "en, fr"
  # ```
  def allowed_locales=(locales : String)
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.uspoof_set_allowed_locales(@sc, locales, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  # Runs all enabled spoof checks on *text* and returns the bitmask of failed
  # checks (0 means the text passed all checks).
  #
  # ```
  # sc.check("hello") # => 0
  # sc.check("ℋello") # => non-zero
  # ```
  def check(text : String) : Int32
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.uspoof_check2_utf8(@sc, text, text.bytesize, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret
  end

  # Runs all enabled spoof checks on *text*, populating *result* with detailed
  # information, and returns the bitmask of failed checks.
  #
  # ```
  # result = ICU::SpoofChecker::CheckResult.new
  # sc.check("hello", result)
  # result.restriction_level # => ICU::SpoofChecker::RestrictionLevel::Ascii
  # ```
  def check(text : String, result : CheckResult) : Int32
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.uspoof_check2_utf8(@sc, text, text.bytesize, result.to_unsafe, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret
  end

  # Returns `true` if *text* passes all enabled spoof checks.
  #
  # ```
  # sc.safe?("hello") # => true
  # sc.safe?("ℋello") # => false
  # ```
  def safe?(text : String) : Bool
    check(text) == 0
  end

  # Returns `true` if *s1* and *s2* are visually confusable with one another.
  #
  # ```
  # sc.confusable?("paypal", "рaypal") # => true  (Cyrillic "р")
  # sc.confusable?("hello", "world")   # => false
  # ```
  def confusable?(s1 : String, s2 : String) : Bool
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.uspoof_are_confusable_utf8(@sc, s1, s1.bytesize, s2, s2.bytesize, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret != 0
  end

  # Returns `true` if *s1* and *s2* are BiDi-confusable in the given *direction*.
  def bidi_confusable?(s1 : String, s2 : String, direction : Direction) : Bool
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.uspoof_are_bidi_confusable_utf8(@sc, direction, s1, s1.bytesize, s2, s2.bytesize, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret != 0
  end

  # Returns the *skeleton* of *text* — a canonicalized form used to detect
  # confusable pairs. Two strings are confusable if and only if their skeletons
  # are equal.
  #
  # ```
  # sc.skeleton("рaypal") == sc.skeleton("paypal") # => true
  # ```
  def skeleton(text : String) : String
    ICU.with_auto_resizing_buffer(text.bytesize + 8, Bytes) do |buf, status_ptr|
      LibICU.uspoof_get_skeleton_utf8(@sc, 0_u32, text, text.bytesize,
        buf.as(Bytes).to_unsafe.as(LibC::Char*), buf.as(Bytes).size, status_ptr)
    end
  end

  # Returns the BiDi skeleton of *text* for the given *direction*.
  def bidi_skeleton(text : String, direction : Direction) : String
    ICU.with_auto_resizing_buffer(text.bytesize + 8, Bytes) do |buf, status_ptr|
      LibICU.uspoof_get_bidi_skeleton_utf8(@sc, direction, text, text.bytesize,
        buf.as(Bytes).to_unsafe.as(LibC::Char*), buf.as(Bytes).size, status_ptr)
    end
  end

  # Returns the *inclusion set*: the set of characters that are explicitly
  # allowed to appear in identifiers regardless of other restrictions.
  #
  # The returned set is not owned by this checker.
  def self.inclusion_set : Set(Char)
    ustatus = LibICU::UErrorCode::UZeroError
    raw = LibICU.uspoof_get_inclusion_set(pointerof(ustatus))
    ICU.check_error!(ustatus)
    USet.new(raw, owns: false).to_set
  end

  # Returns the *recommended set*: the set of characters recommended by
  # [Unicode TR#39](https://www.unicode.org/reports/tr39/) for use in
  # identifiers.
  #
  # The returned set is not owned by this checker.
  def self.recommended_set : Set(Char)
    ustatus = LibICU::UErrorCode::UZeroError
    raw = LibICU.uspoof_get_recommended_set(pointerof(ustatus))
    ICU.check_error!(ustatus)
    USet.new(raw, owns: false).to_set
  end
end
