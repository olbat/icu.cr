require "./spec_helper"

describe "ICU::USet" do
  describe "initialize" do
    it "creates an empty set" do
      ICU::USet.new.should_not be_nil
    end

    it "creates a set from a character range" do
      ICU::USet.new('a', 'z').should_not be_nil
    end

    it "creates a set from a UnicodeSet pattern" do
      ICU::USet.new("[aeiou]").should_not be_nil
    end

    it "raises an error for an invalid pattern" do
      expect_raises(ICU::Error) do
        ICU::USet.new("[invalid")
      end
    end
  end

  describe "size" do
    it "returns 0 for an empty set" do
      ICU::USet.new.size.should eq(0)
    end

    it "returns the correct count for a range" do
      ICU::USet.new('a', 'z').size.should eq(26)
    end

    it "returns the correct count for a pattern" do
      ICU::USet.new("[aeiou]").size.should eq(5)
    end
  end

  describe "empty?" do
    it "returns true for a new empty set" do
      ICU::USet.new.empty?.should be_true
    end

    it "returns false for a non-empty set" do
      ICU::USet.new('a', 'z').empty?.should be_false
    end
  end

  describe "includes?(Char)" do
    it "returns true for a member character" do
      ICU::USet.new('a', 'z').includes?('m').should be_true
    end

    it "returns false for a non-member character" do
      ICU::USet.new('a', 'z').includes?('M').should be_false
    end
  end

  describe "includes_all_of?" do
    it "returns true when all characters are in the set" do
      ICU::USet.new('a', 'z').includes_all_of?("hello").should be_true
    end

    it "returns false when any character is absent" do
      ICU::USet.new('a', 'z').includes_all_of?("Hello").should be_false
    end
  end

  describe "add(Char)" do
    it "adds a character to the set" do
      s = ICU::USet.new
      s.add('x')
      s.includes?('x').should be_true
    end

    it "returns self for chaining" do
      s = ICU::USet.new
      s.add('a').add('b')
      s.size.should eq(2)
    end
  end

  describe "add_range" do
    it "adds a range of characters" do
      s = ICU::USet.new
      s.add_range('a', 'c')
      s.size.should eq(3)
      s.includes?('b').should be_true
    end
  end

  describe "remove(Char)" do
    it "removes a character from the set" do
      s = ICU::USet.new('a', 'c')
      s.remove('b')
      s.includes?('b').should be_false
      s.size.should eq(2)
    end
  end

  describe "remove_range" do
    it "removes a range of characters" do
      s = ICU::USet.new('a', 'f')
      s.remove_range('b', 'd')
      s.size.should eq(3)
      s.includes?('a').should be_true
      s.includes?('b').should be_false
    end
  end

  describe "add_all" do
    it "adds all members of another set (union)" do
      a = ICU::USet.new('a', 'c')
      b = ICU::USet.new('d', 'f')
      a.add_all(b)
      a.size.should eq(6)
      a.includes?('e').should be_true
    end
  end

  describe "remove_all" do
    it "removes all members of another set (set difference)" do
      a = ICU::USet.new('a', 'f')
      b = ICU::USet.new('d', 'z')
      a.remove_all(b)
      a.to_set.should eq(Set{'a', 'b', 'c'})
    end
  end

  describe "retain_all" do
    it "keeps only the intersection with another set" do
      a = ICU::USet.new('a', 'f')
      b = ICU::USet.new('d', 'z')
      a.retain_all(b)
      a.to_set.should eq(Set{'d', 'e', 'f'})
    end
  end

  describe "clear" do
    it "removes all members" do
      s = ICU::USet.new('a', 'z')
      s.clear
      s.empty?.should be_true
    end
  end

  describe "complement" do
    it "inverts the set" do
      s = ICU::USet.new("[^aeiou]")
      s.complement
      s.includes?('a').should be_true
      s.includes?('b').should be_false
    end
  end

  describe "disjoint?" do
    it "returns true when sets share no members" do
      a = ICU::USet.new('a', 'c')
      b = ICU::USet.new('x', 'z')
      a.disjoint?(b).should be_true
    end

    it "returns false when sets share at least one member" do
      a = ICU::USet.new('a', 'd')
      b = ICU::USet.new('c', 'f')
      a.disjoint?(b).should be_false
    end
  end

  describe "intersects?" do
    it "returns false for disjoint sets" do
      a = ICU::USet.new('a', 'c')
      b = ICU::USet.new('x', 'z')
      a.intersects?(b).should be_false
    end

    it "returns true when sets share at least one member" do
      a = ICU::USet.new('a', 'd')
      b = ICU::USet.new('c', 'f')
      a.intersects?(b).should be_true
    end
  end

  describe "superset?" do
    it "returns true when this set contains all members of the other" do
      a = ICU::USet.new('a', 'z')
      b = ICU::USet.new('d', 'f')
      a.superset?(b).should be_true
    end

    it "returns false otherwise" do
      a = ICU::USet.new('a', 'c')
      b = ICU::USet.new('b', 'e')
      a.superset?(b).should be_false
    end
  end

  describe "to_pattern" do
    it "returns a non-empty pattern string" do
      ICU::USet.new('a', 'c').to_pattern.should_not be_empty
    end
  end

  describe "each" do
    it "yields each character in the set" do
      chars = [] of Char
      ICU::USet.new('a', 'c').each { |c| chars << c }
      chars.should eq(['a', 'b', 'c'])
    end

    it "yields nothing for an empty set" do
      count = 0
      ICU::USet.new.each { count += 1 }
      count.should eq(0)
    end
  end

  describe "to_set" do
    it "converts to a Crystal Set(Char)" do
      ICU::USet.new('a', 'c').to_set.should eq(Set{'a', 'b', 'c'})
    end

    it "returns an empty Set for an empty USet" do
      ICU::USet.new.to_set.should eq(Set(Char).new)
    end

    it "works with a pattern-based set" do
      ICU::USet.new("[aeiou]").to_set.should eq(Set{'a', 'e', 'i', 'o', 'u'})
    end
  end

  describe "Enumerable" do
    it "supports map" do
      ICU::USet.new('a', 'c').map(&.upcase).should eq(['A', 'B', 'C'])
    end

    it "supports select" do
      ICU::USet.new('a', 'z').select { |c| "aeiou".includes?(c) }.sort.should eq(['a', 'e', 'i', 'o', 'u'])
    end

    it "supports includes? via Enumerable" do
      ICU::USet.new('a', 'z').includes?('m').should be_true
    end
  end
end
