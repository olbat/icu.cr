@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io 2> /dev/null|| printf %s '-licuio -licui18n -licuuc -licudata'`")]
lib LibICU
  {% begin %}
  VERSION={{ run("../icu_info.cr", "--sem-version").strip.stringify }}
  SYMS_SUFFIX={{ run("../icu_info.cr", "--so-symbols-suffix").strip.stringify }}
  {% end %}

  {% begin %}
  alias Int32T = LibC::Int
  alias Int64T = LibC::Long
  alias Int8T = LibC::Char
  alias UBool = Int8T
  alias UCalendar = Void*
  alias UChar = LibC::UShort
  alias UChar32 = Int32T
  alias UDate = LibC::Double
  alias UFormattable = Void*
  alias UNumberFormat = Void*
  alias UVersionInfo = Uint8T[4]
  alias Uint16T = LibC::UShort
  alias Uint32T = LibC::UInt
  alias Uint8T = UInt8
  enum UCalendarDateFields
    Era               =  0
    Year              =  1
    Month             =  2
    WeekOfYear        =  3
    WeekOfMonth       =  4
    Date              =  5
    DayOfYear         =  6
    DayOfWeek         =  7
    DayOfWeekInMonth  =  8
    AmPm              =  9
    Hour              = 10
    HourOfDay         = 11
    Minute            = 12
    Second            = 13
    Millisecond       = 14
    ZoneOffset        = 15
    DstOffset         = 16
    YearWoy           = 17
    DowLocal          = 18
    ExtendedYear      = 19
    JulianDay         = 20
    MillisecondsInDay = 21
    IsLeapMonth       = 22
    FieldCount        = 23
    DayOfMonth        =  5
  end
  enum UCharCategory
    UUnassigned           =  0
    UGeneralOtherTypes    =  0
    UUppercaseLetter      =  1
    ULowercaseLetter      =  2
    UTitlecaseLetter      =  3
    UModifierLetter       =  4
    UOtherLetter          =  5
    UNonSpacingMark       =  6
    UEnclosingMark        =  7
    UCombiningSpacingMark =  8
    UDecimalDigitNumber   =  9
    ULetterNumber         = 10
    UOtherNumber          = 11
    USpaceSeparator       = 12
    ULineSeparator        = 13
    UParagraphSeparator   = 14
    UControlChar          = 15
    UFormatChar           = 16
    UPrivateUseChar       = 17
    USurrogate            = 18
    UDashPunctuation      = 19
    UStartPunctuation     = 20
    UEndPunctuation       = 21
    UConnectorPunctuation = 22
    UOtherPunctuation     = 23
    UMathSymbol           = 24
    UCurrencySymbol       = 25
    UModifierSymbol       = 26
    UOtherSymbol          = 27
    UInitialPunctuation   = 28
    UFinalPunctuation     = 29
    UCharCategoryCount    = 30
  end
  enum UCharDirection
    ULeftToRight              =  0
    URightToLeft              =  1
    UEuropeanNumber           =  2
    UEuropeanNumberSeparator  =  3
    UEuropeanNumberTerminator =  4
    UArabicNumber             =  5
    UCommonNumberSeparator    =  6
    UBlockSeparator           =  7
    USegmentSeparator         =  8
    UWhiteSpaceNeutral        =  9
    UOtherNeutral             = 10
    ULeftToRightEmbedding     = 11
    ULeftToRightOverride      = 12
    URightToLeftArabic        = 13
    URightToLeftEmbedding     = 14
    URightToLeftOverride      = 15
    UPopDirectionalFormat     = 16
    UDirNonSpacingMark        = 17
    UBoundaryNeutral          = 18
    UFirstStrongIsolate       = 19
    ULeftToRightIsolate       = 20
    URightToLeftIsolate       = 21
    UPopDirectionalIsolate    = 22
    UCharDirectionCount       = 23
  end
  enum UCharIteratorOrigin
    Start   = 0
    Current = 1
    Limit   = 2
    Zero    = 3
    Length  = 4
  end
  enum UCharNameChoice
    UUnicodeCharName     = 0
    UUnicode10CharName   = 1
    UExtendedCharName    = 2
    UCharNameAlias       = 3
    UCharNameChoiceCount = 4
  end
  enum UDisplayContext
    StandardNames                        =   0
    DialectNames                         =   1
    CapitalizationNone                   = 256
    CapitalizationForMiddleOfSentence    = 257
    CapitalizationForBeginningOfSentence = 258
    CapitalizationForUiListOrMenu        = 259
    CapitalizationForStandalone          = 260
    LengthFull                           = 512
    LengthShort                          = 513
  end
  enum UDisplayContextType
    TypeDialectHandling = 0
    TypeCapitalization  = 1
    TypeDisplayLength   = 2
  end
  enum UErrorCode
    UUsingFallbackWarning         =  -128
    UErrorWarningStart            =  -128
    UUsingDefaultWarning          =  -127
    USafecloneAllocatedWarning    =  -126
    UStateOldWarning              =  -125
    UStringNotTerminatedWarning   =  -124
    USortKeyTooShortWarning       =  -123
    UAmbiguousAliasWarning        =  -122
    UDifferentUcaVersion          =  -121
    UPluginChangedLevelWarning    =  -120
    UErrorWarningLimit            =  -119
    UZeroError                    =     0
    UIllegalArgumentError         =     1
    UMissingResourceError         =     2
    UInvalidFormatError           =     3
    UFileAccessError              =     4
    UInternalProgramError         =     5
    UMessageParseError            =     6
    UMemoryAllocationError        =     7
    UIndexOutofboundsError        =     8
    UParseError                   =     9
    UInvalidCharFound             =    10
    UTruncatedCharFound           =    11
    UIllegalCharFound             =    12
    UInvalidTableFormat           =    13
    UInvalidTableFile             =    14
    UBufferOverflowError          =    15
    UUnsupportedError             =    16
    UResourceTypeMismatch         =    17
    UIllegalEscapeSequence        =    18
    UUnsupportedEscapeSequence    =    19
    UNoSpaceAvailable             =    20
    UCeNotFoundError              =    21
    UPrimaryTooLongError          =    22
    UStateTooOldError             =    23
    UTooManyAliasesError          =    24
    UEnumOutOfSyncError           =    25
    UInvariantConversionError     =    26
    UInvalidStateError            =    27
    UCollatorVersionMismatch      =    28
    UUselessCollatorError         =    29
    UNoWritePermission            =    30
    UStandardErrorLimit           =    31
    UBadVariableDefinition        = 65536
    UParseErrorStart              = 65536
    UMalformedRule                = 65537
    UMalformedSet                 = 65538
    UMalformedSymbolReference     = 65539
    UMalformedUnicodeEscape       = 65540
    UMalformedVariableDefinition  = 65541
    UMalformedVariableReference   = 65542
    UMismatchedSegmentDelimiters  = 65543
    UMisplacedAnchorStart         = 65544
    UMisplacedCursorOffset        = 65545
    UMisplacedQuantifier          = 65546
    UMissingOperator              = 65547
    UMissingSegmentClose          = 65548
    UMultipleAnteContexts         = 65549
    UMultipleCursors              = 65550
    UMultiplePostContexts         = 65551
    UTrailingBackslash            = 65552
    UUndefinedSegmentReference    = 65553
    UUndefinedVariable            = 65554
    UUnquotedSpecial              = 65555
    UUnterminatedQuote            = 65556
    URuleMaskError                = 65557
    UMisplacedCompoundFilter      = 65558
    UMultipleCompoundFilters      = 65559
    UInvalidRbtSyntax             = 65560
    UInvalidPropertyPattern       = 65561
    UMalformedPragma              = 65562
    UUnclosedSegment              = 65563
    UIllegalCharInSegment         = 65564
    UVariableRangeExhausted       = 65565
    UVariableRangeOverlap         = 65566
    UIllegalCharacter             = 65567
    UInternalTransliteratorError  = 65568
    UInvalidId                    = 65569
    UInvalidFunction              = 65570
    UParseErrorLimit              = 65571
    UUnexpectedToken              = 65792
    UFmtParseErrorStart           = 65792
    UMultipleDecimalSeparators    = 65793
    UMultipleDecimalSeperators    = 65793
    UMultipleExponentialSymbols   = 65794
    UMalformedExponentialPattern  = 65795
    UMultiplePercentSymbols       = 65796
    UMultiplePermillSymbols       = 65797
    UMultiplePadSpecifiers        = 65798
    UPatternSyntaxError           = 65799
    UIllegalPadPosition           = 65800
    UUnmatchedBraces              = 65801
    UUnsupportedProperty          = 65802
    UUnsupportedAttribute         = 65803
    UArgumentTypeMismatch         = 65804
    UDuplicateKeyword             = 65805
    UUndefinedKeyword             = 65806
    UDefaultKeywordMissing        = 65807
    UDecimalNumberSyntaxError     = 65808
    UFormatInexactError           = 65809
    UFmtParseErrorLimit           = 65810
    UBrkInternalError             = 66048
    UBrkErrorStart                = 66048
    UBrkHexDigitsExpected         = 66049
    UBrkSemicolonExpected         = 66050
    UBrkRuleSyntax                = 66051
    UBrkUnclosedSet               = 66052
    UBrkAssignError               = 66053
    UBrkVariableRedfinition       = 66054
    UBrkMismatchedParen           = 66055
    UBrkNewLineInQuotedString     = 66056
    UBrkUndefinedVariable         = 66057
    UBrkInitError                 = 66058
    UBrkRuleEmptySet              = 66059
    UBrkUnrecognizedOption        = 66060
    UBrkMalformedRuleTag          = 66061
    UBrkErrorLimit                = 66062
    URegexInternalError           = 66304
    URegexErrorStart              = 66304
    URegexRuleSyntax              = 66305
    URegexInvalidState            = 66306
    URegexBadEscapeSequence       = 66307
    URegexPropertySyntax          = 66308
    URegexUnimplemented           = 66309
    URegexMismatchedParen         = 66310
    URegexNumberTooBig            = 66311
    URegexBadInterval             = 66312
    URegexMaxLtMin                = 66313
    URegexInvalidBackRef          = 66314
    URegexInvalidFlag             = 66315
    URegexLookBehindLimit         = 66316
    URegexSetContainsString       = 66317
    URegexOctalTooBig             = 66318
    URegexMissingCloseBracket     = 66319
    URegexInvalidRange            = 66320
    URegexStackOverflow           = 66321
    URegexTimeOut                 = 66322
    URegexStoppedByCaller         = 66323
    URegexPatternTooBig           = 66324
    URegexInvalidCaptureGroupName = 66325
    URegexErrorLimit              = 66326
    UIdnaProhibitedError          = 66560
    UIdnaErrorStart               = 66560
    UIdnaUnassignedError          = 66561
    UIdnaCheckBidiError           = 66562
    UIdnaStD3AsciiRulesError      = 66563
    UIdnaAcePrefixError           = 66564
    UIdnaVerificationError        = 66565
    UIdnaLabelTooLongError        = 66566
    UIdnaZeroLengthLabelError     = 66567
    UIdnaDomainNameTooLongError   = 66568
    UIdnaErrorLimit               = 66569
    UStringprepProhibitedError    = 66560
    UStringprepUnassignedError    = 66561
    UStringprepCheckBidiError     = 66562
    UPluginErrorStart             = 66816
    UPluginTooHigh                = 66816
    UPluginDidntSetLevel          = 66817
    UPluginErrorLimit             = 66818
    UErrorLimit                   = 66818
  end
  enum UFormattableType
    Date   = 0
    Double = 1
    Long   = 2
    String = 3
    Array  = 4
    InT64  = 5
    Object = 6
    Count  = 7
  end
  enum ULocDataLocaleType
    ActualLocale        = 0
    ValidLocale         = 1
    RequestedLocale     = 2
    DataLocaleTypeLimit = 3
  end
  enum UProperty
    Alphabetic                   =     0
    BinaryStart                  =     0
    AsciiHexDigit                =     1
    BidiControl                  =     2
    BidiMirrored                 =     3
    Dash                         =     4
    DefaultIgnorableCodePoint    =     5
    Deprecated                   =     6
    Diacritic                    =     7
    Extender                     =     8
    FullCompositionExclusion     =     9
    GraphemeBase                 =    10
    GraphemeExtend               =    11
    GraphemeLink                 =    12
    HexDigit                     =    13
    Hyphen                       =    14
    IdContinue                   =    15
    IdStart                      =    16
    Ideographic                  =    17
    IdsBinaryOperator            =    18
    IdsTrinaryOperator           =    19
    JoinControl                  =    20
    LogicalOrderException        =    21
    Lowercase                    =    22
    Math                         =    23
    NoncharacterCodePoint        =    24
    QuotationMark                =    25
    Radical                      =    26
    SoftDotted                   =    27
    TerminalPunctuation          =    28
    UnifiedIdeograph             =    29
    Uppercase                    =    30
    WhiteSpace                   =    31
    XidContinue                  =    32
    XidStart                     =    33
    CaseSensitive                =    34
    STerm                        =    35
    VariationSelector            =    36
    NfdInert                     =    37
    NfkdInert                    =    38
    NfcInert                     =    39
    NfkcInert                    =    40
    SegmentStarter               =    41
    PatternSyntax                =    42
    PatternWhiteSpace            =    43
    PosixAlnum                   =    44
    PosixBlank                   =    45
    PosixGraph                   =    46
    PosixPrint                   =    47
    PosixXdigit                  =    48
    Cased                        =    49
    CaseIgnorable                =    50
    ChangesWhenLowercased        =    51
    ChangesWhenUppercased        =    52
    ChangesWhenTitlecased        =    53
    ChangesWhenCasefolded        =    54
    ChangesWhenCasemapped        =    55
    ChangesWhenNfkcCasefolded    =    56
    Emoji                        =    57
    EmojiPresentation            =    58
    EmojiModifier                =    59
    EmojiModifierBase            =    60
    BinaryLimit                  =    61
    BidiClass                    =  4096
    IntStart                     =  4096
    Block                        =  4097
    CanonicalCombiningClass      =  4098
    DecompositionType            =  4099
    EastAsianWidth               =  4100
    GeneralCategory              =  4101
    JoiningGroup                 =  4102
    JoiningType                  =  4103
    LineBreak                    =  4104
    NumericType                  =  4105
    Script                       =  4106
    HangulSyllableType           =  4107
    NfdQuickCheck                =  4108
    NfkdQuickCheck               =  4109
    NfcQuickCheck                =  4110
    NfkcQuickCheck               =  4111
    LeadCanonicalCombiningClass  =  4112
    TrailCanonicalCombiningClass =  4113
    GraphemeClusterBreak         =  4114
    SentenceBreak                =  4115
    WordBreak                    =  4116
    BidiPairedBracketType        =  4117
    IntLimit                     =  4118
    GeneralCategoryMask          =  8192
    MaskStart                    =  8192
    MaskLimit                    =  8193
    NumericValue                 = 12288
    DoubleStart                  = 12288
    DoubleLimit                  = 12289
    Age                          = 16384
    StringStart                  = 16384
    BidiMirroringGlyph           = 16385
    CaseFolding                  = 16386
    IsoComment                   = 16387
    LowercaseMapping             = 16388
    Name                         = 16389
    SimpleCaseFolding            = 16390
    SimpleLowercaseMapping       = 16391
    SimpleTitlecaseMapping       = 16392
    SimpleUppercaseMapping       = 16393
    TitlecaseMapping             = 16394
    Unicode1Name                 = 16395
    UppercaseMapping             = 16396
    BidiPairedBracket            = 16397
    StringLimit                  = 16398
    ScriptExtensions             = 28672
    OtherPropertyStart           = 28672
    OtherPropertyLimit           = 28673
    InvalidCode                  =    -1
  end
  enum UPropertyNameChoice
    UShortPropertyName       = 0
    ULongPropertyName        = 1
    UPropertyNameChoiceCount = 2
  end
  fun char_age = u_charAge{{SYMS_SUFFIX.id}}(c : UChar32, version_array : UVersionInfo)
  fun char_digit_value = u_charDigitValue{{SYMS_SUFFIX.id}}(c : UChar32) : Int32T
  fun char_direction = u_charDirection{{SYMS_SUFFIX.id}}(c : UChar32) : UCharDirection
  fun char_from_name = u_charFromName{{SYMS_SUFFIX.id}}(name_choice : UCharNameChoice, name : LibC::Char*, p_error_code : UErrorCode*) : UChar32
  fun char_mirror = u_charMirror{{SYMS_SUFFIX.id}}(c : UChar32) : UChar32
  fun char_name = u_charName{{SYMS_SUFFIX.id}}(code : UChar32, name_choice : UCharNameChoice, buffer : LibC::Char*, buffer_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun char_type = u_charType{{SYMS_SUFFIX.id}}(c : UChar32) : Int8T
  fun chars_to_u_chars = u_charsToUChars{{SYMS_SUFFIX.id}}(cs : LibC::Char*, us : UChar*, length : Int32T)
  fun digit = u_digit{{SYMS_SUFFIX.id}}(ch : UChar32, radix : Int8T) : Int32T
  fun enum_char_names = u_enumCharNames{{SYMS_SUFFIX.id}}(start : UChar32, limit : UChar32, fn : (Void*, UChar32, UCharNameChoice, LibC::Char*, Int32T -> UBool), context : Void*, name_choice : UCharNameChoice, p_error_code : UErrorCode*)
  fun enum_char_types = u_enumCharTypes{{SYMS_SUFFIX.id}}(enum_range : (Void*, UChar32, UChar32, UCharCategory -> UBool), context : Void*)
  fun error_name = u_errorName{{SYMS_SUFFIX.id}}(code : UErrorCode) : LibC::Char*
  fun fold_case = u_foldCase{{SYMS_SUFFIX.id}}(c : UChar32, options : Uint32T) : UChar32
  fun for_digit = u_forDigit{{SYMS_SUFFIX.id}}(digit : Int32T, radix : Int8T) : UChar32
  fun get_bidi_paired_bracket = u_getBidiPairedBracket{{SYMS_SUFFIX.id}}(c : UChar32) : UChar32
  fun get_combining_class = u_getCombiningClass{{SYMS_SUFFIX.id}}(c : UChar32) : Uint8T
  fun get_data_directory = u_getDataDirectory{{SYMS_SUFFIX.id}} : LibC::Char*
  fun get_fc_nfkc_closure = u_getFC_NFKC_Closure{{SYMS_SUFFIX.id}}(c : UChar32, dest : UChar*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun get_int_property_max_value = u_getIntPropertyMaxValue{{SYMS_SUFFIX.id}}(which : UProperty) : Int32T
  fun get_int_property_min_value = u_getIntPropertyMinValue{{SYMS_SUFFIX.id}}(which : UProperty) : Int32T
  fun get_int_property_value = u_getIntPropertyValue{{SYMS_SUFFIX.id}}(c : UChar32, which : UProperty) : Int32T
  fun get_iso_comment = u_getISOComment{{SYMS_SUFFIX.id}}(c : UChar32, dest : LibC::Char*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun get_numeric_value = u_getNumericValue{{SYMS_SUFFIX.id}}(c : UChar32) : LibC::Double
  fun get_property_enum = u_getPropertyEnum{{SYMS_SUFFIX.id}}(alias : LibC::Char*) : UProperty
  fun get_property_name = u_getPropertyName{{SYMS_SUFFIX.id}}(property : UProperty, name_choice : UPropertyNameChoice) : LibC::Char*
  fun get_property_value_enum = u_getPropertyValueEnum{{SYMS_SUFFIX.id}}(property : UProperty, alias : LibC::Char*) : Int32T
  fun get_property_value_name = u_getPropertyValueName{{SYMS_SUFFIX.id}}(property : UProperty, value : Int32T, name_choice : UPropertyNameChoice) : LibC::Char*
  fun get_time_zone_files_directory = u_getTimeZoneFilesDirectory{{SYMS_SUFFIX.id}}(status : UErrorCode*) : LibC::Char*
  fun get_unicode_version = u_getUnicodeVersion{{SYMS_SUFFIX.id}}(version_array : UVersionInfo)
  fun get_version = u_getVersion{{SYMS_SUFFIX.id}}(version_array : UVersionInfo)
  fun has_binary_property = u_hasBinaryProperty{{SYMS_SUFFIX.id}}(c : UChar32, which : UProperty) : UBool
  fun is_id_ignorable = u_isIDIgnorable{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_id_part = u_isIDPart{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_id_start = u_isIDStart{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_iso_control = u_isISOControl{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_java_id_part = u_isJavaIDPart{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_java_id_start = u_isJavaIDStart{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_java_space_char = u_isJavaSpaceChar{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_mirrored = u_isMirrored{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_u_alphabetic = u_isUAlphabetic{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_u_lowercase = u_isULowercase{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_u_uppercase = u_isUUppercase{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_u_white_space = u_isUWhiteSpace{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun is_whitespace = u_isWhitespace{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isalnum = u_isalnum{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isalpha = u_isalpha{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isbase = u_isbase{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isblank = u_isblank{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun iscntrl = u_iscntrl{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isdefined = u_isdefined{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isdigit = u_isdigit{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isgraph = u_isgraph{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun islower = u_islower{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isprint = u_isprint{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun ispunct = u_ispunct{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isspace = u_isspace{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun istitle = u_istitle{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isupper = u_isupper{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun isxdigit = u_isxdigit{{SYMS_SUFFIX.id}}(c : UChar32) : UBool
  fun set_data_directory = u_setDataDirectory{{SYMS_SUFFIX.id}}(directory : LibC::Char*)
  fun set_time_zone_files_directory = u_setTimeZoneFilesDirectory{{SYMS_SUFFIX.id}}(path : LibC::Char*, status : UErrorCode*)
  fun tolower = u_tolower{{SYMS_SUFFIX.id}}(c : UChar32) : UChar32
  fun totitle = u_totitle{{SYMS_SUFFIX.id}}(c : UChar32) : UChar32
  fun toupper = u_toupper{{SYMS_SUFFIX.id}}(c : UChar32) : UChar32
  fun u_chars_to_chars = u_UCharsToChars{{SYMS_SUFFIX.id}}(us : UChar*, cs : LibC::Char*, length : Int32T)
  fun ufmt_close = ufmt_close{{SYMS_SUFFIX.id}}(fmt : UFormattable*)
  fun ufmt_get_array_item_by_index = ufmt_getArrayItemByIndex{{SYMS_SUFFIX.id}}(fmt : UFormattable*, n : Int32T, status : UErrorCode*) : UFormattable*
  fun ufmt_get_array_length = ufmt_getArrayLength{{SYMS_SUFFIX.id}}(fmt : UFormattable*, status : UErrorCode*) : Int32T
  fun ufmt_get_date = ufmt_getDate{{SYMS_SUFFIX.id}}(fmt : UFormattable*, status : UErrorCode*) : UDate
  fun ufmt_get_dec_num_chars = ufmt_getDecNumChars{{SYMS_SUFFIX.id}}(fmt : UFormattable*, len : Int32T*, status : UErrorCode*) : LibC::Char*
  fun ufmt_get_double = ufmt_getDouble{{SYMS_SUFFIX.id}}(fmt : UFormattable*, status : UErrorCode*) : LibC::Double
  fun ufmt_get_int64 = ufmt_getInt64{{SYMS_SUFFIX.id}}(fmt : UFormattable*, status : UErrorCode*) : Int64T
  fun ufmt_get_long = ufmt_getLong{{SYMS_SUFFIX.id}}(fmt : UFormattable*, status : UErrorCode*) : Int32T
  fun ufmt_get_object = ufmt_getObject{{SYMS_SUFFIX.id}}(fmt : UFormattable*, status : UErrorCode*) : Void*
  fun ufmt_get_type = ufmt_getType{{SYMS_SUFFIX.id}}(fmt : UFormattable*, status : UErrorCode*) : UFormattableType
  fun ufmt_get_u_chars = ufmt_getUChars{{SYMS_SUFFIX.id}}(fmt : UFormattable*, len : Int32T*, status : UErrorCode*) : UChar*
  fun ufmt_is_numeric = ufmt_isNumeric{{SYMS_SUFFIX.id}}(fmt : UFormattable*) : UBool
  fun ufmt_open = ufmt_open{{SYMS_SUFFIX.id}}(status : UErrorCode*) : UFormattable*
  fun version_from_string = u_versionFromString{{SYMS_SUFFIX.id}}(version_array : UVersionInfo, version_string : LibC::Char*)
  fun version_from_u_string = u_versionFromUString{{SYMS_SUFFIX.id}}(version_array : UVersionInfo, version_string : UChar*)
  fun version_to_string = u_versionToString{{SYMS_SUFFIX.id}}(version_array : UVersionInfo, version_string : LibC::Char*)

  struct UCharIterator
    context : Void*
    length : Int32T
    start : Int32T
    index : Int32T
    limit : Int32T
    reserved_field : Int32T
    get_index : (UCharIterator*, UCharIteratorOrigin -> Int32T)
    move : (UCharIterator*, Int32T, UCharIteratorOrigin -> Int32T)
    has_next : (UCharIterator* -> UBool)
    has_previous : (UCharIterator* -> UBool)
    current : (UCharIterator* -> UChar32)
    next : (UCharIterator* -> UChar32)
    previous : (UCharIterator* -> UChar32)
    reserved_fn : (UCharIterator*, Int32T -> Int32T)
    get_state : (UCharIterator* -> Uint32T)
    set_state : (UCharIterator*, Uint32T, UErrorCode* -> Void)
  end

  struct UFieldPosition
    field : Int32T
    begin_index : Int32T
    end_index : Int32T
  end

  struct UParseError
    line : Int32T
    offset : Int32T
    pre_context : UChar[16]
    post_context : UChar[16]
  end

  struct UText
    magic : Uint32T
    flags : Int32T
    provider_properties : Int32T
    size_of_struct : Int32T
    chunk_native_limit : Int64T
    extra_size : Int32T
    native_indexing_limit : Int32T
    chunk_native_start : Int64T
    chunk_offset : Int32T
    chunk_length : Int32T
    chunk_contents : UChar*
    p_funcs : UTextFuncs*
    p_extra : Void*
    context : Void*
    p : Void*
    q : Void*
    r : Void*
    priv_p : Void*
    a : Int64T
    b : Int32T
    c : Int32T
    priv_a : Int64T
    priv_b : Int32T
    priv_c : Int32T
  end

  struct UTextFuncs
    table_size : Int32T
    reserved1 : Int32T
    reserved2 : Int32T
    reserved3 : Int32T
    clone : (UText*, UText*, UBool, UErrorCode* -> UText*)
    native_length : (UText* -> Int64T)
    access : (UText*, Int64T, UBool -> UBool)
    extract : (UText*, Int64T, Int64T, UChar*, Int32T, UErrorCode* -> Int32T)
    replace : (UText*, Int64T, Int64T, UChar*, Int32T, UErrorCode* -> Int32T)
    copy : (UText*, Int64T, Int64T, Int64T, UBool, UErrorCode* -> Void)
    map_offset_to_native : (UText* -> Int64T)
    map_native_index_to_ut_f16 : (UText*, Int64T -> Int32T)
    close : (UText* -> Void)
    spare1 : (UText* -> Void)
    spare2 : (UText* -> Void)
    spare3 : (UText* -> Void)
  end

  type UBreakIterator = Void*
  type UCollator = Void*
  type UEnumeration = Void*
  type USet = Void*
  {% end %}
end

require "./ustring.cr"
require "./utext.cr"
require "./uset.cr"
require "./ucnv.cr"
require "./uloc.cr"
require "./ures.cr"
require "./unorm2.cr"
require "./ucal.cr"
require "./udat.cr"
require "./unum.cr"
require "./utrans.cr"
require "./ubidi.cr"
require "./ucol.cr"
require "./usearch.cr"
require "./ubrk.cr"
require "./uregex.cr"
require "./usprep.cr"
require "./uidna.cr"
require "./uspoof.cr"
require "./utmscale.cr"
require "./ucsdet.cr"
require "./ucurr.cr"
require "./udata.cr"
require "./upluralrules.cr"
require "./uregion.cr"
require "./uenum.cr"
