require "compiler/crystal/tools/formatter"

LIB_DIR  = "lib_icu"
ICU_INFO = "icu_info.cr"

Dir[File.join(File.dirname(__FILE__), LIB_DIR, "**", "*.cr")].each do |file|
  abort "cannot read #{file}" unless File.readable?(file)
  src = File.read(file)
  src = Crystal.format(src)

  # run the suffix finder program to initialize the SYMS_SUFFIX constant
  # in the common lib file
  if File.basename(file) == "#{LIB_DIR}.cr"
    constdef = <<-EOS
      VERSION={{ run("../#{ICU_INFO}", "--sem-version").strip.stringify }}
      SYMS_SUFFIX={{ run("../#{ICU_INFO}", "--so-symbols-suffix").strip.stringify }}
      {% end %}

      {% begin %}

    EOS
  else
    constdef = ""
  end

  # add macro blocks in the body of every lib files
  src = src.gsub(/^(lib \w+)\n(.+)end$/m, "\\1\n  {% begin %}\n#{constdef}\\2  {% end %}\nend")

  # replace the current suffix by the SYMS_SUFFIX constant (macro)
  src = src.gsub(/^(\s*fun\s+\w+\s*=\s*\w+?)(_[0-9_]+)?([\(\s:]|$)/m, "\\1{{SYMS_SUFFIX.id}}\\3")

  abort "cannot write #{file}" unless File.writable?(file)
  File.write(file, Crystal.format(src))
end
