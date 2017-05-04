require "./spec_helper"
require "../src/icu_info"

describe "icu_version" do
  it "returns the version of the ICU lib" do
    icu_version().should match(/^[0-9][0-9\.]*$/)
  end
end

describe "icu_sem_version" do
  it "returns the version of the ICU lib in semantic versioning format" do
    icu_sem_version().should match(/^[0-9]+\.[0-9]+\.[0-9]+$/)
  end
end

describe "icu_so_symbols_suffix" do
  it "returns the version suffix added to symbols in so files of the ICU lib" do
    icu_so_symbols_suffix().should match(/^[0-9_]*$/)
  end
end
