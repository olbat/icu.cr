require "./spec_helper"

describe "ICU::Currencies" do
  describe "currency" do
    it "returns the currency for a specified locale" do
      ICU::Currencies.currency("fr_FR").should eq("EUR")
    end

    it "raises if the locale is unknown" do
      expect_raises(ICU::Error) do
        ICU::Currencies.currency("_unknown_")
      end
    end
  end

  describe "numeric_code" do
    it "returns the code associated to a currency" do
      ICU::Currencies.numeric_code("EUR").should eq(978)
    end

    it "raises if the currency is unknown" do
      expect_raises(ICU::Error) do
        ICU::Currencies.numeric_code("_unknown_")
      end
    end
  end
end
