require "./spec_helper"

describe "ICU" do
  describe "check_error!" do
    it "doesn't raise when the status is OK" do
      ustatus = LibICU::UErrorCode::UZeroError
      ICU.check_error!(ustatus)
    end

    it "raises when the status is not OK" do
      ustatus = LibICU::UErrorCode::UIllegalArgumentError
      expect_raises(ICU::Error) do
        ICU.check_error!(ustatus)
      end
    end
  end
end
