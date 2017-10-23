# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/uloc_8h.html)
# - [user guide](http://userguide.icu-project.org/locale)
class ICU::Locale
  LANG_MAX_SIZE                =  12
  COUNTRY_MAX_SIZE             =   4
  FULLNAME_MAX_SIZE            = 157
  SCRIPT_MAX_SIZE              =   6
  KEYWORDS_MAX_SIZE            =  96
  KEYWORDS_AND_VALUES_MAX_SIZE = 100
  DEFAULT_LOCALE               = ""

  class Keyword
    SEPARATOR      = '@'
    ASSIGN         = '='
    ITEM_SEPARATOR = ';'
  end
end
