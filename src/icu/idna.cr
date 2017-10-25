# International Domain Names in Applications
#
# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/uidna_8h.html)
# - [user guide](http://userguide.icu-project.org/strings/stringprep#TOC-IDNA-API-in-ICU)
class ICU::IDNA
  # FIXME: should be present in LibICU (not parsed by Libgen)
  @[Flags]
  enum Option : UInt32
    Default                  =    0
    UseStd3Rules             =    2
    CheckBidi                =    4
    CheckContextj            =    8
    NontransitionalToASCII   = 0x10
    NontransitionalToUnicode = 0x20
    CheckContexto            = 0x40
  end

  def self.to_ascii(unicode_idn : String, options : UInt32 = Option::Default.to_u32) : String
    src = unicode_idn.to_uchars
    dst = ICU::UChars.new(src.size * 2)

    ustatus = LibICU::UErrorCode::UZeroError
    # FIXME: deprecated
    size = LibICU.uidna_idn_to_ascii(src, src.size, dst, dst.size, options, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)

    dst.to_s(size)
  end

  def self.to_unicode(ascii_idn : String, options : UInt32 = Option::Default.to_u32) : String
    src = ascii_idn.to_uchars
    dst = ICU::UChars.new(src.size)

    ustatus = LibICU::UErrorCode::UZeroError
    # FIXME: deprecated
    size = LibICU.uidna_idn_to_unicode(src, src.size, dst, dst.size, options, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)

    dst.to_s(size)
  end

  def self.compare(idn1 : String, idn2 : String, options : UInt32 = Option::Default.to_u32) : Int
    idn1 = idn1.to_uchars
    idn2 = idn2.to_uchars

    ustatus = LibICU::UErrorCode::UZeroError
    # FIXME: deprecated
    ret = LibICU.uidna_compare(idn1, idn1.size, idn2, idn2.size, options, pointerof(ustatus))
    ICU.check_error!(ustatus)

    ret
  end

  # FIXME: find a way to use this without getting an U_ILLEGAL_ARGUMENT_ERROR
  #
  # @options : UInt32
  # @uidna : LibICU::Uidna
  #
  # def initialize(@options : UInt32 = Option::Default.to_u32)
  #   ustatus = LibICU::UErrorCode::UZeroError
  #   @uidna = LibICU.uidna_open_ut_s46(@options, pointerof(ustatus))
  #   ICU.check_error!(ustatus)
  # end
  #
  # def finalize
  #   @uidna.try { |uidna| LibICU.uidna_close(uidna) }
  # end
  #
  # def name_to_unicode(domain_name : String)
  #   dest = ICU::UChars.new(domain_name.size * 2)
  #   info = LibICU::UidnaInfo.new
  #
  #   ustatus = LibICU::UErrorCode::UZeroError
  #   size = LibICU.uidna_name_to_unicode(@uidna, domain_name.to_uchars, domain_name.size, dest, dest.size, pointerof(info), pointerof(ustatus))
  #   ICU.check_error!(ustatus)
  #
  #   dest.to_s(size)
  # end
  #
  # def name_to_ascii(domain_name : String)
  #   dest = ICU::UChars.new(domain_name.size * 2)
  #   info = LibICU::UidnaInfo.new
  #
  #   ustatus = LibICU::UErrorCode::UZeroError
  #   size = LibICU.uidna_name_to_ascii(@uidna, domain_name.to_uchars, domain_name.size, dest, dest.size, pointerof(info), pointerof(ustatus))
  #   ICU.check_error!(ustatus)
  #
  #   dest.to_s(size)
  # end
end
