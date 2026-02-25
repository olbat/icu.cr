require "./spec_helper"

describe "ICU::Regex" do
  describe "initialize" do
    it "creates a new regex from a pattern" do
      ICU::Regex.new("\\d+").should_not be_nil
    end

    it "creates a new regex with flags" do
      ICU::Regex.new("hello", ICU::Regex::Flag::CaseInsensitive).should_not be_nil
    end

    it "raises an error for an invalid pattern" do
      expect_raises(ICU::Error) do
        ICU::Regex.new("[invalid")
      end
    end
  end

  describe "pattern" do
    it "returns the pattern string" do
      ICU::Regex.new("\\d+").pattern.should eq("\\d+")
    end
  end

  describe "flags" do
    it "returns the flags" do
      re = ICU::Regex.new("hello", ICU::Regex::Flag::CaseInsensitive)
      re.flags.should eq(ICU::Regex::Flag::CaseInsensitive)
    end

    it "defaults to no flags" do
      ICU::Regex.new("hello").flags.should eq(ICU::Regex::Flag::None)
    end
  end

  describe "matches?" do
    it "returns true when the entire string matches" do
      ICU::Regex.new("\\d+").matches?("42").should be_true
    end

    it "returns false when the string does not fully match" do
      ICU::Regex.new("\\d+").matches?("42px").should be_false
    end

    it "returns false when there is no match at all" do
      ICU::Regex.new("\\d+").matches?("abc").should be_false
    end

    it "respects the CaseInsensitive flag" do
      ICU::Regex.new("hello", ICU::Regex::Flag::CaseInsensitive).matches?("HELLO").should be_true
    end

    it "works with unicode input" do
      ICU::Regex.new("\\p{L}+").matches?("héllo").should be_true
    end
  end

  describe "match" do
    it "returns a Match object when the pattern is found" do
      m = ICU::Regex.new("\\d+").match("foo 42")
      m.should_not be_nil
    end

    it "returns nil when the pattern is not found" do
      ICU::Regex.new("\\d+").match("abc").should be_nil
    end

    it "returns the matched text via group(0)" do
      m = ICU::Regex.new("\\d+").match("foo 42 bar")
      m.not_nil!.group(0).should eq("42")
    end

    it "returns captured groups" do
      m = ICU::Regex.new("(\\w+)@(\\w+\\.\\w+)").match("user@example.com")
      m.should_not be_nil
      m.not_nil!.group(0).should eq("user@example.com")
      m.not_nil!.group(1).should eq("user")
      m.not_nil!.group(2).should eq("example.com")
    end

    it "returns named capture groups" do
      m = ICU::Regex.new("(?<user>\\w+)@(?<domain>\\w+\\.\\w+)").match("user@example.com")
      m.should_not be_nil
      m.not_nil!.group("user").should eq("user")
      m.not_nil!.group("domain").should eq("example.com")
    end

    it "returns the first match when there are multiple" do
      m = ICU::Regex.new("\\d+").match("foo 42 bar 7")
      m.not_nil!.group(0).should eq("42")
    end
  end

  describe "ICU::Regex::Match" do
    describe "group_count" do
      it "returns the number of capture groups" do
        m = ICU::Regex.new("(a)(b)(c)").match("abc")
        m.not_nil!.group_count.should eq(3)
      end

      it "returns 0 when there are no capture groups" do
        m = ICU::Regex.new("abc").match("abc")
        m.not_nil!.group_count.should eq(0)
      end
    end

    describe "begin / end / range" do
      it "returns the start offset of the match" do
        m = ICU::Regex.new("\\d+").match("foo 42")
        m.not_nil!.begin(0).should eq(4)
      end

      it "returns the end offset of the match" do
        m = ICU::Regex.new("\\d+").match("foo 42")
        m.not_nil!.end(0).should eq(6)
      end

      it "returns the range of the match" do
        m = ICU::Regex.new("\\d+").match("foo 42")
        m.not_nil!.range.should eq(4...6)
      end

      it "returns the range of a capture group" do
        m = ICU::Regex.new("(\\d+)").match("foo 42")
        m.not_nil!.range(1).should eq(4...6)
      end
    end

    describe "to_s" do
      it "returns the full match text" do
        m = ICU::Regex.new("\\d+").match("foo 42")
        m.not_nil!.to_s.should eq("42")
      end
    end
  end

  describe "scan (block)" do
    it "yields each match in turn" do
      results = [] of String
      ICU::Regex.new("\\d+").scan("a1 b22 c3") { |m| results << m.group(0).not_nil! }
      results.should eq(["1", "22", "3"])
    end

    it "yields nothing when there are no matches" do
      count = 0
      ICU::Regex.new("\\d+").scan("abc") { count += 1 }
      count.should eq(0)
    end
  end

  describe "scan (array)" do
    it "returns all match strings" do
      ICU::Regex.new("\\d+").scan("a1 b22 c3").should eq(["1", "22", "3"])
    end

    it "returns an empty array when there are no matches" do
      ICU::Regex.new("\\d+").scan("abc").should eq([] of String)
    end
  end

  describe "split" do
    it "splits on the pattern" do
      ICU::Regex.new("\\s+").split("foo  bar baz").should eq(["foo", "bar", "baz"])
    end

    it "splits on a literal separator" do
      ICU::Regex.new(",").split("a,b,c").should eq(["a", "b", "c"])
    end

    it "returns the original string when there are no matches" do
      ICU::Regex.new("\\d+").split("abc").should eq(["abc"])
    end
  end

  describe "replace_first" do
    it "replaces the first occurrence" do
      ICU::Regex.new("\\d+").replace_first("foo 42 bar 7", "N").should eq("foo N bar 7")
    end

    it "leaves the string unchanged when there is no match" do
      ICU::Regex.new("\\d+").replace_first("abc", "N").should eq("abc")
    end

    it "supports backreferences in the replacement" do
      ICU::Regex.new("(\\w+)").replace_first("hello world", "[$1]").should eq("[hello] world")
    end
  end

  describe "replace_all" do
    it "replaces all occurrences" do
      ICU::Regex.new("\\d+").replace_all("foo 42 bar 7", "N").should eq("foo N bar N")
    end

    it "leaves the string unchanged when there is no match" do
      ICU::Regex.new("\\d+").replace_all("abc", "N").should eq("abc")
    end

    it "supports backreferences in the replacement" do
      ICU::Regex.new("(\\w+)").replace_all("hello world", "[$1]").should eq("[hello] [world]")
    end
  end

  describe "text=" do
    it "sets the input text and resets search position" do
      re = ICU::Regex.new("\\d+")
      re.text = "foo 42"
      re.text.should eq("foo 42")
    end
  end
end
