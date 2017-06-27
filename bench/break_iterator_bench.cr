require "./bench_helper"
require "../src/icu"

REPEAT = 40_000

samples = load_data("text_sample.txt")

Benchmark.bm do |x|
  samples.each_with_index do |sample, i|
    x.report("##{i} char") do
      REPEAT.times { ICU::BreakIterator.new(sample, ICU::BreakIterator::Type::Character) }
    end
    x.report("##{i} word") do
      REPEAT.times { ICU::BreakIterator.new(sample, ICU::BreakIterator::Type::Word) }
    end
    x.report("##{i} sentence") do
      REPEAT.times { ICU::BreakIterator.new(sample, ICU::BreakIterator::Type::Sentence) }
    end
  end
end
