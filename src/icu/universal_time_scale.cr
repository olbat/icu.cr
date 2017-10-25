# Universal Time Scale
#
# See also:
# - [reference implementation](http://icu-project.org/apiref/icu4c/utmscale_8h.html)
# - [user guide](http://userguide.icu-project.org/datetime/universaltimescale)
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

  def self.from(time : Int64, time_scale : DateTimeScale) : UniversalTime
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.utmscale_from_int64(time, time_scale, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret
  end

  def self.to(universal_time : UniversalTime, time_scale : DateTimeScale) : Int64
    ustatus = LibICU::UErrorCode::UZeroError
    ret = LibICU.utmscale_to_int64(universal_time, time_scale, pointerof(ustatus))
    ICU.check_error!(ustatus)
    ret
  end
end
