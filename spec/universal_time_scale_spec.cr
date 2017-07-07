require "./spec_helper"

describe "ICU::UniversalTimeScale" do
  describe "TIME_SCALES" do
    it "lists available IDs" do
      tss = ICU::UniversalTimeScale::TIME_SCALES
      tss[ICU::UniversalTimeScale::DateTimeScale::UnixTime]?.should_not be_nil
      ts = tss[ICU::UniversalTimeScale::DateTimeScale::DotnetDateTime]
      ts[:epoch_offset].should eq(0)
    end
  end

  describe "from" do
    it "convert a UnixTime to an UniversalTime" do
      ts = ICU::UniversalTimeScale::DateTimeScale::UnixTime
      ut = ICU::UniversalTimeScale.from(0.to_i64, ts)
      tsv = ICU::UniversalTimeScale::TIME_SCALES[ts]
      ut.should eq(tsv[:epoch_offset] * 10**7)
    end

    it "convert an UnixTime back using to" do
      ts = ICU::UniversalTimeScale::DateTimeScale::UnixTime
      tsv = ICU::UniversalTimeScale::TIME_SCALES[ts]
      val = 0.to_i64
      ut = ICU::UniversalTimeScale.to(val, ts)
      ICU::UniversalTimeScale.from(ut, ts).should eq(val)
    end
  end

  describe "to" do
    it "convert an UniversalTime to a UnixTime" do
      ts = ICU::UniversalTimeScale::DateTimeScale::UnixTime
      tsv = ICU::UniversalTimeScale::TIME_SCALES[ts]
      ut = ICU::UniversalTimeScale.to(tsv[:epoch_offset] * 10**7, ts)
      ut.should eq(0.to_i64)
    end

    it "convert an UnixTime back using from" do
      ts = ICU::UniversalTimeScale::DateTimeScale::UnixTime
      tsv = ICU::UniversalTimeScale::TIME_SCALES[ts]
      val = 0.to_i64
      ut = ICU::UniversalTimeScale.from(val, ts)
      ICU::UniversalTimeScale.to(ut, ts).should eq(val)
    end
  end
end
