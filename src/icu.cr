require "./lib_icu/*"
require "./icu/*"

module ICU
  def self.check_error!(ustatus : LibICU::UErrorCode)
    if ustatus != LibICU::UErrorCode::UZeroError
      raise Error.new(String.new(LibICU.u_error_name(ustatus)))
    end
  end
end
