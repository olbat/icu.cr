require "../src/icu"

str = (%w{ахахха หน้าแรก bla haha O_o} * 1000).join(" ") + " "

p str.size
p str.bytesize

t = Time.now
s = 0

1000.times do
  s += ICU::BreakIterator.new(str, LibICU::UBreakIteratorType::Word).to_a.size
end

p Time.now - t
p s
