# __Regular Expressions__
#
# Unicode-aware regular expression matching and replacement.
#
# Patterns follow the [ICU Regular Expression](https://unicode-org.github.io/icu/userguide/strings/regexp.html)
# syntax, which is largely compatible with Perl 5 regular expressions.
#
# __Usage__
# ```
# re = ICU::Regex.new("(\\w+)@(\\w+\\.\\w+)")
# m = re.match("Contact: user@example.com")
# m          # => "user@example.com"
# m.group(1) # => "user"
# m.group(2) # => "example.com"
#
# re.scan("a1 b2 c3") { |m| puts m.group(0) }
#
# ICU::Regex.new("\\d+").replace_all("foo 42 bar 7", "N") # => "foo N bar N"
# ```
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/strings/regexp.html)
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/uregex_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/regex_spec.cr)
class ICU::Regex
  # Flags that modify regular expression matching behavior.
  # Multiple flags can be combined with `|`.
  @[Flags]
  enum Flag : UInt32
    # Case-insensitive matching.
    CaseInsensitive = 2
    # Allow `.` to match line terminators.
    DotAll = 32
    # Enables multiline mode: `^` and `$` match at line boundaries.
    Multiline = 8
    # Verbose/comments mode: whitespace and `#` comments are ignored in patterns.
    Comments = 4
    # Use Unix-only line endings for `^`, `$`, and `.`.
    UnixLines = 1
    # Set `^` and `$` to match at line boundaries (same as Multiline for ICU).
    UnicodeWord = 256
    # Enable error checking when searching for a matching pattern in a string.
    ErrorOnUnknownEscapes = 512
  end

  # Represents a single match result, including captured groups.
  class Match
    @regexp : LibICU::URegularExpression
    @group_count : Int32

    # :nodoc:
    def initialize(@regexp : LibICU::URegularExpression)
      ustatus = LibICU::UErrorCode::UZeroError
      @group_count = LibICU.uregex_group_count(@regexp, pointerof(ustatus))
      ICU.check_error!(ustatus)
    end

    # Returns the text of the given capture group (0 = whole match).
    #
    # Returns `nil` if the group did not participate in the match.
    #
    # ```
    # m = ICU::Regex.new("(\\w+)").match("hello")
    # m.group(0) # => "hello"
    # m.group(1) # => "hello"
    # ```
    def group(n : Int32) : String?
      ICU.with_auto_resizing_buffer(64, UChars) do |buff, status_ptr|
        LibICU.uregex_group(@regexp, n, buff.as(UChars), buff.size, status_ptr)
      end
    rescue ICU::Error
      nil
    end

    # Returns the text of the given named capture group.
    #
    # Returns `nil` if the group did not participate in the match.
    #
    # ```
    # m = ICU::Regex.new("(?<word>\\w+)").match("hello")
    # m.group("word") # => "hello"
    # ```
    def group(name : String) : String?
      ustatus = LibICU::UErrorCode::UZeroError
      n = LibICU.uregex_group_number_from_c_name(@regexp, name, name.size, pointerof(ustatus))
      ICU.check_error!(ustatus)
      group(n)
    end

    # Returns the byte offset in the input text where the given group begins.
    def begin(n : Int32 = 0) : Int32
      ustatus = LibICU::UErrorCode::UZeroError
      ret = LibICU.uregex_start(@regexp, n, pointerof(ustatus))
      ICU.check_error!(ustatus)
      ret
    end

    # Returns the byte offset in the input text just past where the given group ends.
    def end(n : Int32 = 0) : Int32
      ustatus = LibICU::UErrorCode::UZeroError
      ret = LibICU.uregex_end(@regexp, n, pointerof(ustatus))
      ICU.check_error!(ustatus)
      ret
    end

    # Returns the match range of the given group as a `Range`.
    #
    # ```
    # m = ICU::Regex.new("\\w+").match("hello world")
    # m.range # => 0...5
    # ```
    def range(n : Int32 = 0) : Range(Int32, Int32)
      self.begin(n)...self.end(n)
    end

    # Returns the whole match text (group 0).
    def to_s : String
      group(0) || ""
    end

    # Returns the number of capture groups in the pattern.
    def group_count : Int32
      @group_count
    end
  end

  @uregex : LibICU::URegularExpression
  @pattern : String
  @flags : Flag

  # Creates a new Regex from the given pattern string.
  #
  # Raises `ICU::Error` if the pattern is invalid.
  #
  # ```
  # ICU::Regex.new("\\d+")
  # ICU::Regex.new("hello", ICU::Regex::Flag::CaseInsensitive)
  # ```
  def initialize(@pattern : String, @flags : Flag = Flag::None)
    pat = pattern.to_uchars
    ustatus = LibICU::UErrorCode::UZeroError
    @uregex = LibICU.uregex_open(pat, pat.size, flags.to_u32, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def finalize
    @uregex.try { |re| LibICU.uregex_close(re) }
  end

  def to_unsafe
    @uregex
  end

  # Returns the pattern string used to create this regex.
  def pattern : String
    @pattern
  end

  # Returns the flags used to create this regex.
  def flags : Flag
    @flags
  end

  # Sets the input text to search.
  #
  # Resets the match position to the beginning of the text.
  def text=(text : String)
    uchars = text.to_uchars
    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.uregex_set_text(@uregex, uchars, uchars.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  # Returns the input text currently set on the regex.
  def text : String
    ustatus = LibICU::UErrorCode::UZeroError
    ptr = LibICU.uregex_get_text(@uregex, out size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    UChars.new(ptr, size).to_s
  end

  # Returns whether the entire input text (as set via `#text=`) matches the pattern.
  #
  # ```
  # re = ICU::Regex.new("\\d+")
  # re.text = "42"
  # re.matches? # => true
  # re.text = "abc"
  # re.matches? # => false
  # ```
  def matches? : Bool
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.uregex_matches(@uregex, 0, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret != 0
  end

  # Returns whether the pattern matches the given string in its entirety.
  #
  # ```
  # ICU::Regex.new("\\d+").matches?("42")   # => true
  # ICU::Regex.new("\\d+").matches?("42px") # => false
  # ```
  def matches?(text : String) : Bool
    self.text = text
    matches?
  end

  # Attempts to match the pattern anywhere within the given string,
  # returning a `Match` on success or `nil` if there is no match.
  #
  # ```
  # m = ICU::Regex.new("\\d+").match("foo 42")
  # m       # => "42"
  # m.range # => 4...6
  # ```
  def match(text : String) : Match?
    self.text = text
    ustatus = LibICU::UErrorCode::UZeroError
    found = LibICU.uregex_find(@uregex, 0, pointerof(ustatus))
    ICU.check_error!(ustatus)
    Match.new(@uregex) if found != 0
  end

  # Yields each non-overlapping match of the pattern in *text* as a `Match`.
  #
  # ```
  # ICU::Regex.new("\\d+").scan("a1 b22 c3") do |m|
  #   puts m.group(0)
  # end
  # # Output:
  # # 1
  # # 22
  # # 3
  # ```
  def scan(text : String) : Nil
    self.text = text
    ustatus = LibICU::UErrorCode::UZeroError
    found = LibICU.uregex_find(@uregex, 0, pointerof(ustatus))
    ICU.check_error!(ustatus)

    while found != 0
      yield Match.new(@uregex)
      ustatus = LibICU::UErrorCode::UZeroError
      found = LibICU.uregex_find_next(@uregex, pointerof(ustatus))
      ICU.check_error!(ustatus)
    end
  end

  # Returns an array of all non-overlapping matches of the pattern in *text*.
  #
  # ```
  # ICU::Regex.new("\\d+").scan("a1 b22 c3") # => ["1", "22", "3"]
  # ```
  def scan(text : String) : Array(String)
    results = [] of String
    scan(text) { |m| results << (m.group(0) || "") }
    results
  end

  # Splits *text* around matches of this pattern, returning the pieces.
  #
  # ```
  # ICU::Regex.new("\\s+").split("foo  bar baz") # => ["foo", "bar", "baz"]
  # ```
  def split(text : String) : Array(String)
    result = [] of String
    prev = 0
    self.text = text
    ustatus = LibICU::UErrorCode::UZeroError
    found = LibICU.uregex_find(@uregex, 0, pointerof(ustatus))
    ICU.check_error!(ustatus)

    while found != 0
      ustatus = LibICU::UErrorCode::UZeroError
      start = LibICU.uregex_start(@uregex, 0, pointerof(ustatus))
      ICU.check_error!(ustatus)
      ustatus = LibICU::UErrorCode::UZeroError
      finish = LibICU.uregex_end(@uregex, 0, pointerof(ustatus))
      ICU.check_error!(ustatus)

      result << text[prev, start - prev]
      prev = finish

      ustatus = LibICU::UErrorCode::UZeroError
      found = LibICU.uregex_find_next(@uregex, pointerof(ustatus))
      ICU.check_error!(ustatus)
    end

    result << text[prev..]
    result
  end

  # Replaces the first match of this pattern in *text* with *replacement*.
  #
  # The replacement string may contain `$0`, `$1`, etc. to refer to matched groups.
  #
  # ```
  # ICU::Regex.new("\\d+").replace_first("foo 42 bar 7", "N") # => "foo N bar 7"
  # ```
  def replace_first(text : String, replacement : String) : String
    self.text = text
    repl = replacement.to_uchars
    ICU.with_auto_resizing_buffer(text.size * 2, UChars) do |buff, status_ptr|
      LibICU.uregex_replace_first(@uregex, repl, repl.size, buff.as(UChars), buff.size, status_ptr)
    end
  end

  # Replaces all non-overlapping matches of this pattern in *text* with *replacement*.
  #
  # The replacement string may contain `$0`, `$1`, etc. to refer to matched groups.
  #
  # ```
  # ICU::Regex.new("\\d+").replace_all("foo 42 bar 7", "N") # => "foo N bar N"
  # ```
  def replace_all(text : String, replacement : String) : String
    self.text = text
    repl = replacement.to_uchars
    ICU.with_auto_resizing_buffer(text.size * 2, UChars) do |buff, status_ptr|
      LibICU.uregex_replace_all(@uregex, repl, repl.size, buff.as(UChars), buff.size, status_ptr)
    end
  end
end
