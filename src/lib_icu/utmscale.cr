@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UDateTimeScale
    JavaTime             =  0
    UnixTime             =  1
    Icu4CTime            =  2
    WindowsFileTime      =  3
    DotnetDateTime       =  4
    MacOldTime           =  5
    MacTime              =  6
    ExcelTime            =  7
    Db2Time              =  8
    UnixMicrosecondsTime =  9
    MaxScale             = 10
  end
  enum UTimeScaleValue
    UnitsValue             =  0
    EpochOffsetValue       =  1
    FromMinValue           =  2
    FromMaxValue           =  3
    ToMinValue             =  4
    ToMaxValue             =  5
    EpochOffsetPlus1Value  =  6
    EpochOffsetMinus1Value =  7
    UnitsRoundValue        =  8
    MinRoundValue          =  9
    MaxRoundValue          = 10
    MaxScaleValue          = 11
  end
  fun utmscale_from_int64 = utmscale_fromInt64{{SYMS_SUFFIX.id}}(other_time : Int64T, time_scale : UDateTimeScale, status : UErrorCode*) : Int64T
  fun utmscale_get_time_scale_value = utmscale_getTimeScaleValue{{SYMS_SUFFIX.id}}(time_scale : UDateTimeScale, value : UTimeScaleValue, status : UErrorCode*) : Int64T
  fun utmscale_to_int64 = utmscale_toInt64{{SYMS_SUFFIX.id}}(universal_time : Int64T, time_scale : UDateTimeScale, status : UErrorCode*) : Int64T
  {% end %}
end
