# not thread-safe
class ICU::Currencies
  enum Type
    All           = Int32::MAX,
    Common        = 1,
    Uncommon      = 2,
    Deprecated    = 4,
    NonDeprecated = 8
  end

  enum NameStyle
    Symbol = LibICU::UCurrNameStyle::UcurrSymbolName
    Long   = LibICU::UCurrNameStyle::UcurrLongName
  end

  def self.currency(locale : String) : String
    buff = Slice(LibICU::UChar).new(4)
    len = LibICU.ucurr_for_locale(locale, buff, buff.size, out ustatus)
    ICU.check_error!(ustatus)
    ICU.uchars_to_string(buff, len)
  end

  def self.numeric_code(currency : String) : Int32
    num = LibICU.ucurr_get_numeric_code(ICU.string_to_uchars(currency))
    raise ICU::Error.new(%(Unknown currency "#{currency}")) if num == 0
    num
  end
end
