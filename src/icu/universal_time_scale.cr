# __Universal Time Scale__
# Convert dates between binary datetime conventions
#
# __Usage__
# ```
# ts = ICU::UniversalTimeScale::DateTimeScale::UnixTime
# ICU::UniversalTimeScale.from(0.to_i64, ts) # => (ICU::UniversalTimeScale::TIME_SCALES[ts][:epoch_offset] * (10**7))
# ```
#
# __See also__
# - [reference implementation](http://icu-project.org/apiref/icu4c/utmscale_8h.html)
# - [user guide](http://userguide.icu-project.org/datetime/universaltimescale)
# - [unit tests](https://github.com/olbat/icu.cr/blob/master/spec/universal_time_scale_spec.cr)
class ICU::UniversalTimeScale
  alias UniversalTime = Int64
  alias DateTimeScale = LibICU::UDateTimeScale

  TIME_SCALE_VALUES_IDS = {
    precision:    LibICU::UTimeScaleValue::UnitsValue,
    epoch_offset: LibICU::UTimeScaleValue::EpochOffsetValue,
    from_min:     LibICU::UTimeScaleValue::FromMinValue,
    from_max:     LibICU::UTimeScaleValue::FromMaxValue,
    to_min:       LibICU::UTimeScaleValue::ToMinValue,
    to_max:       LibICU::UTimeScaleValue::ToMaxValue,
  }

  alias TimeScaleValues = NamedTuple(precision: Int64, epoch_offset: Int64, from_min: Int64, from_max: Int64, to_min: Int64, to_max: Int64)

  # A list of the supported time scales
  TIME_SCALES = begin
    tss = Hash(DateTimeScale, TimeScaleValues).new
    LibICU::UDateTimeScale.each do |time_scale, _|
      next if time_scale == LibICU::UDateTimeScale::MaxScale
      tsv = Hash(Symbol, Int64).new

      {% for name, id in TIME_SCALE_VALUES_IDS %}
        tsv[:{{ name.id }}] = begin
          ustatus = LibICU::UErrorCode::UZeroError
          value = LibICU.utmscale_get_time_scale_value(time_scale, {{ id.id }}, pointerof(ustatus))
          ICU.check_error!(ustatus)
          value
        end
      {% end %}

      tss[time_scale] = TimeScaleValues.from(tsv)
    end
    tss
  end

  # Converts a time using the _time_scale_ date convention to a Universal time
  def self.from(time : Int64, time_scale : DateTimeScale) : UniversalTime
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.utmscale_from_int64(time, time_scale, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret
  end

  # Converts a UniversalTime to a time using the _time_scale_ date convention
  def self.to(universal_time : UniversalTime, time_scale : DateTimeScale) : Int64
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.utmscale_to_int64(universal_time, time_scale, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret
  end
end
