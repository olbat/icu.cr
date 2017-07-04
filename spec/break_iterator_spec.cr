require "./spec_helper"

describe "ICU::BreakIterator" do
  describe "initialize" do
    it "creates a new BreakIterator" do
      ICU::BreakIterator.new("bla haha", ICU::BreakIterator::Type::Word).should_not be_nil
    end

    it "creates a new BreakIterator specifying a locale" do
      ICU::BreakIterator.new("bla haha", ICU::BreakIterator::Type::Word, "en_US").should_not be_nil
    end

    it "raises an exception if the given locale does not exist" do
      expect_raises do
        ICU::BreakIterator.new("bla haha", ICU::BreakIterator::Type::Word, "_")
      end
    end
  end

  describe "to_a" do
    it "split by word" do
      ICU::BreakIterator.new("bla haha", ICU::BreakIterator::Type::Word).to_a.should eq ["bla", " ", "haha"]
    end

    it "thai words, split by word" do
      ICU::BreakIterator.new("หน้าแรก", ICU::BreakIterator::Type::Word).to_a.should eq ["หน้า", "แรก"]
    end

    it "split by sentence" do
      ICU::BreakIterator.new("My name is Bla. Muhhahhaa....", ICU::BreakIterator::Type::Sentence).to_a.should eq ["My name is Bla. ", "Muhhahhaa...."]
    end
  end
end
