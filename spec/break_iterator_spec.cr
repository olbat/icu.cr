require "./spec_helper"

describe "ICU::BreakIterator" do
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
