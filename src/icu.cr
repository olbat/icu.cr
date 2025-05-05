require "./lib_icu/*"
require "./icu/*"


module ICU
  def self.check_error!(ustatus : LibICU::UErrorCode)
    if ustatus > LibICU::UErrorCode::UZeroError
      raise Error.new(String.new(LibICU.error_name(ustatus)))
    end
  end

  # Helper for ICU C functions that fill a resizable buffer (Bytes or UChars)
  # and indicate required size via U_BUFFER_OVERFLOW_ERROR.
  #
  # It handles the common pattern of calling a C function, checking for
  # buffer overflow, resizing the buffer, and retrying.
  #
  # Parameters:
  # - `initial_size`: The initial capacity of the buffer.
  # - `buffer_type`: The type of buffer to use (`Bytes` or `UChars`).
  # - `&block`: A block that performs the ICU C function call.
  #   - The block receives the buffer (`Bytes` or `UChars`) and a pointer
  #     to the `UErrorCode` (`LibICU::UErrorCode*`). The block can access
  #     the buffer's capacity via `buffer.size`.
  #   - The block *must* return the actual length (`Int32`) of the data written
  #     (or the required length if overflow occurred).
  #
  # Returns:
  # - The resulting `String` converted from the buffer contents.
  #
  # Raises:
  # - `ICU::Error` if the C function returns an ICU error other than `U_BUFFER_OVERFLOW_ERROR`.
  # - Any exception raised within the block (other than `ICU::Error` related to overflow).
  #
  # Example Usage:
  # ```
  # result_string = ICU.with_auto_resizing_buffer(64, ICU::UChars) do |buffer, status_ptr|
  #   LibICU.some_icu_function(..., buffer, buffer.size, status_ptr)
  # end
  # ```
  def self.with_auto_resizing_buffer(initial_size : Int, buffer_type : Bytes.class | UChars.class, &block : (Bytes | UChars, LibICU::UErrorCode* -> Int32)) : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff_size = initial_size

    loop do
      buff = buffer_type.new(buff_size)
      # Call the block, passing the buffer and status pointer.
      # The block is responsible for using buff.size if needed.
      len = block.call(buff, pointerof(ustatus))

      if ustatus == LibICU::UErrorCode::UBufferOverflowError
        buff_size = len + 1 # Request size + 1 for potential null terminator space
        ustatus = LibICU::UErrorCode::UZeroError # Reset status for retry
        next
      end

      # Check for other errors *after* handling overflow
      ICU.check_error!(ustatus)

      # Success
      return case buff
        when Bytes
          String.new(buff.to_slice[0, len])
        when UChars
          buff.to_s(len)
        else
          # This should be unreachable due to the buffer_type restriction
          raise "Internal error: Unexpected buffer type in with_auto_resizing_buffer"
      end
    end
  end
end
