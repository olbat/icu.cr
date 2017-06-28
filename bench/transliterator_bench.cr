require "./bench_helper"
require "../src/icu"

REPEAT = 10

text = File.read(File.join(__DIR__, "..", "LICENSE"))
transforms = [
  "Any-Hex",
  "Latin-Arabic",
  "Latin-Armenian",
  "Latin-Bopomofo",
  "Latin-Cyrillic",
  "Latin-Georgian",
  "Latin-Greek",
  "Latin-Hangul",
  "Latin-Hebrew",
  "Latin-Hiragana",
  "Latin-Jamo",
  "Latin-Katakana",
  "Latin-Syriac",
  "Latin-Thaana",
  "Latin-Thai",
]

Benchmark.bm do |x|
  transforms.each_with_index do |trans, i|
    x.report("##{i} #{trans}") do
      REPEAT.times { ICU::Transliterator.new(trans).transliterate(text) }
    end
  end
end
