require "./lib_icu/*"
require "./icu/*"

module ICU
  def self.check_error!(ustatus : LibICU::UErrorCode)
    if ustatus > LibICU::UErrorCode::UZeroError
      raise Error.new(String.new(LibICU.error_name(ustatus)))
    end
  end

  def self.uchars_to_string(ustr : Pointer(LibICU::UChar), len) : String
    str = Slice(UInt8).new(len)
    LibICU.u_chars_to_chars(ustr, str, len)
    String.new(str)
  end

  def self.uchars_to_string(ustr : Slice(LibICU::UChar), len) : String
    uchars_to_string(ustr.to_unsafe, len)
  end

  def self.string_to_uchars(str : String) : Pointer(LibICU::UChar)
    ustr = Slice(LibICU::UChar).new(str.size)
    LibICU.chars_to_u_chars(str, ustr, str.size)
    ustr.to_unsafe
  end
end
