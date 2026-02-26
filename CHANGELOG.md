# Changelog

## 1.2.0 - 2026-02-25
### New components
- `ICU::Regex` — Unicode-aware regular expressions
- `ICU::Converter` & `ICU::ConverterSelector` — Codepage and character encoding conversion
- `ICU::SpoofChecker` — Identifier security and confusability detection


## 1.1.0 - 2026-02-25
### Improvements
- Added spec file for `ICU::USet` (missing from v1.0.2)


## 1.0.3 - 2026-02-25
### Bug fixes
- Added missing implementation file for `ICU::USet` (introduced in v1.0.2 but incomplete)


## 1.0.2 - 2026-02-25
### New component
- `ICU::USet` — Sets of Unicode code points and strings

### API extensions
- `ICU::Collator#tailored_set` — returns the set of characters customized by the collator
- `ICU::Collator#contractions` — returns contraction start characters as a `USet`
- `ICU::Collator#contractions_and_expansions` — returns contraction and expansion character sets
- `ICU::Transliterator#source_set` — returns the set of characters the transliterator may modify


## 1.0.1 - 2026-02-25
### Breaking changes
- `BiDi::ReorderingOption::Default` renamed to `BiDi::ReorderingOption::None` to follow the `@[Flags]` enum convention (zero value must be named `None`)
- `UEnum` constructor now requires an explicit `owns:` keyword argument to clarify object lifetime/ownership semantics

### Bug fixes
- `Calendar#get_time_zone_id` — was ignoring the actual length returned by ICU and could return garbage characters
- `NumberFormatter#format` — fixed buffer handling to reliably format numbers
- `Locale#add_keyword_value` — fixed incorrect initial buffer size computation
- `DateTimeFormatter` — fixed inconsistent initialization of the internal calendar in the pattern-based constructor
- `PluralRules#select(Int)` — fixed to use an auto-resizing buffer


## 1.0.0 - 2025-05-06
Initial release. Provides Crystal bindings and wrappers for the following ICU components:
- `ICU::CharsetDetector` — detect the character encoding of a byte sequence
- `ICU::BreakIterator` — locale-aware text segmentation (words, sentences, lines, grapheme clusters)
- `ICU::Transliterator` — rule-based transliteration between scripts
- `ICU::Normalizer` — Unicode normalization (NFC, NFD, NFKC, NFKD, …)
- `ICU::Collator` — locale-sensitive string comparison and sorting
- `ICU::StringSearch` — locale-sensitive substring search
- `ICU::Locale` — locale parsing, creation, and introspection
- `ICU::IDNA` — internationalized domain names (IDNA 2008)
- `ICU::Currencies` — currency codes and display names
- `ICU::Region` — region codes and containment
- `ICU::NumberFormatter` — locale-aware number formatting
- `ICU::DateTimeFormatter` — locale-aware date/time formatting and parsing
- `ICU::Calendar` — calendar arithmetic and time zone support
- `ICU::UniversalTimeScale` — conversion between different time representations
- `ICU::PluralRules` — plural category selection for a given locale
- `ICU::BiDi` — Unicode Bidirectional Algorithm

Compatible with ICU ≥ 4.8. Features are automatically enabled at compile time based on the installed ICU version.
