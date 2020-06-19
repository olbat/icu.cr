require "./spec_helper"

describe "ICU::UChars" do
  describe "initialize" do
    it "creates a valid UChars object from a String" do
      str = "Σὲ γνωρίζω ἀπὸ τὴν κόψη"
      src = ICU::UChars.new(str.size) { |i| str.char_at(i).ord.to_u16 }
      dest = ICU::UChars.new(str.size)

      # check that the UChars object is valid using a function of the lib
      ustatus = LibICU::UErrorCode::UZeroError
      LibICU.str_to_upper(dest, dest.size, src, src.size, nil, pointerof(ustatus))
      ICU.check_error!(ustatus)

      dest.to_s.should eq(str.upcase)
    end
  end

  describe "to_s" do
    it "creates a String from an UChars specifying it's size" do
      str = "Σὲ γνωρίζω ἀπὸ τὴν κόψη"
      str.to_uchars.to_s(8).should eq(str[0..7])
    end
  end

  describe "Char#to_uchar" do
    it "creates an UChar from a Char" do
      'e'.to_uchar.should eq(101)
    end
  end

  describe "String#to_uchars" do
    it "creates a valid UChars object from a String" do
      str = "Зарегистрируйтесь сейчас на Десятую Международную Конференцию по"
      uchars = str.each_char.map { |c| c.ord.to_u16 }.to_a
      src = str.to_uchars
      src.each_with_index { |c, i| c.should eq(uchars[i]) }
      dest = ICU::UChars.new(str.size)

      # check that the UChars object is valid using a function of the lib
      ustatus = LibICU::UErrorCode::UZeroError
      LibICU.str_to_upper(dest, dest.size, src, src.size, nil, pointerof(ustatus))
      ICU.check_error!(ustatus)

      dest.to_s.should eq(str.upcase)
    end
  end
end
