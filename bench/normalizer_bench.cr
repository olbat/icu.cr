require "./bench_helper"
require "../src/icu"

REPEAT = 10_000

samples = load_data("text_samples.txt")

Benchmark.bm do |x|
  samples.each_with_index do |sample, i|
    x.report("##{i} NFC normalize") do
      REPEAT.times { ICU::NFCNormalizer.new.normalize(sample) }
    end
    x.report("##{i} NFD normalize") do
      REPEAT.times { ICU::NFDNormalizer.new.normalize(sample) }
    end
    x.report("##{i} NFKC normalize") do
      REPEAT.times { ICU::NFKCNormalizer.new.normalize(sample) }
    end
    x.report("##{i} NFKD normalize") do
      REPEAT.times { ICU::NFKDNormalizer.new.normalize(sample) }
    end
    x.report("##{i} NFKCCF normalize") do
      REPEAT.times { ICU::NFKCCFNormalizer.new.normalize(sample) }
    end
  end
end
