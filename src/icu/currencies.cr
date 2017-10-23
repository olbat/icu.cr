# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/ucurr_8h.html)
class ICU::Currencies
  # FIXME: should be present in LibICU (not parsed by Libgen)
  enum Type
    All           = Int32::MAX,
    Common        = 1,
    Uncommon      = 2,
    Deprecated    = 4,
    NonDeprecated = 8
  end
  alias NameStyle = LibICU::UCurrNameStyle

  # FIXME: not thread-safe
  def self.currency(locale : String) : String
    buff = UChars.new(4)
    ustatus = uninitialized LibICU::UErrorCode
    len = LibICU.ucurr_for_locale(locale, buff, buff.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    buff.to_s(len)
  end

  {% if compare_versions(LibICU::VERSION, "49.0.0") >= 0 %}
  def self.numeric_code(currency : String) : Int32
    num = LibICU.ucurr_get_numeric_code(currency.to_uchars)
    raise ICU::Error.new(%(Unknown currency "#{currency}")) if num == 0
    num
  end
  {% end %}
end
