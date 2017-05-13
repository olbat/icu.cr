require "xml"
require "c/dlfcn"

PKGNAME  = "icu-uc"
TESTFUNC = "u_init"
{% if flag?(:darwin) %}
SOFILE   = "libicuuc.dylib"
{% elsif flag?(:windows) %}
SOFILE   = "libicuuc.dll"
{% else %}
SOFILE   = "libicuuc.so"
{% end %}

def icu_version : String
  version = nil
  if system("command -v icuinfo > /dev/null")
    icuinfo = `icuinfo -v 2>/dev/null`
    begin
      doc = XML.parse(icuinfo)
      if params = doc.first_element_child
        if params.name == "icuSystemParams" # ICU >= 49.0
          params.children.select(&.element?).each do |param|
            if param.name == "param" && param["name"]? == "version"
              version = param.content.strip
              break
            end
          end
        elsif params.name == "ICUINFO" # ICU < 49.0
          if v = params.content.match(/Compiled-Version\s*:\s*([0-9\.]+)/)
            version = v[1]
          end
        end
      end
    rescue XML::Error
    end
  else
    STDERR.puts %(WARNING: cannot find the "icuinfo" tool in PATH)
    {% if flag?(:darwin) %}
    STDERR.puts %(\t(on OSX, please check that you've run "brew link icu4c"))
    {% end %}
  end

  if !version && system("command -v pkg-config > /dev/null")
    version = `pkg-config --modversion #{PKGNAME}`.strip
  end

  abort("cannot find ICU version", 3) if !version || version.empty?

  version
end

def icu_sem_version : String
  # convert ICU version to semantic versioning
  version = icu_version()
  v = version.split(".")
  if v.size == 3
    version
  elsif v.size > 3
    v[0..2].join(".")
  else
    3.times.map { |i| v[i]? || "0" }.join(".")
  end
end

def icu_possible_suffixes(version : String) : Array(String)
  v = version.split(".")
  [
    "",
    "_#{version}",
    "_#{v[0]}",
    "_#{v[0]}#{v[1]}",
    "_#{v[0]}_#{v[1]}",
    "_#{v[0][0]}_#{v[0][1]? || v[1][0]}",
  ].uniq
end

def icu_so_symbols_suffix
  suffixes = icu_possible_suffixes(icu_version())

  handle = LibC.dlopen(SOFILE, LibC::RTLD_LAZY)
  abort("cannot load the #{SOFILE} file", 1) if handle.null?

  begin
    suffixes.each do |suffix|
      LibC.dlsym(handle, "#{TESTFUNC}#{suffix}")
      return suffix if LibC.dlerror.null?
    end
    abort("cannot find so symbols suffix", 2)
  ensure
    LibC.dlclose(handle)
  end
end

case ARGV[0]?
when "--version"
  puts icu_version()
when "--sem-version"
  puts icu_sem_version()
when "--so-symbols-suffix"
  puts icu_so_symbols_suffix()
end
