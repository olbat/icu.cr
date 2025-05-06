# __Text Transformation__
#
# Transliteration
#
# __Usage__
# ```
# trans = ICU::Transliterator.new({from: "Greek", to: "Latin"})
# trans.transliterate("Αλφαβητικός Κατάλογος") # => "Alphabētikós Katálogos"
#
# trans = ICU::Transliterator.new("Katakana-Hiragana")
# trans.transliterate("ミヤモト ムサシ") # => "みやもと むさし"
# ```
#
# __See also__
# - [ICU User Guide](https://unicode-org.github.io/icu/userguide/transforms/general/#transliterator-identifiers)
# - [Reference C API](https://unicode-org.github.io/icu-docs/apidoc/released/icu4c/utrans_8h.html)
# - [Unit tests](https://github.com/olbat/icu.cr/blob/master/spec/transliterator_spec.cr)
class ICU::Transliterator
  alias ID = NamedTuple(from: String, to: String?, variant: String?)
  # The list of available transliterators
  IDS = begin
    ids = (0...LibICU.utrans_count_available_i_ds).map do |i|
      buf = Bytes.new(50)
      size = LibICU.utrans_get_available_id(i, buf, buf.size)
      str2id(String.new(buf[0, size]))
    end
    Set(ID).new(ids)
  end

  def self.id2str(id : ID) : String
    "#{id[:from]}#{id[:to].try { |t| "-#{t}" }}#{id[:variant].try { |v| "/#{v}" }}"
  end

  def self.str2id(idstr : String) : ID
    id = idstr.match(%r{^([^\-]+)(?:\-([^/]+?))?(?:/(.+))?$}).not_nil!
    {from: id[1], to: id[2]?, variant: id[3]?}
  end

  @id : ID
  @utrans : Pointer(LibICU::UTransliterator)

  def initialize(@id : ID)
    raise ICU::Error.new("unknown ID #{@id}") unless IDS.includes?(@id)

    ustatus = LibICU::UErrorCode::UZeroError
    @utrans = LibICU.utrans_open(self.class.id2str(@id), LibICU::UTransDirection::Forward, nil, -1, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def initialize(id : String)
    initialize(self.class.str2id(id))
  end

  def initialize(@id : ID, rules : String)
    idstr = self.class.id2str(@id)

    ustatus = LibICU::UErrorCode::UZeroError
    @utrans = LibICU.utrans_open_u(idstr.to_uchars, idstr.size, LibICU::UTransDirection::Forward, rules.to_uchars, rules.size, nil, pointerof(ustatus))
    ICU.check_error!(ustatus)
  end

  def initialize(id : String, rules : String)
    initialize(self.class.str2id(id), rules)
  end

  def finalize
    @utrans.try { |utrans| LibICU.utrans_close(utrans) }
  end

  def to_unsafe
    @utrans
  end

  def reverse!
    if @id[:to]
      @id = {from: @id[:to].not_nil!, to: @id[:from], variant: @id[:variant]}
    end
    ustatus = LibICU::UErrorCode::UZeroError
    @utrans = LibICU.utrans_open_inverse(@utrans, pointerof(ustatus))
    ICU.check_error!(ustatus)
    self
  end

  # Transliterates _text_
  #
  # ```
  # trans = ICU::Transliterator.new({from: "Greek", to: "Latin})
  # trans.transliterate("Αλφαβητικός Κατάλογος") # => "Alphabētikós Katálogos"
  # ```
  def transliterate(text : String) : String
    # allocate enough space to handle Unicode hexadecimal notation ("\uFFFF")
    uchars = text.to_uchars(text.size * 6)
    size = limit = text.size

    ustatus = LibICU::UErrorCode::UZeroError
    LibICU.utrans_trans_u_chars(@utrans, uchars, pointerof(size), uchars.size, 0, pointerof(limit), pointerof(ustatus))
    ICU.check_error!(ustatus)

    uchars.to_s(size)
  end
end
