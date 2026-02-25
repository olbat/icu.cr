# __Bidirectional Algorithm__
#
# This class provides a wrapper around ICU's Bidirectional Algorithm (BiDi)
# implementation. It is used to reorder text that contains a mix of
# left-to-right (LTR) and right-to-left (RTL) characters according to the
# Unicode Bidirectional Algorithm.
#
# _Disclaimer_: this binding wrapper has been automatically generated via GenAI
#
# __Usage__
# ```
# # Example with mixed LTR and RTL text
# text = "hello \u0627\u0644\u0639\u0631\u0628\u064A\u0629 world" # "hello العربية world"
#
# # Create a BiDi object and set the text
# bidi = ICU::BiDi.new
# bidi.set_text(text)
#
# # Get the visual reordering
# reordered_text = bidi.write_reordered
# puts reordered_text # Output depends on terminal/environment BiDi support
#
# # Get the base direction (static method)
# puts ICU::BiDi.base_direction(text) # => ICU::BiDi::Direction::Mixed
#
# # Get the number of runs (segments of consistent direction)
# puts bidi.run_count # => e.g., 3 (LTR, RTL, LTR)
#
# # Iterate through visual runs
# runs = bidi.visual_runs
# runs.each_with_index do |run, i|
#   puts "Run #{i}: Logical Start=#{run.logical_start}, Length=#{run.length}, Direction=#{run.direction}"
# end
#
# # Get logical index from visual index
# logical_idx = bidi.logical_index(visual_idx: 10)
# puts "Logical index for visual index 10: #{logical_idx}"
# ```
#
# __See also__
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/ubidi_8h.html)
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/transforms/bidi.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/bidi_spec.cr)
class ICU::BiDi
  # Represents the directionality of text (LTR, RTL, Mixed, Neutral).
  # Corresponds to ICU's `UBiDiDirection`.
  alias Direction = LibICU::UBiDiDirection

  # Represents a BiDi embedding level (0-125). Even levels are LTR, odd levels are RTL.
  # Corresponds to ICU's `UBiDiLevel`.
  alias Level = LibICU::UBiDiLevel

  # Specifies different modes for the BiDi algorithm (e.g., default, inverse, grouping).
  # Corresponds to ICU's `UBiDiReorderingMode`.
  alias ReorderingMode = LibICU::UBiDiReorderingMode

  # Constants for paragraph level setting used in `set_text`.
  # `DEFAULT_LTR`: Use LTR if no strong character, otherwise auto-detect.
  DEFAULT_LTR = 0xfe.to_u8 # LibICU::UBIDI_DEFAULT_LTR
  # `DEFAULT_RTL`: Use RTL if no strong character, otherwise auto-detect.
  DEFAULT_RTL = 0xff.to_u8 # LibICU::UBIDI_DEFAULT_RTL

  # Maximum explicit embedding level allowed (125).
  MAX_EXPLICIT_LEVEL = 125.to_u8 # LibICU::UBIDI_MAX_EXPLICIT_LEVEL

  # Bit flag used with `embedding_levels` in `set_text` to override default directional properties.
  LEVEL_OVERRIDE = 0x80.to_u8 # LibICU::UBIDI_LEVEL_OVERRIDE

  # Special value returned by `logical_index` or `visual_index` when a mapping doesn't exist
  # (e.g., for removed controls or inserted marks).
  MAP_NOWHERE = -1.to_i32 # LibICU::UBIDI_MAP_NOWHERE

  # Options for `reordering_options=`. Affects how the BiDi algorithm operates.
  @[Flags]
  enum ReorderingOption : UInt32
    # Disable all options.
    Default = 0 # LibICU::UBIDI_OPTION_DEFAULT
    # Insert Bidi marks (LRM or RLM) when needed to ensure correct result of a reordering to a Logical order.
    InsertMarks = 1 # LibICU::UBIDI_OPTION_INSERT_MARKS
    # Remove Bidi control characters.
    RemoveControls = 2 # LibICU::UBIDI_OPTION_REMOVE_CONTROLS
    # Process the output as part of a stream to be continued.
    Streaming = 4 # LibICU::UBIDI_OPTION_STREAMING
  end

  # Options for `write_reordered` and static `write_reverse`. Affects the output string.
  @[Flags]
  enum WriteOption : UInt16
    # Keep combining characters after their base characters in RTL runs.
    KeepBaseCombining = 1 # LibICU::UBIDI_KEEP_BASE_COMBINING
    # Replace characters with the "mirrored" property in RTL runs by their mirror-image mappings.
    DoMirroring = 2 # LibICU::UBIDI_DO_MIRRORING
    # Surround the run with LRMs if necessary (part of approximate "inverse Bidi").
    InsertLrmForNumeric = 4 # LibICU::UBIDI_INSERT_LRM_FOR_NUMERIC
    # Remove Bidi control characters.
    RemoveBidiControls = 8 # LibICU::UBIDI_REMOVE_BIDI_CONTROLS
    # Write the output in reverse order.
    OutputReverse = 16 # LibICU::UBIDI_OUTPUT_REVERSE
  end

  # Holds information about a single visual run.
  record VisualRunInfo, logical_start : Int32, length : Int32, direction : Direction

  # Holds information about a single paragraph.
  record ParagraphInfo, index : Int32, start : Int32, limit : Int32, level : Level

  @ubidi : LibICU::UBiDi

  # Creates a new, empty BiDi object.
  # You must call `set_text` before performing operations.
  #
  # For optimal performance when processing many strings of the same
  # approximate size, consider using `ICU::BiDi.open_sized`.
  def initialize
    @ubidi = LibICU.ubidi_open || raise ICU::Error.new("Failed to open ubidi object")
  end

  # Creates a new BiDi object and immediately processes the given text.
  #
  # ```
  # bidi = ICU::BiDi.new("hello العربية world")
  # puts bidi.direction # => ICU::BiDi::Direction::Mixed
  # ```
  #
  # - `text`: The input string.
  # - `para_level`: The default paragraph level. Defaults to `DEFAULT_LTR`.
  def initialize(text : String, para_level : Level = DEFAULT_LTR)
    initialize
    set_text(text, para_level)
  end

  # Releases resources associated with the BiDi object.
  def finalize
    @ubidi.try { |ubidi| LibICU.ubidi_close(ubidi) }
  end

  # Sets the text to be processed by the BiDi algorithm.
  #
  # - `text`: The input string.
  # - `para_level`: The default paragraph level. Use `0` for LTR, `1` for RTL,
  #   or `ICU::BiDi::DEFAULT_LTR` or `ICU::BiDi::DEFAULT_RTL` to
  #   auto-detect based on the first strong character. Defaults to `0`.
  # - `embedding_levels`: Optional array of embedding levels for explicit
  #   overrides. If `nil`, levels are calculated by the algorithm.
  #   Each level can optionally have `ICU::BiDi::LEVEL_OVERRIDE` bit set.
  #   Note: The caller is responsible for ensuring the `embedding_levels` array
  #   remains valid as long as this `ICU::BiDi` object is in use.
  def set_text(
    text : String,
    para_level : Level = 0.to_u8,
    embedding_levels : Array(Level)? = nil
  ) : Nil
    @text_cache = text # Cache the original text
    ustatus = LibICU::UErrorCode::UZeroError
    levels_ptr = embedding_levels.try(&.to_unsafe)
    text_uchars = text.to_uchars
    LibICU.ubidi_set_para(@ubidi, text_uchars, text_uchars.size, para_level, levels_ptr, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  # Sets context text that surrounds the main text processed by `set_text`.
  # This can affect the resolution of the paragraph level, especially
  # when `para_level` is `DEFAULT_LTR` or `DEFAULT_RTL`.
  #
  # - `prologue`: Text before the main text.
  # - `epilogue`: Text after the main text.
  def set_context(prologue : String, epilogue : String) : Nil
    # Clear cache if context changes, as it affects processing
    @text_cache = nil unless prologue.empty? && epilogue.empty?
    ustatus = LibICU::UErrorCode::UZeroError
    pro_uchars = prologue.to_uchars
    epi_uchars = epilogue.to_uchars
    LibICU.ubidi_set_context(@ubidi, pro_uchars, pro_uchars.size, epi_uchars, epi_uchars.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  # Gets the overall direction of the processed text.
  #
  # Returns `Direction::Ltr`, `Direction::Rtl`, or `Direction::Mixed`.
  def direction : Direction
    LibICU.ubidi_get_direction(@ubidi)
  end

  # Gets the original length of the text set by `set_text`.
  def length : Int32
    LibICU.ubidi_get_length(@ubidi)
  end

  # Gets the length of the reordered text that would be generated by `write_reordered`.
  # This may differ from the original `length` if `ReorderingOption::InsertMarks`
  # or `ReorderingOption::RemoveControls` is active.
  def result_length : Int32
    LibICU.ubidi_get_result_length(@ubidi)
  end

  # Gets the base paragraph level of the text.
  # If the text contains multiple paragraphs and the level was auto-detected
  # (`DEFAULT_LTR` or `DEFAULT_RTL`), this returns the level of the *first* paragraph.
  # Use `paragraph` or `paragraph_by_index` to get levels of specific paragraphs.
  def para_level : Level
    LibICU.ubidi_get_para_level(@ubidi)
  end

  # Gets the number of paragraphs detected in the text (separated by block separators like U+2029).
  def paragraph_count : Int32
    LibICU.ubidi_count_paragraphs(@ubidi)
  end

  # Gets information about the paragraph containing the character at `char_index`.
  #
  # - `char_index`: A logical index within the text (`0 <= char_index < length`).
  # - Returns a `ParagraphInfo` record containing the paragraph's index, start/limit indices, and level.
  def paragraph(char_index : Int32) : ParagraphInfo
    ustatus = LibICU::UErrorCode::UZeroError
    para_start = uninitialized Int32
    para_limit = uninitialized Int32
    para_level = uninitialized Level
    para_idx = LibICU.ubidi_get_paragraph(@ubidi, char_index, pointerof(para_start), pointerof(para_limit), pointerof(para_level), pointerof(ustatus))
    ICU.check_error!(ustatus)
    ParagraphInfo.new(index: para_idx, start: para_start, limit: para_limit, level: para_level)
  end

  # Gets information about the paragraph at the specified `para_index`.
  #
  # - `para_index`: The index of the paragraph (`0 <= para_index < paragraph_count`).
  # - Returns a `ParagraphInfo` record containing the paragraph's index, start/limit indices, and level.
  def paragraph_by_index(para_index : Int32) : ParagraphInfo
    ustatus = LibICU::UErrorCode::UZeroError
    para_start = uninitialized Int32
    para_limit = uninitialized Int32
    para_level = uninitialized Level
    LibICU.ubidi_get_paragraph_by_index(@ubidi, para_index, pointerof(para_start), pointerof(para_limit), pointerof(para_level), pointerof(ustatus))
    ICU.check_error!(ustatus)
    # Note: The C API doesn't return the index here, but we know it.
    ParagraphInfo.new(index: para_index, start: para_start, limit: para_limit, level: para_level)
  end

  # Gets the number of directional runs in the visually reordered text.
  # A run is a contiguous sequence of characters having the same level.
  # This function may trigger the actual reordering calculation.
  def run_count : Int32
    ustatus = LibICU::UErrorCode::UZeroError
    count = LibICU.ubidi_count_runs(@ubidi, pointerof(ustatus))
    ICU.check_error!(ustatus)
    count
  end

  # Gets information about a specific visual run. Runs are ordered visually (left-to-right).
  #
  # - `run_index`: The index of the visual run (`0 <= run_index < run_count`).
  # - Returns a `VisualRunInfo` record containing the run's logical start index, length, and direction.
  def visual_run(run_index : Int32) : VisualRunInfo
    logical_start_val = uninitialized Int32
    length_val = uninitialized Int32
    direction_val = LibICU.ubidi_get_visual_run(@ubidi, run_index, pointerof(logical_start_val), pointerof(length_val))
    VisualRunInfo.new(logical_start: logical_start_val, length: length_val, direction: direction_val)
  end

  # Gets an array containing information about all visual runs.
  #
  # ```
  # runs = bidi.visual_runs
  # runs.each { |run| puts run }
  # ```
  def visual_runs : Array(VisualRunInfo)
    count = run_count
    Array(VisualRunInfo).new(count) { |i| visual_run(i) }
  end

  # Maps a visual index to its corresponding logical index in the original text.
  #
  # - `visual_index`: The visual index (`0 <= visual_index < result_length`).
  # - Returns the logical index (`Int32`). Returns `MAP_NOWHERE` if the visual index
  #   corresponds to an inserted Bidi mark (if `ReorderingOption::InsertMarks` is active).
  def logical_index(visual_index : Int32) : Int32
    ustatus = LibICU::UErrorCode::UZeroError
    logical_idx = LibICU.ubidi_get_logical_index(@ubidi, visual_index, pointerof(ustatus))
    ICU.check_error!(ustatus)
    logical_idx
  end

  # Maps a logical index from the original text to its corresponding visual index.
  #
  # - `logical_index`: The logical index (`0 <= logical_index < length`).
  # - Returns the visual index (`Int32`). Returns `MAP_NOWHERE` if the logical index
  #   corresponds to a removed Bidi control (if `ReorderingOption::RemoveControls` is active).
  def visual_index(logical_index : Int32) : Int32
    ustatus = LibICU::UErrorCode::UZeroError
    visual_idx = LibICU.ubidi_get_visual_index(@ubidi, logical_index, pointerof(ustatus))
    ICU.check_error!(ustatus)
    visual_idx
  end

  # Generates the visually reordered string based on the processed text.
  #
  # - `options`: `WriteOption` flags to control mirroring, mark insertion/removal, etc. Defaults to `WriteOption::None`.
  # - Returns the reordered string.
  def write_reordered(options : WriteOption = WriteOption::None) : String
    ustatus = LibICU::UErrorCode::UZeroError
    # Use result_length which accounts for potential insertions/removals from reordering options
    dest_size = self.result_length

    # Handle empty string case
    return "" if dest_size == 0

    buff = UChars.new(dest_size)
    # Pass the raw enum value to the C function
    actual_len = LibICU.ubidi_write_reordered(@ubidi, buff, buff.size, options.value, pointerof(ustatus))
    ICU.check_error!(ustatus)

    # The actual length might differ if options caused insertions/removals not accounted for
    # by get_result_length (though it usually should). Use actual_len for safety.
    buff.to_s(actual_len)
  end

  # Static method to reverse a string character by character.
  # This is a simple reversal and does *not* perform the BiDi algorithm.
  # Use `write_reordered` with `WriteOption::OutputReverse` for BiDi-aware reversal.
  #
  # - `src`: The source string to reverse.
  # - `options`: `WriteOption` flags (e.g., `DoMirroring`, `RemoveBidiControls`). Defaults to `WriteOption::None`.
  # - Returns the reversed string.
  def self.write_reverse(src : String, options : WriteOption = WriteOption::None) : String
    ustatus = LibICU::UErrorCode::UZeroError

    src = src.to_uchars
    dest_size = src.size # Reversed string has the same length unless controls are removed

    # Handle empty string case
    return "" if dest_size == 0

    # If RemoveBidiControls is set, the destination size might be smaller.
    # We need to call writeReverse once with a null buffer to get the required size.
    if options.includes?(WriteOption::RemoveBidiControls)
      required_size = LibICU.ubidi_write_reverse(src, src.size, Pointer(LibICU::UChar).null, 0, options.value, pointerof(ustatus))
      # U_BUFFER_OVERFLOW_ERROR is expected when passing null buffer, clear it.
      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        ustatus = LibICU::UErrorCode::UZeroError
      end
      ICU.check_error!(ustatus) # Check for other potential errors
      dest_size = required_size
      return "" if dest_size == 0 # Handle case where all chars are removed or src is empty
    end

    dst = UChars.new(dest_size)
    actual_len = LibICU.ubidi_write_reverse(src, src.size, dst, dst.size, options.value, pointerof(ustatus))
    ICU.check_error!(ustatus)

    # Use actual_len just in case, though it should match required_size here.
    dst.to_s(actual_len)
  end

  # Static method to get the base direction of a plain text string according to the
  # first strong character (L, R, or AL) per the Unicode Bidirectional Algorithm.
  #
  # - `text`: The input string.
  # - Returns `Direction::Ltr`, `Direction::Rtl`, or `Direction::Neutral`.
  #   Note: `Direction::Mixed` is not returned by this specific function.
  def self.base_direction(text : String) : Direction
    text = text.to_uchars
    LibICU.ubidi_get_base_direction(text, text.size)
  end

  # Sets whether to use an approximation of the "inverse" BiDi algorithm
  # (transforming visual order to logical order).
  # This is equivalent to setting `reordering_mode = ReorderingMode::InverseNumbersAsL`.
  # Must be called *before* `set_text`.
  #
  # - `is_inverse`: `true` to enable inverse mode, `false` for standard forward mode.
  def inverse=(is_inverse : Bool) : Nil
    # Setting inverse might invalidate cached text if behavior changes
    LibICU.ubidi_set_inverse(@ubidi, is_inverse ? 1 : 0)
  end

  # Checks if the inverse BiDi algorithm mode (`ReorderingMode::InverseNumbersAsL`) is active.
  def inverse? : Bool
    LibICU.ubidi_is_inverse(@ubidi) != 0
  end

  # Sets whether paragraph separators (like U+2029) should always be treated as LTR (level 0).
  # This ensures that paragraphs visually flow from left-to-right regardless of their content direction.
  # Must be called *before* `set_text`.
  #
  # - `order_ltr`: `true` to force LTR paragraph progression, `false` for default behavior.
  def order_paragraphs_ltr=(order_ltr : Bool) : Nil
    # Setting this might invalidate cached text if behavior changes
    LibICU.ubidi_order_paragraphs_ltr(@ubidi, order_ltr ? 1 : 0)
  end

  # Checks if paragraph separators are forced to level 0 for LTR progression.
  def order_paragraphs_ltr? : Bool
    LibICU.ubidi_is_order_paragraphs_ltr(@ubidi) != 0
  end

  # Sets the specific BiDi algorithm variant or reordering mode to use.
  # See `ReorderingMode` enum and ICU documentation for details on each mode
  # (e.g., default, inverse, grouping numbers, runs only).
  # Must be called *before* `set_text`.
  #
  # - `mode`: The desired `ReorderingMode`.
  def reordering_mode=(mode : ReorderingMode) : Nil
    # Setting mode might invalidate cached text if behavior changes
    @text_cache = nil
    LibICU.ubidi_set_reordering_mode(@ubidi, mode)
  end

  # Gets the currently active reordering mode.
  def reordering_mode : ReorderingMode
    LibICU.ubidi_get_reordering_mode(@ubidi)
  end

  # Sets options that modify the behavior of the selected reordering mode
  # (e.g., inserting marks, removing controls, streaming).
  # Must be called *before* `set_text`.
  #
  # - `options`: A `ReorderingOption` enum value or a bitmask combination.
  def reordering_options=(options : ReorderingOption) : Nil
    # Setting options might invalidate cached text if behavior changes
    LibICU.ubidi_set_reordering_options(@ubidi, options.value)
  end

  # Gets the currently active reordering options as a bitmask.
  def reordering_options : UInt32
    LibICU.ubidi_get_reordering_options(@ubidi)
  end
end
