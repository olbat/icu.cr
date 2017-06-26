require "benchmark"

def load_data(filename)
  data = File.read(File.join(__DIR__, filename))
  data = data.gsub(/\s*#[^\n]*$/m, "") # remove comments
  data.split('\u001F').map!(&.strip) # split on the INFORMATION SEPARATOR char
end
