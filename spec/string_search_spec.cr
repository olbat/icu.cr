require "./spec_helper"

describe "ICU::StringSearch" do
  describe "initialize" do
    it "creates a new Search whithout specifying a locale" do
      ICU::StringSearch.new("ab", "abc").should_not be_nil
    end

    it "creates a new Search specifying a locale" do
      ICU::StringSearch.new("ab", "abc", "en_US").should_not be_nil
    end

    it "creates a new Search specifying a basic Collator" do
      col = ICU::Collator.new
      ICU::StringSearch.new("ab", "abc", col).should_not be_nil
    end

    it "creates a new Search specifying a specific Collator" do
      col = ICU::Collator.new("de_DE")
      col.strength = ICU::Collator::Strength::Primary
      search = ICU::StringSearch.new("ß", "xxxSSxxx", col)
      search.should_not be_nil
      search.next.should eq(3...5)
    end

    it "creates a new Search specifying a Collator and a Character BreakIterator" do
      col = ICU::Collator.new
      brk = ICU::BreakIterator.new(ICU::BreakIterator::Type::Character)
      search = ICU::StringSearch.new("ab", "xxx abc xxx", col, brk)
      search.should_not be_nil
      search.next.should eq(4...6)
    end

    it "creates a new Search specifying a Collator and a Word BreakIterator" do
      col = ICU::Collator.new
      brk = ICU::BreakIterator.new(ICU::BreakIterator::Type::Word)
      search = ICU::StringSearch.new("ab", "xxx abc xxx", col, brk)
      search.should_not be_nil
      search.next.should eq(Iterator::Stop::INSTANCE)
      search.text = "xxx ab xxx"
      search.next.should eq(4...6)
    end
  end

  describe "[]" do
    it "returns the value of the specified attribute" do
      search = ICU::StringSearch.new("ab", "abc")
      search[ICU::StringSearch::Attribute::Overlap] = ICU::StringSearch::OFF
      search[ICU::StringSearch::Attribute::Overlap] = ICU::StringSearch::ON
      search[ICU::StringSearch::Attribute::Overlap].should eq(ICU::StringSearch::ON)
    end
  end

  describe "[]=" do
    it "set a value to the specified attribute" do
      search = ICU::StringSearch.new("ab", "abc")
      search[ICU::StringSearch::Attribute::Overlap] = ICU::StringSearch::OFF
      search[ICU::StringSearch::Attribute::Overlap].should eq(ICU::StringSearch::OFF)
      search[ICU::StringSearch::Attribute::Overlap] = ICU::StringSearch::ON
      search[ICU::StringSearch::Attribute::Overlap].should eq(ICU::StringSearch::ON)
    end

    it "set a value to the specified attribute and change the behavior of the search object" do
      search = ICU::StringSearch.new("bb", "abbbc")

      search[ICU::StringSearch::Attribute::Overlap] = ICU::StringSearch::OFF
      search.to_a.should eq([(1...3)])

      search.rewind
      search[ICU::StringSearch::Attribute::Overlap] = ICU::StringSearch::ON
      search.to_a.should eq([(1...3), (2...4)])
    end
  end

  describe "pattern" do
    it "returns the value of the pattern" do
      pat = "ab"
      search = ICU::StringSearch.new(pat, "abc")
      search.pattern.should eq(pat)
    end
  end

  describe "pattern=" do
    it "set a value to the pattern" do
      search = ICU::StringSearch.new("a", "abc")
      pat = "ab"
      search.pattern = pat
      search.pattern.should eq(pat)
    end
  end

  describe "text" do
    it "returns the value of the text" do
      text = "abc"
      search = ICU::StringSearch.new("ab", text)
      search.text.should eq(text)
    end
  end

  describe "text=" do
    it "set a value to the text" do
      search = ICU::StringSearch.new("ab", "ab")
      text = "abc"
      search.text = text
      search.text.should eq(text)
    end
  end

  describe "offset" do
    it "returns the value of the offset" do
      search = ICU::StringSearch.new("abc", "xxxabcxxxabcxxx")
      search.offset.should eq(0)
      offset = search.first.not_nil!
      search.offset.should eq(offset.begin)
    end
  end

  describe "offset=" do
    it "set a value to the offset" do
      search = ICU::StringSearch.new("abc", "xxxabcxxxabcxxx")
      offset = 6
      search.offset = offset
      search.offset.should eq(offset)
    end
  end

  describe "collator" do
    it "returns the value of the collator" do
      col = ICU::Collator.new
      search = ICU::StringSearch.new("ab", "abc", col)
      search.collator.should eq(col)
    end
  end

  describe "collator=" do
    it "set a value to the collator" do
      search = ICU::StringSearch.new("aa", "ab", ICU::Collator.new)
      col = ICU::Collator.new("&b = a".to_uchars)
      search.collator = col
      search.collator.should eq(col)
      search.next.should eq(0...2)
    end
  end

  describe "next" do
    it "returns the position of each matching patterns" do
      search = ICU::StringSearch.new("abc", "abcxxxabcxxxabcxxxabc")
      search.next.should eq(0...3)
      search.next.should eq(6...9)
      search.next.should eq(12...15)
      search.next.should eq(18...21)
      search.next.should eq(Iterator::Stop::INSTANCE)
      search.next.should eq(Iterator::Stop::INSTANCE)
      search.previous.should eq(18...21)
    end

    it "returns Iterator::Stop if there is no matching patterns" do
      search = ICU::StringSearch.new("d", "abc")
      search.next.should eq(Iterator::Stop::INSTANCE)
      search.next.should eq(Iterator::Stop::INSTANCE)
    end
  end

  describe "previous" do
    it "returns the position of each matching patterns" do
      text = "abcxxxabcxxxabcxxxabc"
      search = ICU::StringSearch.new("abc", text)
      search.offset = text.size
      search.previous.should eq(18...21)
      search.previous.should eq(12...15)
      search.previous.should eq(6...9)
      search.previous.should eq(0...3)
      search.previous.should eq(Iterator::Stop::INSTANCE)
      search.previous.should eq(Iterator::Stop::INSTANCE)
      search.next.should eq(0...3)
    end

    it "returns Iterator::Stop if there is no matching patterns" do
      search = ICU::StringSearch.new("d", "abc")
      search.previous.should eq(Iterator::Stop::INSTANCE)
      search.previous.should eq(Iterator::Stop::INSTANCE)
    end
  end

  describe "rewind" do
    it "resets the position of the cursor" do
      search = ICU::StringSearch.new("abc", "abcxxxabcxxxabcxxxabc")
      search.next.should eq(0...3)
      search.rewind
      search.next.should eq(0...3)
    end
  end

  describe "reset" do
    it "resets the search object" do
      search = ICU::StringSearch.new("abc", "abcxxxabcxxxabcxxxabc")
      default_overlap = search[ICU::StringSearch::Attribute::Overlap]

      overlap = case default_overlap
                when ICU::StringSearch::ON  then ICU::StringSearch::OFF
                when ICU::StringSearch::OFF then ICU::StringSearch::ON
                else                             ICU::StringSearch::ON
                end
      search[ICU::StringSearch::Attribute::Overlap] = overlap
      search.next

      search.reset
      search.offset.should eq(0)
      search.next.should eq(0...3)
      search[ICU::StringSearch::Attribute::Overlap].should eq(default_overlap)
    end
  end

  describe "first" do
    it "returns the position of the first occurence of pattern" do
      search = ICU::StringSearch.new("abc", "abcxxxabcxxxabcxxxabc")
      search.first.should eq(0...3)
    end

    it "returns nil if there is no matching patterns" do
      ICU::StringSearch.new("d", "abc").first.should be_nil
    end
  end

  describe "last" do
    it "returns the position of the last occurence of pattern" do
      search = ICU::StringSearch.new("abc", "abcxxxabcxxxabcxxxabc")
      search.last.should eq(18...21)
    end

    it "returns nil if there is no matching patterns" do
      ICU::StringSearch.new("d", "abc").last.should be_nil
    end
  end

  describe "preceding" do
    it "returns the position of the occurence of pattern before a given position" do
      search = ICU::StringSearch.new("abc", "abcxxxabcxxxabcxxxabc")
      search.preceding(4).should eq(0...3)
    end

    it "returns nil if there is no matching patterns" do
      ICU::StringSearch.new("c", "abc").preceding(1).should be_nil
    end
  end

  describe "following" do
    it "returns the position of the occurence of pattern after a given position" do
      search = ICU::StringSearch.new("abc", "abcxxxabcxxxabcxxxabc")
      search.following(1).should eq(6...9)
    end

    it "returns nil if there is no matching patterns" do
      ICU::StringSearch.new("a", "abc").following(1).should be_nil
    end
  end
end
