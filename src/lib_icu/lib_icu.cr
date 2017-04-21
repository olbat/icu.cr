@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs icu-uc icu-i18n icu-io icu-lx icu-le || printf %s '-licuio -licui18n -liculx -licule -licuuc -licudata'`")]
lib LibICU
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
    UcalEra               =  0
    UcalYear              =  1
    UcalMonth             =  2
    UcalWeekOfYear        =  3
    UcalWeekOfMonth       =  4
    UcalDate              =  5
    UcalDayOfYear         =  6
    UcalDayOfWeek         =  7
    UcalDayOfWeekInMonth  =  8
    UcalAmPm              =  9
    UcalHour              = 10
    UcalHourOfDay         = 11
    UcalMinute            = 12
    UcalSecond            = 13
    UcalMillisecond       = 14
    UcalZoneOffset        = 15
    UcalDstOffset         = 16
    UcalYearWoy           = 17
    UcalDowLocal          = 18
    UcalExtendedYear      = 19
    UcalJulianDay         = 20
    UcalMillisecondsInDay = 21
    UcalIsLeapMonth       = 22
    UcalFieldCount        = 23
    UcalDayOfMonth        =  5
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
    UiterStart   = 0
    UiterCurrent = 1
    UiterLimit   = 2
    UiterZero    = 3
    UiterLength  = 4
  end
  enum UCharNameChoice
    UUnicodeCharName     = 0
    UUnicode10CharName   = 1
    UExtendedCharName    = 2
    UCharNameAlias       = 3
    UCharNameChoiceCount = 4
  end
  enum UErrorCode
    UUsingFallbackWarning        =  -128
    UErrorWarningStart           =  -128
    UUsingDefaultWarning         =  -127
    USafecloneAllocatedWarning   =  -126
    UStateOldWarning             =  -125
    UStringNotTerminatedWarning  =  -124
    USortKeyTooShortWarning      =  -123
    UAmbiguousAliasWarning       =  -122
    UDifferentUcaVersion         =  -121
    UPluginChangedLevelWarning   =  -120
    UErrorWarningLimit           =  -119
    UZeroError                   =     0
    UIllegalArgumentError        =     1
    UMissingResourceError        =     2
    UInvalidFormatError          =     3
    UFileAccessError             =     4
    UInternalProgramError        =     5
    UMessageParseError           =     6
    UMemoryAllocationError       =     7
    UIndexOutofboundsError       =     8
    UParseError                  =     9
    UInvalidCharFound            =    10
    UTruncatedCharFound          =    11
    UIllegalCharFound            =    12
    UInvalidTableFormat          =    13
    UInvalidTableFile            =    14
    UBufferOverflowError         =    15
    UUnsupportedError            =    16
    UResourceTypeMismatch        =    17
    UIllegalEscapeSequence       =    18
    UUnsupportedEscapeSequence   =    19
    UNoSpaceAvailable            =    20
    UCeNotFoundError             =    21
    UPrimaryTooLongError         =    22
    UStateTooOldError            =    23
    UTooManyAliasesError         =    24
    UEnumOutOfSyncError          =    25
    UInvariantConversionError    =    26
    UInvalidStateError           =    27
    UCollatorVersionMismatch     =    28
    UUselessCollatorError        =    29
    UNoWritePermission           =    30
    UStandardErrorLimit          =    31
    UBadVariableDefinition       = 65536
    UParseErrorStart             = 65536
    UMalformedRule               = 65537
    UMalformedSet                = 65538
    UMalformedSymbolReference    = 65539
    UMalformedUnicodeEscape      = 65540
    UMalformedVariableDefinition = 65541
    UMalformedVariableReference  = 65542
    UMismatchedSegmentDelimiters = 65543
    UMisplacedAnchorStart        = 65544
    UMisplacedCursorOffset       = 65545
    UMisplacedQuantifier         = 65546
    UMissingOperator             = 65547
    UMissingSegmentClose         = 65548
    UMultipleAnteContexts        = 65549
    UMultipleCursors             = 65550
    UMultiplePostContexts        = 65551
    UTrailingBackslash           = 65552
    UUndefinedSegmentReference   = 65553
    UUndefinedVariable           = 65554
    UUnquotedSpecial             = 65555
    UUnterminatedQuote           = 65556
    URuleMaskError               = 65557
    UMisplacedCompoundFilter     = 65558
    UMultipleCompoundFilters     = 65559
    UInvalidRbtSyntax            = 65560
    UInvalidPropertyPattern      = 65561
    UMalformedPragma             = 65562
    UUnclosedSegment             = 65563
    UIllegalCharInSegment        = 65564
    UVariableRangeExhausted      = 65565
    UVariableRangeOverlap        = 65566
    UIllegalCharacter            = 65567
    UInternalTransliteratorError = 65568
    UInvalidId                   = 65569
    UInvalidFunction             = 65570
    UParseErrorLimit             = 65571
    UUnexpectedToken             = 65792
    UFmtParseErrorStart          = 65792
    UMultipleDecimalSeparators   = 65793
    UMultipleDecimalSeperators   = 65793
    UMultipleExponentialSymbols  = 65794
    UMalformedExponentialPattern = 65795
    UMultiplePercentSymbols      = 65796
    UMultiplePermillSymbols      = 65797
    UMultiplePadSpecifiers       = 65798
    UPatternSyntaxError          = 65799
    UIllegalPadPosition          = 65800
    UUnmatchedBraces             = 65801
    UUnsupportedProperty         = 65802
    UUnsupportedAttribute        = 65803
    UArgumentTypeMismatch        = 65804
    UDuplicateKeyword            = 65805
    UUndefinedKeyword            = 65806
    UDefaultKeywordMissing       = 65807
    UDecimalNumberSyntaxError    = 65808
    UFormatInexactError          = 65809
    UFmtParseErrorLimit          = 65810
    UBrkInternalError            = 66048
    UBrkErrorStart               = 66048
    UBrkHexDigitsExpected        = 66049
    UBrkSemicolonExpected        = 66050
    UBrkRuleSyntax               = 66051
    UBrkUnclosedSet              = 66052
    UBrkAssignError              = 66053
    UBrkVariableRedfinition      = 66054
    UBrkMismatchedParen          = 66055
    UBrkNewLineInQuotedString    = 66056
    UBrkUndefinedVariable        = 66057
    UBrkInitError                = 66058
    UBrkRuleEmptySet             = 66059
    UBrkUnrecognizedOption       = 66060
    UBrkMalformedRuleTag         = 66061
    UBrkErrorLimit               = 66062
    URegexInternalError          = 66304
    URegexErrorStart             = 66304
    URegexRuleSyntax             = 66305
    URegexInvalidState           = 66306
    URegexBadEscapeSequence      = 66307
    URegexPropertySyntax         = 66308
    URegexUnimplemented          = 66309
    URegexMismatchedParen        = 66310
    URegexNumberTooBig           = 66311
    URegexBadInterval            = 66312
    URegexMaxLtMin               = 66313
    URegexInvalidBackRef         = 66314
    URegexInvalidFlag            = 66315
    URegexLookBehindLimit        = 66316
    URegexSetContainsString      = 66317
    URegexOctalTooBig            = 66318
    URegexMissingCloseBracket    = 66319
    URegexInvalidRange           = 66320
    URegexStackOverflow          = 66321
    URegexTimeOut                = 66322
    URegexStoppedByCaller        = 66323
    URegexPatternTooBig          = 66324
    URegexErrorLimit             = 66325
    UIdnaProhibitedError         = 66560
    UIdnaErrorStart              = 66560
    UIdnaUnassignedError         = 66561
    UIdnaCheckBidiError          = 66562
    UIdnaStD3AsciiRulesError     = 66563
    UIdnaAcePrefixError          = 66564
    UIdnaVerificationError       = 66565
    UIdnaLabelTooLongError       = 66566
    UIdnaZeroLengthLabelError    = 66567
    UIdnaDomainNameTooLongError  = 66568
    UIdnaErrorLimit              = 66569
    UStringprepProhibitedError   = 66560
    UStringprepUnassignedError   = 66561
    UStringprepCheckBidiError    = 66562
    UPluginErrorStart            = 66816
    UPluginTooHigh               = 66816
    UPluginDidntSetLevel         = 66817
    UPluginErrorLimit            = 66818
    UErrorLimit                  = 66818
  end
  enum UFormattableType
    UfmtDate   = 0
    UfmtDouble = 1
    UfmtLong   = 2
    UfmtString = 3
    UfmtArray  = 4
    UfmtInT64  = 5
    UfmtObject = 6
    UfmtCount  = 7
  end
  enum ULocDataLocaleType
    UlocActualLocale        = 0
    UlocValidLocale         = 1
    UlocRequestedLocale     = 2
    UlocDataLocaleTypeLimit = 3
  end
  enum UProperty
    UcharAlphabetic                   =     0
    UcharBinaryStart                  =     0
    UcharAsciiHexDigit                =     1
    UcharBidiControl                  =     2
    UcharBidiMirrored                 =     3
    UcharDash                         =     4
    UcharDefaultIgnorableCodePoint    =     5
    UcharDeprecated                   =     6
    UcharDiacritic                    =     7
    UcharExtender                     =     8
    UcharFullCompositionExclusion     =     9
    UcharGraphemeBase                 =    10
    UcharGraphemeExtend               =    11
    UcharGraphemeLink                 =    12
    UcharHexDigit                     =    13
    UcharHyphen                       =    14
    UcharIdContinue                   =    15
    UcharIdStart                      =    16
    UcharIdeographic                  =    17
    UcharIdsBinaryOperator            =    18
    UcharIdsTrinaryOperator           =    19
    UcharJoinControl                  =    20
    UcharLogicalOrderException        =    21
    UcharLowercase                    =    22
    UcharMath                         =    23
    UcharNoncharacterCodePoint        =    24
    UcharQuotationMark                =    25
    UcharRadical                      =    26
    UcharSoftDotted                   =    27
    UcharTerminalPunctuation          =    28
    UcharUnifiedIdeograph             =    29
    UcharUppercase                    =    30
    UcharWhiteSpace                   =    31
    UcharXidContinue                  =    32
    UcharXidStart                     =    33
    UcharCaseSensitive                =    34
    UcharSTerm                        =    35
    UcharVariationSelector            =    36
    UcharNfdInert                     =    37
    UcharNfkdInert                    =    38
    UcharNfcInert                     =    39
    UcharNfkcInert                    =    40
    UcharSegmentStarter               =    41
    UcharPatternSyntax                =    42
    UcharPatternWhiteSpace            =    43
    UcharPosixAlnum                   =    44
    UcharPosixBlank                   =    45
    UcharPosixGraph                   =    46
    UcharPosixPrint                   =    47
    UcharPosixXdigit                  =    48
    UcharCased                        =    49
    UcharCaseIgnorable                =    50
    UcharChangesWhenLowercased        =    51
    UcharChangesWhenUppercased        =    52
    UcharChangesWhenTitlecased        =    53
    UcharChangesWhenCasefolded        =    54
    UcharChangesWhenCasemapped        =    55
    UcharChangesWhenNfkcCasefolded    =    56
    UcharBinaryLimit                  =    57
    UcharBidiClass                    =  4096
    UcharIntStart                     =  4096
    UcharBlock                        =  4097
    UcharCanonicalCombiningClass      =  4098
    UcharDecompositionType            =  4099
    UcharEastAsianWidth               =  4100
    UcharGeneralCategory              =  4101
    UcharJoiningGroup                 =  4102
    UcharJoiningType                  =  4103
    UcharLineBreak                    =  4104
    UcharNumericType                  =  4105
    UcharScript                       =  4106
    UcharHangulSyllableType           =  4107
    UcharNfdQuickCheck                =  4108
    UcharNfkdQuickCheck               =  4109
    UcharNfcQuickCheck                =  4110
    UcharNfkcQuickCheck               =  4111
    UcharLeadCanonicalCombiningClass  =  4112
    UcharTrailCanonicalCombiningClass =  4113
    UcharGraphemeClusterBreak         =  4114
    UcharSentenceBreak                =  4115
    UcharWordBreak                    =  4116
    UcharBidiPairedBracketType        =  4117
    UcharIntLimit                     =  4118
    UcharGeneralCategoryMask          =  8192
    UcharMaskStart                    =  8192
    UcharMaskLimit                    =  8193
    UcharNumericValue                 = 12288
    UcharDoubleStart                  = 12288
    UcharDoubleLimit                  = 12289
    UcharAge                          = 16384
    UcharStringStart                  = 16384
    UcharBidiMirroringGlyph           = 16385
    UcharCaseFolding                  = 16386
    UcharIsoComment                   = 16387
    UcharLowercaseMapping             = 16388
    UcharName                         = 16389
    UcharSimpleCaseFolding            = 16390
    UcharSimpleLowercaseMapping       = 16391
    UcharSimpleTitlecaseMapping       = 16392
    UcharSimpleUppercaseMapping       = 16393
    UcharTitlecaseMapping             = 16394
    UcharUnicode1Name                 = 16395
    UcharUppercaseMapping             = 16396
    UcharBidiPairedBracket            = 16397
    UcharStringLimit                  = 16398
    UcharScriptExtensions             = 28672
    UcharOtherPropertyStart           = 28672
    UcharOtherPropertyLimit           = 28673
    UcharInvalidCode                  =    -1
  end
  enum UPropertyNameChoice
    UShortPropertyName       = 0
    ULongPropertyName        = 1
    UPropertyNameChoiceCount = 2
  end
  fun u_char_age = u_charAge_52(c : UChar32, version_array : UVersionInfo)
  fun u_char_digit_value = u_charDigitValue_52(c : UChar32) : Int32T
  fun u_char_direction = u_charDirection_52(c : UChar32) : UCharDirection
  fun u_char_from_name = u_charFromName_52(name_choice : UCharNameChoice, name : LibC::Char*, p_error_code : UErrorCode*) : UChar32
  fun u_char_mirror = u_charMirror_52(c : UChar32) : UChar32
  fun u_char_name = u_charName_52(code : UChar32, name_choice : UCharNameChoice, buffer : LibC::Char*, buffer_length : Int32T, p_error_code : UErrorCode*) : Int32T
  fun u_char_type = u_charType_52(c : UChar32) : Int8T
  fun u_chars_to_u_chars = u_charsToUChars_52(cs : LibC::Char*, us : UChar*, length : Int32T)
  fun u_digit = u_digit_52(ch : UChar32, radix : Int8T) : Int32T
  fun u_enum_char_names = u_enumCharNames_52(start : UChar32, limit : UChar32, fn : (Void*, UChar32, UCharNameChoice, LibC::Char*, Int32T -> UBool), context : Void*, name_choice : UCharNameChoice, p_error_code : UErrorCode*)
  fun u_enum_char_types = u_enumCharTypes_52(enum_range : (Void*, UChar32, UChar32, UCharCategory -> UBool), context : Void*)
  fun u_error_name = u_errorName_52(code : UErrorCode) : LibC::Char*
  fun u_fold_case = u_foldCase_52(c : UChar32, options : Uint32T) : UChar32
  fun u_for_digit = u_forDigit_52(digit : Int32T, radix : Int8T) : UChar32
  fun u_get_bidi_paired_bracket = u_getBidiPairedBracket_52(c : UChar32) : UChar32
  fun u_get_combining_class = u_getCombiningClass_52(c : UChar32) : Uint8T
  fun u_get_data_directory = u_getDataDirectory_52 : LibC::Char*
  fun u_get_fc_nfkc_closure = u_getFC_NFKC_Closure_52(c : UChar32, dest : UChar*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun u_get_int_property_max_value = u_getIntPropertyMaxValue_52(which : UProperty) : Int32T
  fun u_get_int_property_min_value = u_getIntPropertyMinValue_52(which : UProperty) : Int32T
  fun u_get_int_property_value = u_getIntPropertyValue_52(c : UChar32, which : UProperty) : Int32T
  fun u_get_iso_comment = u_getISOComment_52(c : UChar32, dest : LibC::Char*, dest_capacity : Int32T, p_error_code : UErrorCode*) : Int32T
  fun u_get_numeric_value = u_getNumericValue_52(c : UChar32) : LibC::Double
  fun u_get_property_enum = u_getPropertyEnum_52(alias : LibC::Char*) : UProperty
  fun u_get_property_name = u_getPropertyName_52(property : UProperty, name_choice : UPropertyNameChoice) : LibC::Char*
  fun u_get_property_value_enum = u_getPropertyValueEnum_52(property : UProperty, alias : LibC::Char*) : Int32T
  fun u_get_property_value_name = u_getPropertyValueName_52(property : UProperty, value : Int32T, name_choice : UPropertyNameChoice) : LibC::Char*
  fun u_get_unicode_version = u_getUnicodeVersion_52(version_array : UVersionInfo)
  fun u_get_version = u_getVersion_52(version_array : UVersionInfo)
  fun u_has_binary_property = u_hasBinaryProperty_52(c : UChar32, which : UProperty) : UBool
  fun u_is_id_ignorable = u_isIDIgnorable_52(c : UChar32) : UBool
  fun u_is_id_part = u_isIDPart_52(c : UChar32) : UBool
  fun u_is_id_start = u_isIDStart_52(c : UChar32) : UBool
  fun u_is_iso_control = u_isISOControl_52(c : UChar32) : UBool
  fun u_is_java_id_part = u_isJavaIDPart_52(c : UChar32) : UBool
  fun u_is_java_id_start = u_isJavaIDStart_52(c : UChar32) : UBool
  fun u_is_java_space_char = u_isJavaSpaceChar_52(c : UChar32) : UBool
  fun u_is_mirrored = u_isMirrored_52(c : UChar32) : UBool
  fun u_is_u_alphabetic = u_isUAlphabetic_52(c : UChar32) : UBool
  fun u_is_u_lowercase = u_isULowercase_52(c : UChar32) : UBool
  fun u_is_u_uppercase = u_isUUppercase_52(c : UChar32) : UBool
  fun u_is_u_white_space = u_isUWhiteSpace_52(c : UChar32) : UBool
  fun u_is_whitespace = u_isWhitespace_52(c : UChar32) : UBool
  fun u_isalnum = u_isalnum_52(c : UChar32) : UBool
  fun u_isalpha = u_isalpha_52(c : UChar32) : UBool
  fun u_isbase = u_isbase_52(c : UChar32) : UBool
  fun u_isblank = u_isblank_52(c : UChar32) : UBool
  fun u_iscntrl = u_iscntrl_52(c : UChar32) : UBool
  fun u_isdefined = u_isdefined_52(c : UChar32) : UBool
  fun u_isdigit = u_isdigit_52(c : UChar32) : UBool
  fun u_isgraph = u_isgraph_52(c : UChar32) : UBool
  fun u_islower = u_islower_52(c : UChar32) : UBool
  fun u_isprint = u_isprint_52(c : UChar32) : UBool
  fun u_ispunct = u_ispunct_52(c : UChar32) : UBool
  fun u_isspace = u_isspace_52(c : UChar32) : UBool
  fun u_istitle = u_istitle_52(c : UChar32) : UBool
  fun u_isupper = u_isupper_52(c : UChar32) : UBool
  fun u_isxdigit = u_isxdigit_52(c : UChar32) : UBool
  fun u_set_data_directory = u_setDataDirectory_52(directory : LibC::Char*)
  fun u_tolower = u_tolower_52(c : UChar32) : UChar32
  fun u_totitle = u_totitle_52(c : UChar32) : UChar32
  fun u_toupper = u_toupper_52(c : UChar32) : UChar32
  fun u_u_chars_to_chars = u_UCharsToChars_52(us : UChar*, cs : LibC::Char*, length : Int32T)
  fun u_version_from_string = u_versionFromString_52(version_array : UVersionInfo, version_string : LibC::Char*)
  fun u_version_from_u_string = u_versionFromUString_52(version_array : UVersionInfo, version_string : UChar*)
  fun u_version_to_string = u_versionToString_52(version_array : UVersionInfo, version_string : LibC::Char*)
  fun ufmt_close = ufmt_close_52(fmt : UFormattable*)
  fun ufmt_get_array_item_by_index = ufmt_getArrayItemByIndex_52(fmt : UFormattable*, n : Int32T, status : UErrorCode*) : UFormattable*
  fun ufmt_get_array_length = ufmt_getArrayLength_52(fmt : UFormattable*, status : UErrorCode*) : Int32T
  fun ufmt_get_date = ufmt_getDate_52(fmt : UFormattable*, status : UErrorCode*) : UDate
  fun ufmt_get_dec_num_chars = ufmt_getDecNumChars_52(fmt : UFormattable*, len : Int32T*, status : UErrorCode*) : LibC::Char*
  fun ufmt_get_double = ufmt_getDouble_52(fmt : UFormattable*, status : UErrorCode*) : LibC::Double
  fun ufmt_get_int64 = ufmt_getInt64_52(fmt : UFormattable*, status : UErrorCode*) : Int64T
  fun ufmt_get_long = ufmt_getLong_52(fmt : UFormattable*, status : UErrorCode*) : Int32T
  fun ufmt_get_object = ufmt_getObject_52(fmt : UFormattable*, status : UErrorCode*) : Void*
  fun ufmt_get_type = ufmt_getType_52(fmt : UFormattable*, status : UErrorCode*) : UFormattableType
  fun ufmt_get_u_chars = ufmt_getUChars_52(fmt : UFormattable*, len : Int32T*, status : UErrorCode*) : UChar*
  fun ufmt_is_numeric = ufmt_isNumeric_52(fmt : UFormattable*) : UBool
  fun ufmt_open = ufmt_open_52(status : UErrorCode*) : UFormattable*

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
