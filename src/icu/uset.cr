# __Sets of Unicode Code Points and Strings__
#
# `ICU::USet` is a mutable set of Unicode code points (characters) and
# multi-character strings. It is used internally by ICU APIs such as
# `ICU::Collator` and `ICU::Transliterator`, and is exposed here as an
# `Enumerable(Char)` so that callers can work with ordinary Crystal types.
#
# Sets can be constructed from a character range, from a UnicodeSet pattern
# string (e.g. `"[\\p{L}]"`, `"[a-zA-Z0-9]"`), or built up programmatically
# via `#add` / `#add_range`.
#
# For simple inspection you can call `#to_set` to obtain a plain `Set(Char)`,
# or iterate directly with `#each`.
#
# __Usage__
# ```
# s = ICU::USet.new('a', 'z') # characters a–z
# s.includes?('m')            # => true
# s.size                      # => 26
# s.to_set                    # => Set{'a', 'b', ..., 'z'}
#
# vowels = ICU::USet.new("[aeiouAEIOU]")
# vowels.includes?('e') # => true
# ```
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/strings/unicodeset.html)
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/uset_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/uset_spec.cr)
class ICU::USet
  include Enumerable(Char)

  @uset : LibICU::USet
  @owns : Bool

  # Creates an empty set.
  #
  # ```
  # ICU::USet.new
  # ```
  def initialize
    @uset = LibICU.uset_open_empty
    @owns = true
  end

  # Creates a set containing all characters in the range *from*..*to* (inclusive).
  #
  # ```
  # ICU::USet.new('a', 'z').size # => 26
  # ```
  def initialize(from : Char, to : Char)
    @uset = LibICU.uset_open(from.ord, to.ord)
    @owns = true
  end

  # Creates a set from a [UnicodeSet pattern](https://unicode-org.github.io/icu/userguide/strings/unicodeset.html).
  #
  # Raises `ICU::Error` if the pattern is invalid.
  #
  # ```
  # ICU::USet.new("[\\p{Lu}]") # all uppercase letters
  # ICU::USet.new("[aeiou]")   # vowels
  # ```
  def initialize(pattern : String)
    pat = pattern.to_uchars
    ustatus = LibICU::UErrorCode::UZeroError
    @uset = LibICU.uset_open_pattern(pat, pat.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    @owns = true
  end

  # :nodoc: Wraps an existing raw USet handle. When *owns* is true the handle
  # will be closed in `#finalize`; otherwise it is the caller's responsibility.
  def initialize(raw : LibICU::USet, *, owns : Bool)
    @uset = raw
    @owns = owns
  end

  def finalize
    LibICU.uset_close(@uset) if @owns
  end

  def to_unsafe : LibICU::USet
    @uset
  end

  # Returns the number of characters (and strings) in this set.
  #
  # ```
  # ICU::USet.new('a', 'z').size # => 26
  # ```
  def size : Int32
    LibICU.uset_size(@uset)
  end

  # Returns `true` if the set contains no characters or strings.
  #
  # ```
  # ICU::USet.new.empty? # => true
  # ```
  def empty? : Bool
    LibICU.uset_is_empty(@uset) != 0
  end

  # Returns `true` if *char* is a member of this set.
  #
  # ```
  # ICU::USet.new('a', 'z').includes?('m') # => true
  # ICU::USet.new('a', 'z').includes?('M') # => false
  # ```
  def includes?(char : Char) : Bool
    LibICU.uset_contains(@uset, char.ord) != 0
  end

  # Returns `true` if *string* (as a multi-character string element) is in
  # this set.
  def includes?(string : String) : Bool
    uc = string.to_uchars
    LibICU.uset_contains_string(@uset, uc, uc.size) != 0
  end

  # Returns `true` if every character of *string* is individually in this set.
  #
  # ```
  # ICU::USet.new('a', 'z').includes_all_of?("hello") # => true
  # ICU::USet.new('a', 'z').includes_all_of?("Hello") # => false
  # ```
  def includes_all_of?(string : String) : Bool
    uc = string.to_uchars
    LibICU.uset_contains_all_code_points(@uset, uc, uc.size) != 0
  end

  # Adds *char* to this set.
  #
  # ```
  # s = ICU::USet.new
  # s.add('x')
  # s.includes?('x') # => true
  # ```
  def add(char : Char) : self
    LibICU.uset_add(@uset, char.ord)
    self
  end

  # Adds all characters in the range *from*..*to* (inclusive) to this set.
  #
  # ```
  # s = ICU::USet.new
  # s.add_range('a', 'f')
  # s.size # => 6
  # ```
  def add_range(from : Char, to : Char) : self
    LibICU.uset_add_range(@uset, from.ord, to.ord)
    self
  end

  # Adds a multi-character string element to this set.
  def add(string : String) : self
    uc = string.to_uchars
    LibICU.uset_add_string(@uset, uc, uc.size)
    self
  end

  # Adds all members of *other* to this set (union in place).
  #
  # ```
  # a = ICU::USet.new('a', 'c')
  # b = ICU::USet.new('d', 'f')
  # a.add_all(b).size # => 6
  # ```
  def add_all(other : USet) : self
    LibICU.uset_add_all(@uset, other.to_unsafe)
    self
  end

  # Removes *char* from this set.
  def remove(char : Char) : self
    LibICU.uset_remove(@uset, char.ord)
    self
  end

  # Removes all characters in the range *from*..*to* from this set.
  def remove_range(from : Char, to : Char) : self
    LibICU.uset_remove_range(@uset, from.ord, to.ord)
    self
  end

  # Removes all members of *other* from this set (set difference in place).
  def remove_all(other : USet) : self
    LibICU.uset_remove_all(@uset, other.to_unsafe)
    self
  end

  # Retains only the members of *other* (intersection in place).
  #
  # ```
  # a = ICU::USet.new('a', 'f')
  # b = ICU::USet.new('d', 'z')
  # a.retain_all(b).to_set # => Set{'d', 'e', 'f'}
  # ```
  def retain_all(other : USet) : self
    LibICU.uset_retain_all(@uset, other.to_unsafe)
    self
  end

  # Removes all members, leaving an empty set.
  def clear : self
    LibICU.uset_clear(@uset)
    self
  end

  # Complements this set: every character previously absent is added, and
  # every character previously present is removed.
  def complement : self
    LibICU.uset_complement(@uset)
    self
  end

  # Returns `true` if this set and *other* have no characters in common.
  def disjoint?(other : USet) : Bool
    LibICU.uset_contains_none(@uset, other.to_unsafe) != 0
  end

  # Returns `true` if this set and *other* have at least one character in common.
  def intersects?(other : USet) : Bool
    LibICU.uset_contains_some(@uset, other.to_unsafe) != 0
  end

  # Returns `true` if every member of *other* is also in this set.
  def superset?(other : USet) : Bool
    LibICU.uset_contains_all(@uset, other.to_unsafe) != 0
  end

  # Returns the UnicodeSet pattern string representing this set.
  #
  # ```
  # ICU::USet.new('a', 'c').to_pattern # => "[a-c]"
  # ```
  def to_pattern(escape_unprintable : Bool = false) : String
    ICU.with_auto_resizing_buffer(32, UChars) do |buff, status_ptr|
      LibICU.uset_to_pattern(@uset, buff.as(UChars), buff.size,
        escape_unprintable ? 1 : 0, status_ptr)
    end
  end

  # Yields each character in this set (string elements are skipped).
  #
  # ```
  # ICU::USet.new('a', 'c').each { |c| print c } # => abc
  # ```
  def each(& : Char ->) : Nil
    count = LibICU.uset_get_item_count(@uset)
    # Scratch buffer for multi-character string items; we just need it to be
    # large enough to avoid U_BUFFER_OVERFLOW_ERROR on typical strings.
    str_buf = UChars.new(32)
    count.times do |i|
      start_cp = 0i32
      end_cp = 0i32
      ustatus = LibICU::UErrorCode::UZeroError
      len = LibICU.uset_get_item(@uset, i,
        pointerof(start_cp), pointerof(end_cp),
        str_buf, str_buf.size, pointerof(ustatus))
      ICU.check_error!(ustatus)
      if len == 0
        # codepoint range [start_cp, end_cp]
        start_cp.upto(end_cp) { |cp| yield cp.chr }
      end
      # len > 0 means a multi-character string element — skipped in Char iteration
    end
  end

  # Returns a Crystal `Set(Char)` with all characters from this set.
  # Multi-character string elements are omitted.
  #
  # ```
  # ICU::USet.new('a', 'c').to_set # => Set{'a', 'b', 'c'}
  # ```
  def to_set : Set(Char)
    Set(Char).new.tap { |s| each { |c| s << c } }
  end
end
