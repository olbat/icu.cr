@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
  enum UDataFileAccess
    UdataFilesFirst      = 0
    UdataDefaultAccess   = 0
    UdataOnlyPackages    = 1
    UdataPackagesFirst   = 2
    UdataNoFiles         = 3
    UdataFileAccessCount = 4
  end
  fun udata_close = udata_close_52(p_data : UDataMemory)
  fun udata_get_info = udata_getInfo_52(p_data : UDataMemory, p_info : UDataInfo*)
  fun udata_get_memory = udata_getMemory_52(p_data : UDataMemory) : Void*
  fun udata_open = udata_open_52(path : LibC::Char*, type : LibC::Char*, name : LibC::Char*, p_error_code : UErrorCode*) : UDataMemory
  fun udata_open_choice = udata_openChoice_52(path : LibC::Char*, type : LibC::Char*, name : LibC::Char*, is_acceptable : (Void*, LibC::Char*, LibC::Char*, UDataInfo* -> UBool), context : Void*, p_error_code : UErrorCode*) : UDataMemory
  fun udata_set_app_data = udata_setAppData_52(package_name : LibC::Char*, data : Void*, err : UErrorCode*)
  fun udata_set_common_data = udata_setCommonData_52(data : Void*, err : UErrorCode*)
  fun udata_set_file_access = udata_setFileAccess_52(access : UDataFileAccess, status : UErrorCode*)

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
end
