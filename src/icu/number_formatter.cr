# __Number Formatter__
#
# This class provides a facility for formatting and parsing numbers.
#
# __Usage__
# ```
# nf = ICU::NumberFormatter.new("en_US")
# nf.format(1234.56) # => "1,234.56"
# nf.parse("1,234.56") # => 1234.56
# ```
#
# __See also__
# - [reference implementation](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/unum_8h.html)
# - [user guide](https://unicode-org.github.io/icu/userguide/format_parse/numbers/)
# - [unit tests](https://github.com/olbat/icu.cr/blob/master/spec/number_formatter_spec.cr)
class ICU::NumberFormatter
  record MonetaryAmount, amount : Float64, currency_code : String

  alias FormatStyle = LibICU::UNumberFormatStyle
  alias FormatAttribute = LibICU::UNumberFormatAttribute

  @unum : LibICU::UNumberFormat*

  # Creates a new NumberFormatter.
  #
  # ```
  # nf = ICU::NumberFormatter.new("en_US")
  # nf = ICU::NumberFormatter.new("fr_FR", ICU::NumberFormatter::FormatStyle::Currency)
  # ```
  def initialize(locale : String = "en_US", format_style : FormatStyle = FormatStyle::Default)
    ustatus = LibICU::UErrorCode::UZeroError
    parse_error = LibICU::UParseError.new

    @unum = LibICU.unum_open(format_style, nil, 0, locale, pointerof(parse_error), pointerof(ustatus))

    ICU.check_error!(ustatus)
  end

  def finalize
    @unum.try { |unum| LibICU.unum_close(unum) }
  end

  # Formats a number into a string.

  # ```
  # nf = ICU::NumberFormatter.new("en_US")
  # nf.format(1234.56) # => "1,234.56"
  # ```
  def format(number : Float64) : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff = UChars.new(32)
    len = LibICU.unum_format_double(@unum, number, buff, buff.size, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
    buff.to_s(len)
  end

  # Formats a number with a currency code (3 letters code, see ISO 4217) into a string.
  #
  # ```
  # nf = ICU::NumberFormatter.new("en_US", ICU::NumberFormatter::FormatStyle::Currency)
  # nf.format(1234.56, "USD") # => "$1,234.56"
  # ```
  def format(number : Float64, currency_code : String) : String
    ustatus = LibICU::UErrorCode::UZeroError
    currency_code = currency_code.to_uchars
    buff = UChars.new(32)
    len = LibICU.unum_format_double_currency(@unum, number, currency_code, buff, buff.size, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
    buff.to_s(len)
  end

  # Formats a number into a string.
  #
  # ```
  # nf = ICU::NumberFormatter.new("en_US")
  # nf.format(1234) # => "1,234"
  # ```
  def format(number : Int64) : String
    ustatus = LibICU::UErrorCode::UZeroError
    buff = UChars.new(32)
    len = LibICU.unum_format_int64(@unum, number, buff, buff.size, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
    buff.to_s(len)
  end

  # Parses a string into an integer number.
  #
  # ```
  # nf = ICU::NumberFormatter.new("en_US")
  # nf.parse("1,234.56") # => 1234
  # ```
  def parse_int(text : String) : Int64
    ustatus = LibICU::UErrorCode::UZeroError
    text = text.to_uchars
    number = LibICU.unum_parse_int64(@unum, text, text.size, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
    number
  end

  # Parses a string into a floating point number.
  #
  # ```
  # nf = ICU::NumberFormatter.new("en_US")
  # nf.parse("1,234.56") # => 1234.56
  # ```
  def parse_float(text : String) : Float64
    ustatus = LibICU::UErrorCode::UZeroError
    text = text.to_uchars
    number = LibICU.unum_parse_double(@unum, text, text.size, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
    number
  end

  # Sets an attribute of the number formatter.
  #
  # ```
  # nf.set_attribute(ICU::NumberFormatter::FormatAttribute::GroupingUsed, 0)
  # ```
  def set_attribute(attribute : FormatAttribute, value : Int32)
    LibICU.unum_set_attribute(@unum, attribute, value)
  end

  # Gets an attribute of the number formatter.
  #
  # ```
  # nf.get_attribute(ICU::NumberFormatter::FormatAttribute::GroupingUsed) # => 0
  # ```
  def get_attribute(attribute : FormatAttribute) : Int32
    LibICU.unum_get_attribute(@unum, attribute)
  end

  # Parses a string into a monetary amount.
  #
  # ```
  # nf.parse_float_with_currency("$1,234.56") # => ICU::NumberFormatter::MonetaryAmount.new(1234.56, "USD")
  # ```
  def parse_float_with_currency(text : String) : MonetaryAmount
    ustatus = LibICU::UErrorCode::UZeroError
    currency_buff = UChars.new(3)
    text = text.to_uchars
    number = LibICU.unum_parse_double_currency(@unum, text, text.size, nil, currency_buff, pointerof(ustatus))
    ICU.check_error!(ustatus)
    MonetaryAmount.new(number, currency_buff.to_s)
  end
end
