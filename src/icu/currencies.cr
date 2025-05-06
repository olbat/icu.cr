# __Currencies__
#
# Encapsulates information about a currency.
#
# __Usage__
# ```
# ICU::Currencies.currency("fr_FR")   # => "EUR"
# ICU::Currencies.numeric_code("EUR") # => 978
# ```
#
# NOTE: the `numeric_code` method requires ICU >= 49
#
# __See also__
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/ucurr_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/currencies_spec.cr)
class ICU::Currencies
  # FIXME: should be present in LibICU (not parsed by Libgen)
  enum Type
    All           = Int32::MAX
    Common        = 1
    Uncommon      = 2
    Deprecated    = 4
    NonDeprecated = 8
  end
  alias NameStyle = LibICU::UCurrNameStyle

  # Returns the currency for a specified locale
  #
  # ```
  # ICU::Currencies.currency("fr_FR") # => "EUR"
  # ```
  #
  # FIXME: not thread-safe
  def self.currency(locale : String) : String
    buff = UChars.new(4)
    ustatus = LibICU::UErrorCode::UZeroError
    len = LibICU.ucurr_for_locale(locale, buff, buff.size, pointerof(ustatus))
    ICU.check_error!(ustatus)
    buff.to_s(len)
  end

  {% if compare_versions(LibICU::VERSION, "49.0.0") >= 0 %}
    # Returns the code associated to a currency
    #
    # ```
    # ICU::Currencies.numeric_code("EUR") # => 978
    # ```
    def self.numeric_code(currency : String) : Int32
      num = LibICU.ucurr_get_numeric_code(currency.to_uchars)
      raise ICU::Error.new(%(Unknown currency "#{currency}")) if num == 0
      num
    end
  {% end %}
end
