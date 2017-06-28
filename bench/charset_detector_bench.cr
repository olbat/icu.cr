require "./bench_helper"
require "../src/icu"

REPEAT = 2_000

samples = load_data("text_samples.txt")

Benchmark.bm do |x|
  samples.each_with_index do |sample, i|
    x.report("##{i} first") do
      REPEAT.times { ICU::CharsetDetector.new.detect(sample) }
    end
    x.report("##{i} all") do
      REPEAT.times { ICU::CharsetDetector.new.detect_all(sample) }
    end
  end
end
