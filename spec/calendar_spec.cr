require "./spec_helper"

describe ICU::Calendar do
  # Test ucal_open and ucal_close
  context "test constructors" do
    it "should open and close a calendar successfully with default timezone/locale/type" do
      calendar = ICU::Calendar.new
      calendar.should_not be_nil
      calendar.get_time_zone_id.should_not be_empty
    end

    it "should open and close a calendar successfully with specific timezone/locale/type" do
      calendar = ICU::Calendar.new("Europe/Paris", "en_US", ICU::Calendar::Type::Default)
      calendar.should_not be_nil
      calendar.get_time_zone_id.should eq "Europe/Paris"
    end

    it "should open and close a calendar successfully with specific timezone/locale/type" do
      calendar = ICU::Calendar.new(Time::Location.load("Europe/Berlin"), "en_US", ICU::Calendar::Type::Default)
      calendar.should_not be_nil
      calendar.get_time_zone_id.should eq "Europe/Berlin"
    end

    it "should open with system default timezone and locale when using empty strings" do
      calendar = ICU::Calendar.new("", "")
      calendar.should_not be_nil
      calendar.get_time_zone_id.should_not be_empty
    end

    it "should initialize from Time with UTC timezone" do
      time = Time.utc(2025, 4, 29, 10, 20, 30)
      calendar = ICU::Calendar.new(time)

      calendar.get_time_zone_id.should eq("UTC")
      calendar.get(ICU::Calendar::DateField::Year).should eq(2025)
      calendar.get(ICU::Calendar::DateField::Month).should eq(3) # April
      calendar.get(ICU::Calendar::DateField::DayOfMonth).should eq(29)
      calendar.get(ICU::Calendar::DateField::HourOfDay).should eq(10)
      calendar.get(ICU::Calendar::DateField::Minute).should eq(20)
      calendar.get(ICU::Calendar::DateField::Second).should eq(30)
      calendar.get(ICU::Calendar::DateField::Millisecond).should eq(0)

      calendar.get_millis.should eq 1745922030000
    end

    it "should initialize from Time with custom timezone" do
      time = Time.local(2025, 4, 29, 10, 20, 30, location: Time::Location.load("Europe/Berlin"))
      calendar = ICU::Calendar.new(time)

      calendar.get_time_zone_id.should eq("Europe/Berlin")
      calendar.get(ICU::Calendar::DateField::Year).should eq(2025)
      calendar.get(ICU::Calendar::DateField::Month).should eq(3) # April
      calendar.get(ICU::Calendar::DateField::DayOfMonth).should eq(29)
      calendar.get(ICU::Calendar::DateField::HourOfDay).should eq(10)
      calendar.get(ICU::Calendar::DateField::Minute).should eq(20)
      calendar.get(ICU::Calendar::DateField::Second).should eq(30)
      calendar.get(ICU::Calendar::DateField::Millisecond).should eq(0)

      calendar.get_millis.should eq 1745914830000
    end
  end

  # Test ucal_set_millis and ucal_get_millis
  it "should set and get time in milliseconds" do
    calendar = ICU::Calendar.new("UTC", "en_US")
    calendar.set_millis(1745922030000)
    calendar.get_millis.should eq 1745922030000
  end

  # Test ucal_set and ucal_get
  it "should set and get calendar fields" do
    calendar = ICU::Calendar.new("UTC", "en_US") # Use UTC to avoid timezone issues in test
    calendar.set(ICU::Calendar::DateField::Year, 2025)
    calendar.set(ICU::Calendar::DateField::Month, 3) # Month is 0-indexed in ICU (April)
    calendar.set(ICU::Calendar::DateField::DayOfMonth, 29)
    calendar.set(ICU::Calendar::DateField::HourOfDay, 10)
    calendar.set(ICU::Calendar::DateField::Minute, 30)
    calendar.set(ICU::Calendar::DateField::Second, 0)

    calendar.get(ICU::Calendar::DateField::Year).should eq(2025)
    calendar.get(ICU::Calendar::DateField::Month).should eq(3)
    calendar.get(ICU::Calendar::DateField::DayOfMonth).should eq(29)
    calendar.get(ICU::Calendar::DateField::HourOfDay).should eq(10)
    calendar.get(ICU::Calendar::DateField::Minute).should eq(30)
    calendar.get(ICU::Calendar::DateField::Second).should eq(0)
  end

  it "should raise ArgumentError for invalid field values in set(field, value)" do
    calendar = ICU::Calendar.new("UTC", "en_US")

    # Test invalid Month (0-indexed, so valid is 0-11)
    expect_raises(ArgumentError, /Invalid value '-1' for date time field\. Must be between 0 and 11 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::Month, -1)
    end
    expect_raises(ArgumentError, /Invalid value '12' for date time field\. Must be between 0 and 11 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::Month, 12)
    end

    # Set a valid month first to test DayOfMonth limits
    calendar.set(ICU::Calendar::DateField::Month, 1) # February
    # Test invalid DayOfMonth (depends on month and year, but 0 and >31 are generally invalid)
    expect_raises(ArgumentError, /Invalid value '0' for date time field\. Must be between 1 and 31 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::DayOfMonth, 0)
    end
    expect_raises(ArgumentError, /Invalid value '32' for date time field\. Must be between 1 and 31 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::DayOfMonth, 32)
    end

    # Test invalid HourOfDay (0-23)
    expect_raises(ArgumentError, /Invalid value '-1' for date time field\. Must be between 0 and 23 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::HourOfDay, -1)
    end
    expect_raises(ArgumentError, /Invalid value '24' for date time field\. Must be between 0 and 23 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::HourOfDay, 24)
    end

    # Test invalid Minute (0-59)
    expect_raises(ArgumentError, /Invalid value '-1' for date time field\. Must be between 0 and 59 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::Minute, -1)
    end
    expect_raises(ArgumentError, /Invalid value '60' for date time field\. Must be between 0 and 59 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::Minute, 60)
    end

    # Test invalid Second (0-59)
    expect_raises(ArgumentError, /Invalid value '-1' for date time field\. Must be between 0 and 59 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::Second, -1)
    end
    expect_raises(ArgumentError, /Invalid value '60' for date time field\. Must be between 0 and 59 \(included\)/) do
      calendar.set(ICU::Calendar::DateField::Second, 60)
    end
  end

  it "should set all calendar fields" do
    calendar = ICU::Calendar.new("UTC", "en_US")
    calendar.set(2025, 3, 29, 10, 20, 30)

    calendar.get(ICU::Calendar::DateField::Year).should eq(2025)
    calendar.get(ICU::Calendar::DateField::Month).should eq(2)
    calendar.get(ICU::Calendar::DateField::DayOfMonth).should eq(29)
    calendar.get(ICU::Calendar::DateField::HourOfDay).should eq(10)
    calendar.get(ICU::Calendar::DateField::Minute).should eq(20)
    calendar.get(ICU::Calendar::DateField::Second).should eq(30)
  end

  it "should set all calendar fields with default" do
    calendar = ICU::Calendar.new("UTC", "en_US")
    calendar.set(2025, 3, 29)

    calendar.get(ICU::Calendar::DateField::Year).should eq(2025)
    calendar.get(ICU::Calendar::DateField::Month).should eq(2)
    calendar.get(ICU::Calendar::DateField::DayOfMonth).should eq(29)
    calendar.get(ICU::Calendar::DateField::HourOfDay).should eq(0)
    calendar.get(ICU::Calendar::DateField::Minute).should eq(0)
    calendar.get(ICU::Calendar::DateField::Second).should eq(0)
  end

  it "should set from Time with custom timezone" do
    time = Time.local(2025, 4, 29, 10, 20, 30, location: Time::Location.load("Europe/Berlin"))
    calendar = ICU::Calendar.new("UTC", "en_US")

    calendar.set(time)

    calendar.get_time_zone_id.should eq("Europe/Berlin")
    calendar.get(ICU::Calendar::DateField::Year).should eq(2025)
    calendar.get(ICU::Calendar::DateField::Month).should eq(3) # April
    calendar.get(ICU::Calendar::DateField::DayOfMonth).should eq(29)
    calendar.get(ICU::Calendar::DateField::HourOfDay).should eq(10)
    calendar.get(ICU::Calendar::DateField::Minute).should eq(20)
    calendar.get(ICU::Calendar::DateField::Second).should eq(30)
    calendar.get(ICU::Calendar::DateField::Millisecond).should eq(0)

    calendar.get_millis.should eq 1745914830000
  end

  it "returns the current calendar as a Crystal Time object" do
    calendar = ICU::Calendar.new("Europe/Berlin", "en_US")
    calendar.set_millis(1745914830000)
    calendar.get_time.should eq Time.local(2025, 4, 29, 10, 20, 30, location: Time::Location.load("Europe/Berlin"))
  end

  # Test ucal_add
  it "should add to calendar fields" do
    calendar = ICU::Calendar.new("UTC", "en_US")
    calendar.set(ICU::Calendar::DateField::Year, 2025)
    calendar.set(ICU::Calendar::DateField::Month, 3) # April
    calendar.set(ICU::Calendar::DateField::DayOfMonth, 29)

    calendar.add(ICU::Calendar::DateField::DayOfMonth, 1)
    calendar.get(ICU::Calendar::DateField::DayOfMonth).should eq(30)

    calendar.add(ICU::Calendar::DateField::Month, 1)
    calendar.get(ICU::Calendar::DateField::Month).should eq(4) # May

    calendar.add(ICU::Calendar::DateField::Year, 1)
    calendar.get(ICU::Calendar::DateField::Year).should eq(2026)
  end

  # Test ucal_roll
  it "should roll calendar fields" do
    calendar = ICU::Calendar.new("UTC", "en_US")
    calendar.set(ICU::Calendar::DateField::Year, 2025)
    calendar.set(ICU::Calendar::DateField::Month, 3) # April
    calendar.set(ICU::Calendar::DateField::DayOfMonth, 29)

    calendar.roll(ICU::Calendar::DateField::DayOfMonth, 3)
    # April has 30 days, so rolling 3 days from 29 takes us to 2
    calendar.get(ICU::Calendar::DateField::DayOfMonth).should eq(2)
    # Rolling day should not affect month or year
    calendar.get(ICU::Calendar::DateField::Month).should eq(3)
    calendar.get(ICU::Calendar::DateField::Year).should eq(2025)
  end

  # Test ucal_get_time_zone_id and ucal_set_time_zone
  it "should get and set the time zone" do
    calendar = ICU::Calendar.new("UTC", "en_US")
    calendar.get_time_zone_id.should eq("UTC")

    calendar.set_time_zone("America/New_York")
    calendar.get_time_zone_id.should eq("America/New_York")
  end

  # Test ucal_in_daylight_time
  it "should indicate if in daylight time" do
    # This test might be time-sensitive depending on when it's run and the system's timezone.
    # Using a known timezone that observe DST for demonstration.
    calendar = ICU::Calendar.new("America/New_York", "en_US")
    # As of the current date (April 29, 2025), New York is in DST
    # Note: This assumes the ICU data includes correct DST information for America/New_York in 2025
    calendar.set(ICU::Calendar::DateField::Year, 2025)
    calendar.set(ICU::Calendar::DateField::Month, 3) # April
    calendar.set(ICU::Calendar::DateField::DayOfMonth, 29)
    calendar.set(ICU::Calendar::DateField::HourOfDay, 12)

    calendar.in_daylight_time?.should be_true # Should be in DST in April

    calendar.set(ICU::Calendar::DateField::Month, 0) # January
    calendar.set(ICU::Calendar::DateField::DayOfMonth, 15)

    calendar.in_daylight_time?.should be_false # Should not be in DST in January
  end

  # Test ucal_is_weelkend
  it "should indicate if in weekend time" do
    calendar = ICU::Calendar.new("Europe/Paris", "en_US")

    calendar.set(2025, 5, 2)
    calendar.weekend?.should be_false
    calendar.weekend?(2025, 5, 2).should be_false
    calendar.weekend?(Time.utc(2025, 5, 2)).should be_false

    calendar.set(2025, 5, 3)
    calendar.weekend?.should be_true
    calendar.weekend?(2025, 5, 3).should be_true
    calendar.weekend?(Time.utc(2025, 5, 3)).should be_true
  end

  # Test ucal_equivalentTo
  it "should check if calendars are equivalent based on configuration" do
    # Calendars with the same configuration but different times should be equivalent
    calendar = ICU::Calendar.new("UTC", "en_US")
    calendar.set(2025, 4, 29, 10, 30, 0)

    ICU::Calendar.new("UTC", "en_US").equivalent?(calendar).should be_true
    ICU::Calendar.new("America/New_York", "en_US").equivalent?(calendar).should be_false
    ICU::Calendar.new("UTC", "fr_FR").equivalent?(calendar).should be_false
  end

  # Test ucal_get_field_difference based methods (before?, after?)
  it "should correctly determine if a time is before or after using field difference (second granularity)" do
    calendar = ICU::Calendar.new("UTC", "en_US")
    calendar.set(2025, 4, 29, 10, 0, 0) # Set calendar to 2025-04-29 10:00:00 UTC

    # Target time before calendar time
    target_before_hour = Time.utc(2025, 4, 29, 9, 0, 0)
    calendar.before?(target_before_hour).should be_false
    calendar.after?(target_before_hour).should be_true

    target_before_day = Time.utc(2025, 4, 28, 10, 0, 0)
    calendar.before?(target_before_day).should be_false
    calendar.after?(target_before_day).should be_true

    # Target time with same second but different nanoseconds (should be considered equal at second granularity)
    target_same_second_before_ns = Time.utc(2025, 4, 29, 10, 0, 0) + 1.nanoseconds
    calendar.before?(target_same_second_before_ns).should be_false
    calendar.after?(target_same_second_before_ns).should be_false

    # Target time after calendar time
    target_after_hour = Time.utc(2025, 4, 29, 11, 0, 0)
    calendar.before?(target_after_hour).should be_true
    calendar.after?(target_after_hour).should be_false

    target_after_day = Time.utc(2025, 4, 30, 10, 0, 0)
    calendar.before?(target_after_day).should be_true
    calendar.after?(target_after_day).should be_false

    # Target time with same second but different nanoseconds (should be considered equal at second granularity)
    target_same_second_after_ns = Time.utc(2025, 4, 29, 10, 0, 0) + 999_999_999.nanoseconds
    calendar.before?(target_same_second_after_ns).should be_false
    calendar.after?(target_same_second_after_ns).should be_false

    # Target time equal to calendar time (exactly)
    target_equal = Time.utc(2025, 4, 29, 10, 0, 0)
    calendar.before?(target_equal).should be_false
    calendar.after?(target_equal).should be_false

    # Test with different timezones - comparison should be based on absolute time
    cal_utc_time = Time.utc(2025, 4, 29, 10, 0, 0) # UTC 10:00
    cal_berlin = ICU::Calendar.new("Europe/Berlin", "en_US")
    cal_berlin.set(cal_utc_time) # Set Berlin calendar to UTC 10:00 (which is 12:00 Berlin time)

    target_utc_09 = Time.utc(2025, 4, 29, 9, 0, 0)  # UTC 09:00 (before cal_utc_time)
    target_utc_11 = Time.utc(2025, 4, 29, 11, 0, 0) # UTC 11:00 (after cal_utc_time)
    target_utc_10 = Time.utc(2025, 4, 29, 10, 0, 0) # UTC 10:00 (equal to cal_utc_time)

    # Test Berlin calendar (set to UTC 10:00) against UTC targets
    # The comparison should be based on the absolute time instant (UTC 10:00)
    cal_berlin.before?(target_utc_09).should be_false # UTC 10:00 is not before UTC 09:00
    cal_berlin.after?(target_utc_09).should be_true   # UTC 10:00 is after UTC 09:00

    cal_berlin.before?(target_utc_11).should be_true # UTC 10:00 is before UTC 11:00
    cal_berlin.after?(target_utc_11).should be_false # UTC 10:00 is not after UTC 11:00

    cal_berlin.before?(target_utc_10).should be_false # UTC 10:00 is not before UTC 10:00
    cal_berlin.after?(target_utc_10).should be_false  # UTC 10:00 is not after UTC 10:00
  end
end
