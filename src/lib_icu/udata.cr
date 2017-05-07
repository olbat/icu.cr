@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  enum UDataFileAccess
    FilesFirst      = 0
    DefaultAccess   = 0
    OnlyPackages    = 1
    PackagesFirst   = 2
    NoFiles         = 3
    FileAccessCount = 4
  end
  fun udata_close = udata_close{{SYMS_SUFFIX.id}}(p_data : UDataMemory)
  fun udata_get_info = udata_getInfo{{SYMS_SUFFIX.id}}(p_data : UDataMemory, p_info : UDataInfo*)
  fun udata_get_memory = udata_getMemory{{SYMS_SUFFIX.id}}(p_data : UDataMemory) : Void*
  fun udata_open = udata_open{{SYMS_SUFFIX.id}}(path : LibC::Char*, type : LibC::Char*, name : LibC::Char*, p_error_code : UErrorCode*) : UDataMemory
  fun udata_open_choice = udata_openChoice{{SYMS_SUFFIX.id}}(path : LibC::Char*, type : LibC::Char*, name : LibC::Char*, is_acceptable : (Void*, LibC::Char*, LibC::Char*, UDataInfo* -> UBool), context : Void*, p_error_code : UErrorCode*) : UDataMemory
  fun udata_set_app_data = udata_setAppData{{SYMS_SUFFIX.id}}(package_name : LibC::Char*, data : Void*, err : UErrorCode*)
  fun udata_set_common_data = udata_setCommonData{{SYMS_SUFFIX.id}}(data : Void*, err : UErrorCode*)
  fun udata_set_file_access = udata_setFileAccess{{SYMS_SUFFIX.id}}(access : UDataFileAccess, status : UErrorCode*)

  struct UDataInfo
    size : Uint16T
    reserved_word : Uint16T
    is_big_endian : Uint8T
    charset_family : Uint8T
    sizeof_u_char : Uint8T
    reserved_byte : Uint8T
    data_format : Uint8T[4]
    format_version : Uint8T[4]
    data_version : Uint8T[4]
  end

  type UDataMemory = Void*
  {% end %}
end
