# __Calendar__
#
# This class provides an interface to ICU's calendar functions, allowing for
# date and time calculations based on specific locales, time zones, and
# calendar systems (e.g., Gregorian, Buddhist).
#
# __Usage__
# ```
# # Create a Gregorian calendar for New York in English
# calendar = ICU::Calendar.new("America/New_York", "en_US")
#
# # Set the date to April 29, 2025
# calendar.set(ICU::Calendar::DateField::Year, 2025)
# calendar.set(ICU::Calendar::DateField::Month, 3) # Month is 0-indexed (April)
# calendar.set(ICU::Calendar::DateField::DayOfMonth, 29)
#
# # Get the day of the week
# day_of_week = calendar.get(ICU::Calendar::DateField::DayOfWeek) # Sunday = 1, ..., Saturday = 7
#
# # Add 5 days
# calendar.add(ICU::Calendar::DateField::DayOfMonth, 5)
# puts calendar.get(ICU::Calendar::DateField::DayOfMonth) # => 4 (May 4th)
#
# # Get current time
# now = ICU::Calendar.now # => Returns a Time object
# calendar.set(now)
#
# # Check if currently in DST
# puts calendar.in_daylight_time?
# ```
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/datetime/calendar/)
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/ucal_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/calendar_spec.cr)
class ICU::Calendar
  # Type alias for ICU's `UCalendarDateFields` enum. Represents calendar fields like year, month, day, etc.
  alias DateField = LibICU::UCalendarDateFields

  # Type alias for ICU's `UCalendarType` enum. Specifies the type of calendar (e.g., Gregorian, Default).
  alias Type = LibICU::UCalendarType

  DEFAULT_LOCALE = ""

  @ucal : LibICU::UCalendar*

  # Fields to check for difference, from largest to smallest, when comparing times.
  # This order is recommended by ICU documentation for ucal_get_field_difference
  # when determining the overall difference between two dates.
  # Milliseconds are excluded to compare with second granularity.
  private FIELD_DIFFERENCE_ORDER = [
    DateField::Year,
    DateField::Month,
    DateField::DayOfMonth,
    DateField::HourOfDay,
    DateField::Minute,
    DateField::Second,
  ]

  # Creates a new Calendar instance.
  #
  # - `zone_id`: The time zone ID (e.g., "America/New_York", "UTC").
  # - `locale`: The locale ID (e.g., "en_US", "fr_FR").
  # - `type`: The type of calendar to open (e.g., `UCalendarType::Gregorian`).
  def initialize(
    zone_id : String? = nil,
    locale : String = DEFAULT_LOCALE,
    type : Type = Type::Default
  )
    status = LibICU::UErrorCode::UZeroError
    zone_id = zone_id.try { |zid| zid.to_uchars }
    @ucal = LibICU.ucal_open(zone_id, (zone_id.nil? ? 0 : zone_id.size), locale, type, pointerof(status))
    ICU.check_error!(status)
  end

  # Creates a new Calendar instance.
  #
  # - `timezone`: The time zone (e.g., `Time::Location.load("Europe/Berlin")`).
  # - `locale`: The locale ID (e.g., "en_US", "fr_FR").
  # - `type`: The type of calendar to open (e.g., `UCalendarType::Gregorian`).
  def initialize(
    timezone : Time::Location,
    locale : String = DEFAULT_LOCALE,
    type : Type = Type::Default
  )
    status = LibICU::UErrorCode::UZeroError
    timezone = timezone.name.to_uchars
    @ucal = LibICU.ucal_open(timezone, timezone.size, locale, type, pointerof(status))
    ICU.check_error!(status)
  end

  # Creates a new Calendar instance based on a Crystal Time object.
  # The calendar's time zone is derived from the Time object's location.
  #
  # - `time`: The Crystal `Time` object to initialize the calendar with.
  # - `locale`: The locale ID (e.g., "en_US"). Defaults to the system default (`""`).
  # - `type`: The type of calendar (e.g., `UCalendarType::Gregorian`). Defaults to the locale's default (`UCalendarType::Default`).
  def initialize(
    time : Time,
    locale : String = DEFAULT_LOCALE,
    type : Type = Type::Default
  )
    zone_id =
      case location = time.location
      when Time::Location::UTC
        "UTC"
      when Time::Location
        location.name
      end || DEFAULT_LOCALE

    status = LibICU::UErrorCode::UZeroError
    zone_id = zone_id.to_uchars
    @ucal = LibICU.ucal_open(zone_id, zone_id.size, locale, type, pointerof(status))
    ICU.check_error!(status)

    set_millis(time.to_unix_ms)
  end

  def finalize
    @ucal.try { |cal| LibICU.ucal_close(cal) }
  end

  # Gets the value for a specific calendar field.
  #
  # - `field`: The `DateField` to retrieve (e.g., `DateField::Year`, `DateField::Month`).
  # - Returns the integer value of the field. Note that `DateField::Month` is 0-indexed.
  def get(field : DateField) : Int32
    status = LibICU::UErrorCode::UZeroError
    value = LibICU.ucal_get(@ucal, field, pointerof(status))
    ICU.check_error!(status)
    value
  end

  # Sets the value for a specific calendar field.
  #
  # - `field`: The `DateField` to set (e.g., `DateField::Year`, `DateField::Month`).
  # - `value`: The integer value to set for the field. Note that `DateField::Month` is 0-indexed.
  #
  # Raises `ArgumentError` if the value is outside the valid range for the field.
  def set(field : DateField, value : Int32) : Nil
    status = LibICU::UErrorCode::UZeroError

    # Get the minimum and maximum allowed values for the field
    min_value = LibICU.ucal_get_limit(@ucal, field, LibICU::UCalendarLimitType::Minimum, pointerof(status))
    ICU.check_error!(status)

    max_value = LibICU.ucal_get_limit(@ucal, field, LibICU::UCalendarLimitType::Maximum, pointerof(status))
    ICU.check_error!(status)

    # Validate the input value
    if value < min_value || value > max_value
      raise ArgumentError.new("Invalid value '#{value}' for date time field. Must be between #{min_value} and #{max_value} (included)")
    end

    # ucal_set does not take a status parameter
    LibICU.ucal_set(@ucal, field, value)
  end

  def set(year : Int32, month : Int32, day : Int32, hour : Int32 = 0, minute : Int32 = 0, second : Int32 = 0)
    # Note: Month is 1-indexed in this method signature, but 0-indexed for ICU
    set(DateField::Year, year)
    set(DateField::Month, month - 1) # Adjust for 0-indexing
    set(DateField::DayOfMonth, day)
    set(DateField::HourOfDay, hour)
    set(DateField::Minute, minute)
    set(DateField::Second, second)
  end

  # Sets the calendar's date and time based on a Crystal `Time` object.
  #
  # __Important__: the time zone of the Time object is copied too
  def set(date_time : Time) : Nil
    set_time_zone(date_time.location.name)
    set_millis(date_time.to_unix_ms)
  end

  # Gets the calendar's time as milliseconds since the epoch.
  #
  # - Returns the time in milliseconds since 1970-01-01 00:00:00 UTC as `Int64`.
  def get_millis : Int64
    status = LibICU::UErrorCode::UZeroError
    udate = LibICU.ucal_get_millis(@ucal, pointerof(status))
    ICU.check_error!(status)
    udate.to_i64
  end

  # Sets the calendar's time from milliseconds since the epoch (equivalent to ICU's UDate).
  #
  # - `epoch_ms`: The time in milliseconds since 1970-01-01 00:00:00 UTC.
  def set_millis(ms_since_epoch : Int64) : Nil
    status = LibICU::UErrorCode::UZeroError
    LibICU.ucal_set_millis(@ucal, ms_since_epoch.to_f, pointerof(status))
    ICU.check_error!(status)
  end

  # Gets the calendar's time as a Crystal Time object
  def get_time : Time
    Time.local(
      get(DateField::Year),
      get(DateField::Month) + 1, # Adjust for 1-indexing in Crystal Time
      get(DateField::DayOfMonth),
      get(DateField::HourOfDay),
      get(DateField::Minute),
      get(DateField::Second),
      location: Time::Location.load(get_time_zone_id())
    )
  end

  # Adds a signed amount to a specific calendar field, adjusting larger fields
  # as necessary (e.g., adding 1 day to January 31st results in February 1st).
  #
  # - `field`: The `DateField` to modify.
  # - `amount`: The signed amount to add to the field.
  def add(field : DateField, amount : Int32) : Nil
    status = LibICU::UErrorCode::UZeroError
    LibICU.ucal_add(@ucal, field, amount, pointerof(status))
    ICU.check_error!(status)
  end

  # Rolls (increments or decrements) a specific calendar field by a signed amount
  # without changing larger fields. For example, rolling the `DayOfMonth` field
  # up from 31 might result in 1, without changing the `Month`.
  #
  # - `field`: The `DateField` to roll.
  # - `amount`: The signed amount to roll the field by.
  def roll(field : DateField, amount : Int32) : Nil
    status = LibICU::UErrorCode::UZeroError
    LibICU.ucal_roll(@ucal, field, amount, pointerof(status))
    ICU.check_error!(status)
  end

  # Gets the time zone ID associated with this calendar.
  #
  # - Returns the time zone ID (e.g., "America/New_York", "UTC") as a `String`.
  def get_time_zone_id : String
    status = LibICU::UErrorCode::UZeroError

    # Pass a null buffer and size 0, so the required size is returned
    required_size = LibICU.ucal_get_time_zone_id(@ucal, nil, 0, pointerof(status))

    # U_BUFFER_OVERFLOW_ERROR is the expected status when a size is returned.
    # U_ZERO_ERROR is expected if the ID is empty (required_size will be 0).
    # Any other error status indicates a real problem.
    if (status != LibICU::UErrorCode::UBufferOverflowError) && (status != LibICU::UErrorCode::UZeroError)
      ICU.check_error!(status)
    end

    # If required_size is 0 (and status was U_ZERO_ERROR), return an empty string.
    return "" if required_size == 0

    status = LibICU::UErrorCode::UZeroError
    buff = UChars.new(required_size)
    actual_len = LibICU.ucal_get_time_zone_id(@ucal, buff, buff.size, pointerof(status))
    ICU.check_error!(status)

    buff.to_s(actual_len)
  end

  # Sets the time zone associated with this calendar.
  #
  # - `zone_id`: The time zone ID string (e.g., "America/New_York", "UTC").
  def set_time_zone(zone_id : String) : Nil
    status = LibICU::UErrorCode::UZeroError
    zone_id = zone_id.to_uchars
    LibICU.ucal_set_time_zone(@ucal, zone_id, zone_id.size, pointerof(status))
    ICU.check_error!(status)
  end

  # Checks if the calendar's current date and time fall within daylight saving time
  # for its associated time zone.
  def in_daylight_time? : Bool
    status = LibICU::UErrorCode::UZeroError
    is_daylight = LibICU.ucal_in_daylight_time(@ucal, pointerof(status))
    ICU.check_error!(status)
    is_daylight != 0 # LibICU returns 1 for true, 0 for false
  end

  # Checks if the calendar's current date and time fall within a weekend
  # for its associated locale.
  def weekend? : Bool
    weekend?(
      ICU::Date.from(
        get(DateField::Year),
        get(DateField::Month) + 1,
        get(DateField::DayOfMonth)
      )
    )
  end

  # Checks if the calendar's current date and time fall within a weekend
  # for its associated locale.
  def weekend?(year : Int32, month : Int32, day : Int32) : Bool
    weekend?(ICU::Date.from(year, month, day))
  end

  # Checks if the calendar's current date and time fall within a weekend
  # for its associated locale.
  def weekend?(date : Time) : Bool
    weekend?(ICU::Date.from(date))
  end

  # Checks if the calendar's current date and time fall within a weekend
  # for its associated locale.
  private def weekend?(udate : LibICU::UDate) : Bool
    status = LibICU::UErrorCode::UZeroError
    is_weekend = LibICU.ucal_is_weekend(@ucal, udate, pointerof(status))
    ICU.check_error!(status)
    is_weekend != 0 # LibICU returns 1 for true, 0 for false
  end

  # Checks if this calendar's configuration is equivalent to another calendar.
  # It means they have the same configuration, including time zone, locale,
  # calendar type, etc.
  # The current date and time set on the calendars are *not* considered
  # for equivalence by this method.
  #
  # - `other`: The other `ICU::Calendar` instance to compare with.
  # - Returns `true` if the calendars are equivalent in configuration, `false` otherwise.
  def equivalent?(other : self) : Bool
    LibICU.ucal_equivalent_to(@ucal, other.@ucal) != 0 # LibICU returns 1 for true, 0 for false
  end

  # Checks if this calendar's current time is strictly before the target time,
  # comparing with a granularity of seconds. Differences at the millisecond
  # or nanosecond level are ignored.
  # Uses ucal_get_field_difference internally by comparing fields from largest
  # down to seconds.
  #
  # - `target_time`: The `Time` object to compare against.
  # - Returns `true` if this calendar's time is strictly before `target_time`
  #   (at second granularity or larger fields), `false` otherwise.
  def before?(target_time : Time) : Bool
    diff_sign = diff(target_time)
    # If target_time is after the calendar's current time (at second granularity),
    # get_difference_sign returns positive. This means the calendar's current time
    # is before target_time.
    diff_sign > 0
  end

  # Checks if this calendar's current time is strictly after the target time,
  # comparing with a granularity of seconds. Differences at the millisecond
  # or nanosecond level are ignored.
  # Uses ucal_get_field_difference internally by comparing fields from largest
  # down to seconds.
  #
  # - `target_time`: The `Time` object to compare against.
  # - Returns `true` if this calendar's time is strictly after `target_time`
  #   (at second granularity or larger fields), `false` otherwise.
  def after?(target_time : Time) : Bool
    diff_sign = diff(target_time)
    # If target_time is before the calendar's current time (at second granularity),
    # get_difference_sign returns negative. This means the calendar's current time
    # is after target_time.
    diff_sign < 0
  end

  def to_unsafe
    return @ucal
  end

  # Helper method to get the first non-zero field difference sign between
  # the calendar's current time and the target time, using fields from largest
  # down to seconds.
  # Returns:
  #   > 0 if `target_time` is after the calendar's current time
  #   < 0 if `target_time` is before the calendar's current time
  #     0 if they are equivalent up to the second
  private def diff(target_time : Time) : Int32
    # Clone the calendar to avoid modifying the original instance
    status = LibICU::UErrorCode::UZeroError
    cloned_ucal = LibICU.ucal_clone(@ucal, pointerof(status))
    ICU.check_error!(status)

    target_udate = ICU::Date.from(target_time)

    begin
      FIELD_DIFFERENCE_ORDER.each do |field|
        status = LibICU::UErrorCode::UZeroError
        # ucal_get_field_difference calculates the difference and advances the calendar.
        # The sign of the difference indicates the relative position of the target.
        diff = LibICU.ucal_get_field_difference(cloned_ucal, target_udate, field, pointerof(status))
        ICU.check_error!(status)

        if diff != 0
          # The sign of the difference in the most significant field
          # indicates the relative order of target_udate vs cloned_ucal.
          # Positive diff means target_udate is after cloned_ucal.
          # Negative diff means target_udate is before cloned_ucal.
          return diff
        end
        # If diff is 0, the cloned_ucal has been advanced by 0 units of this field.
        # Continue to the next smaller field to find the first non-zero difference.
      end
    ensure # Ensure the cloned calendar is closed
      cloned_ucal.try { |cal| LibICU.ucal_close(cal) }
    end

    # If we checked all fields down to seconds and the difference was always 0,
    # the times are equivalent up to the second.
    return 0
  end
end
