require "benchmark"

DATA_DIR = File.expand_path(File.join(__DIR__, "..", "data"))

def load_data(filename)
  data = File.read(File.join(DATA_DIR, filename))
  data = data.gsub(/\s*#[^\n]*$/m, "") # remove comments
  data.split('\u001F').map!(&.strip)   # split on the INFORMATION SEPARATOR char
end
