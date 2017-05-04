@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UDateTimeScale
    UdtsJavaTime             =  0
    UdtsUnixTime             =  1
    UdtsIcU4cTime            =  2
    UdtsWindowsFileTime      =  3
    UdtsDotnetDateTime       =  4
    UdtsMacOldTime           =  5
    UdtsMacTime              =  6
    UdtsExcelTime            =  7
    UdtsDB2Time              =  8
    UdtsUnixMicrosecondsTime =  9
    UdtsMaxScale             = 10
  end
  enum UTimeScaleValue
    UtsvUnitsValue             =  0
    UtsvEpochOffsetValue       =  1
    UtsvFromMinValue           =  2
    UtsvFromMaxValue           =  3
    UtsvToMinValue             =  4
    UtsvToMaxValue             =  5
    UtsvEpochOffsetPlus1Value  =  6
    UtsvEpochOffsetMinus1Value =  7
    UtsvUnitsRoundValue        =  8
    UtsvMinRoundValue          =  9
    UtsvMaxRoundValue          = 10
    UtsvMaxScaleValue          = 11
  end
  fun utmscale_from_int64 = utmscale_fromInt64{{SYMS_SUFFIX.id}}(other_time : Int64T, time_scale : UDateTimeScale, status : UErrorCode*) : Int64T
  fun utmscale_get_time_scale_value = utmscale_getTimeScaleValue{{SYMS_SUFFIX.id}}(time_scale : UDateTimeScale, value : UTimeScaleValue, status : UErrorCode*) : Int64T
  fun utmscale_to_int64 = utmscale_toInt64{{SYMS_SUFFIX.id}}(universal_time : Int64T, time_scale : UDateTimeScale, status : UErrorCode*) : Int64T
  {% end %}
end
