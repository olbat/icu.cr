require "./spec_helper"

describe "ICU::BreakIterator" do
  describe "initialize" do
    it "creates a new BreakIterator" do
      ICU::BreakIterator.new(ICU::BreakIterator::Type::Word).should_not be_nil
    end

    it "creates a new BreakIterator specifying some text" do
      ICU::BreakIterator.new("bla haha", ICU::BreakIterator::Type::Word).should_not be_nil
    end

    it "creates a new BreakIterator specifying a locale" do
      ICU::BreakIterator.new("bla haha", ICU::BreakIterator::Type::Word, "en_US").should_not be_nil
    end

    it "raises an exception if the given locale does not exist" do
      expect_raises(ICU::Error) do
        ICU::BreakIterator.new("bla haha", ICU::BreakIterator::Type::Word, "_")
      end
    end
  end

  describe "text" do
    it "returns the text being iterated on" do
      brk = ICU::BreakIterator.new("abc def", ICU::BreakIterator::Type::Word)
      brk.text.should eq("abc def".to_uchars)
    end
  end

  describe "text=" do
    it "set the text to iterate on" do
      brk = ICU::BreakIterator.new("abc def", ICU::BreakIterator::Type::Word)

      brk.text = "bla haha"
      brk.text.should eq("bla haha".to_uchars)
      brk.to_a.should eq(["bla", " ", "haha"])

      brk.text = "abc def"
      brk.text.should eq("abc def".to_uchars)
      brk.to_a.should eq(["abc", " ", "def"])
    end
  end

  describe "to_a" do
    it "split by word" do
      ICU::BreakIterator.new("bla haha", ICU::BreakIterator::Type::Word).to_a.should eq(["bla", " ", "haha"])
    end

    it "thai words, split by word" do
      ICU::BreakIterator.new("หน้าแรก", ICU::BreakIterator::Type::Word).to_a.should eq(["หน้า", "แรก"])
    end

    it "split by sentence" do
      ICU::BreakIterator.new("My name is Bla. Muhhahhaa....", ICU::BreakIterator::Type::Sentence).to_a.should eq(["My name is Bla. ", "Muhhahhaa...."])
    end
  end
end
