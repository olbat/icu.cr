# TODO: ugly, find another way to extend the Slice(UInt16) type
#       (see https://github.com/crystal-lang/crystal/issues/2529)
struct ICU::UChars
  # see http://userguide.icu-project.org/dev/codingguidelines#TOC-Primitive-Type
  @slice : Slice(UInt16)

  def initialize(size : Int, *, read_only = false)
    @slice = typeof(@slice).new(size, read_only: read_only)
  end

  def initialize(size : Int, *, read_only = false, &block : Int32 -> _)
    @slice = typeof(@slice).new(size, read_only: read_only, &block)
  end

  def initialize(size : Int, *, value : UInt16, read_only = false)
    @slice = typeof(@slice).new(size, value, read_only: read_only)
  end

  def initialize(pointer : Pointer(UInt16), size : Int, *, read_only = false)
    @slice = typeof(@slice).new(pointer, size, read_only: read_only)
  end

  forward_missing_to @slice

  # see http://userguide.icu-project.org/strings#TOC-ICU:-16-bit-Unicode-strings
  def to_s(size : Int? = nil)
    size ||= @slice.size
    String.build { |io| size.times { |i| io << @slice[i].chr } }
  end
end

class String
  # see http://userguide.icu-project.org/strings
  def to_uchars(size : Int? = nil)
    i = 0
    size ||= size()
    ICU::UChars.new(size).tap do |uchars|
      each_char do |c|
        uchars[i] = c.ord.to_u16
        i += 1
      end
    end
  end
end
