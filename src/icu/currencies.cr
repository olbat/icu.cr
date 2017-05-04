# not thread-safe
class ICU::Currencies
  enum Type
    All           = Int32::MAX,
    Common        = 1,
    Uncommon      = 2,
    Deprecated    = 4,
    NonDeprecated = 8
  end
  alias NameStyle = LibICU::UCurrNameStyle

  def self.currency(locale : String) : String
    buff = Slice(LibICU::UChar).new(4)
    len = LibICU.ucurr_for_locale(locale, buff, buff.size, out ustatus)
    ICU.check_error!(ustatus)
    ICU.uchars_to_string(buff, len)
  end

  {% if compare_versions(LibICU::VERSION, "49.0.0") >= 0 %}
  def self.numeric_code(currency : String) : Int32
    num = LibICU.ucurr_get_numeric_code(ICU.string_to_uchars(currency))
    raise ICU::Error.new(%(Unknown currency "#{currency}")) if num == 0
    num
  end
  {% end %}
end
