require "./spec_helper"

# Describe the main module now, and the specific helper method
describe ICU do
  describe ".with_auto_resizing_buffer" do
    it "returns the string when buffer is large enough initially (UChars)" do
      test_string = "Hello"
      test_uchars = test_string.to_uchars

      result = ICU.with_auto_resizing_buffer(20, ICU::UChars) do |buffer, status_ptr|
        buffer.as(ICU::UChars).to_slice[0, test_uchars.size].copy_from(test_uchars.to_slice)
        test_uchars.size # Return actual length written
      end

      result.should eq(test_string)
    end

    it "returns the string when buffer is large enough initially (Bytes)" do
      test_string = "World"
      test_bytes = test_string.to_slice

      result = ICU.with_auto_resizing_buffer(20, Bytes) do |buffer, status_ptr|
        # Explicitly use buffer as Bytes before getting slice
        buffer.as(Bytes).to_slice[0, test_bytes.size].copy_from(test_bytes)
        test_bytes.size # Return actual length written
      end

      result.should eq(test_string)
    end

    it "resizes the buffer and returns the string on U_BUFFER_OVERFLOW_ERROR (UChars)" do
      test_string = "This is a longer string"
      test_uchars = test_string.to_uchars
      required_size = test_uchars.size
      call_count = 0

      result = ICU.with_auto_resizing_buffer(5, ICU::UChars) do |buffer, status_ptr|
        call_count += 1
        if buffer.size < required_size
          status_ptr.value = LibICU::UErrorCode::UBufferOverflowError
          required_size # Return required size
        else
          buffer.as(ICU::UChars).to_slice[0, required_size].copy_from(test_uchars.to_slice)
          required_size # Return actual length written
        end
      end

      result.should eq(test_string)
      call_count.should eq(2) # Initial call + retry
    end

    it "resizes the buffer and returns the string on U_BUFFER_OVERFLOW_ERROR (Bytes)" do
      test_string = "Another long string for bytes"
      test_bytes = test_string.to_slice
      required_size = test_bytes.size
      call_count = 0

      result = ICU.with_auto_resizing_buffer(10, Bytes) do |buffer, status_ptr|
        call_count += 1
        if buffer.size < required_size
          status_ptr.value = LibICU::UErrorCode::UBufferOverflowError
          required_size # Return required size
        else
          # Explicitly use buffer as Bytes before getting slice
          buffer.as(Bytes).to_slice[0, required_size].copy_from(test_bytes)
          required_size # Return actual length written
        end
      end

      result.should eq(test_string)
      call_count.should eq(2) # Initial call + retry
    end

    it "raises ICU::Error for other ICU errors" do
      expect_raises(ICU::Error, "U_ILLEGAL_ARGUMENT_ERROR") do
        ICU.with_auto_resizing_buffer(20, ICU::UChars) do |buffer, status_ptr|
          status_ptr.value = LibICU::UErrorCode::UIllegalArgumentError
          0 # Return value doesn't matter here
        end
      end
    end

    it "raises other exceptions from the block" do
      expect_raises(RuntimeError, "Something went wrong") do
        ICU.with_auto_resizing_buffer(20, Bytes) do |buffer, status_ptr|
          raise RuntimeError.new("Something went wrong")
        end
      end
    end

    it "handles zero-length results correctly" do
      result = ICU.with_auto_resizing_buffer(10, Bytes) do |buffer, status_ptr|
        0 # Return zero length
      end
      result.should eq("")
    end
  end
end
