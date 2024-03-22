# Crystal ICU
Crystal binding/wrapper to the [ICU](http://site.icu-project.org/) library


## Installation
__Debian/Ubuntu__
```bash
apt-get install -y libicu-dev
```

__macOS__
```bash
brew install icu4c
brew link --force icu4c
```


## Usage

Add this to your application's `shard.yml`:
```yaml
dependencies:
  icu:
    github: olbat/icu.cr
```

Then require the lib in your Crystal code:
```crystal
require "icu"
```


## Wrapped components (WIP)
- [x] [CharsetDetector](https://olbat.github.io/icu.cr/ICU/CharsetDetector.html), Charset detection _(ucsdet.h)_
- [x] [BreakIterator](https://olbat.github.io/icu.cr/ICU/BreakIterator.html), Text Boundary Analysis (Break Iteration) _(ubrk.h)_
- [x] [Transliterator](https://olbat.github.io/icu.cr/ICU/Transliterator.html), Text Transformation (Transliteration) _(utrans.h)_
- [x] [Normalizer](https://olbat.github.io/icu.cr/ICU/Normalizer.html), Normalization _(unorm2.h)_
- [x] [Collator](https://olbat.github.io/icu.cr/ICU/Collator.html), Collation _(ucol.h)_
- [x] [StringSearch](https://olbat.github.io/icu.cr/ICU/StringSearch.html), String Searching _(usearch.h)_
- [x] [IDNA](https://olbat.github.io/icu.cr/ICU/IDNA.html), International Domain Names in Applications _(uidna.h)_
- [x] [Currencies](https://olbat.github.io/icu.cr/ICU/Currencies.html), Encapsulates information about a currency _(ucurr.h)_
- [x] [Region](https://olbat.github.io/icu.cr/ICU/Region.html), Territory containment and mapping _(uregion.h)_
- [x] [UniversalTimeScale](https://olbat.github.io/icu.cr/ICU/UniversalTimeScale.html), Universal Time Scale _(utmscale.h)_
- [ ] `uregex`, Regular Expressions _(uregex.h)_
- [ ] `uloc`, Locales _(uloc.h, ulocdata.h)_
- [ ] `unum`, Number Formatting/Spellout _(unum.h)_
- [ ] `ubidi`, Bidirectional Algorithm _(ubidi.h)_
- [ ] `ucnv`, Codepage Conversion _(ucnv.h, ucnvsel.h)_
- [ ] `ucal`, Calendars _(ucal.h)_
- [ ] `udat`, Date and Time Formatting _(udat.h, udatpg.h, udateintervalformat.h)_
- [ ] `upluralrules`, Plural rules _(upluralrules.h)_

__Internals__
- [x] [UChars](https://olbat.github.io/icu.cr/ICU/UChars.html), UChar conversion routines
- [x] [UEnum](https://olbat.github.io/icu.cr/ICU/UEnum.html), String Enumeration _(uenum.h)_
- [ ] `ustring`, Strings and Character Iteration _(ustring.h, uiter.h)_
- [ ] `utext`, Abstract Unicode Text API _(utext.h)_
- [ ] `uset`, Sets of Unicode Code Points and Strings _(uset.h)_
- [ ] `ures`, Resource Bundles _(ures.h)_
- [ ] `usprep`, StringPrep _(usprep.h)_
- [ ] `uspoof`, Identifier Spoofing & Confusability _(uspoof.h)_
- [ ] `udata`, Data loading interface _(udata.h)_


## Development

### ICU version compatibility
This binding is compatible with the ICU library starting from version `4.8`.
It has been [generated](lib.yml) using ICU version `57.1` so every additions in the API from this version will not be present in this binding.

The Crystal wrapper's (the `ICU` class) class and methods are enabled dynamically at compile-time depending on the version of the ICU library that's installed.

Please make sure that the class/feature you want to use is supported by your version ICU by checking the [API documentation](http://icu-project.org/apiref/icu4c/).

### Regenerate the binding
To be sure that the `LibICU` binding fits with the version of the lib that's installed, it's possible to regenerate the binding by:

1. Installing libgen and it's dependencies (cf. [libgen's documentation](https://github.com/olbat/libgen#installation))
2. Run libgen and the lib_transformer program by running `make generate_lib`

### Project's structure
- `src/lib_icu`: this directory contains the [binding](https://crystal-lang.org/docs/syntax_and_semantics/c_bindings/lib.html) to the ICU library, it's generated by [libgen](https://github.com/olbat/libgen) & a [transformation program](src/lib_transformer.cr)
- `src/icu`: this directory contains the wrapper to the `LibICU` crystal lib that eases the usage of the binding
- `src/icu_info.cr`: this small program is used to determine which version of ICU is installed on the system (see [#1](https://github.com/olbat/icu.cr/issues/1))
- `src/lib_transformer.cr`: this small program is used to fix the binding generated by libgen (see [#3](https://github.com/olbat/icu.cr/issues/3))

### About the binding's generation

For implementation and technical details about the binding's generation, see [#1](https://github.com/olbat/icu.cr/issues/1) & [#3](https://github.com/olbat/icu.cr/issues/3).


## Contributing

1. Fork it ( https://github.com/olbat/icu.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [olbat](https://github.com/olbat) Luc Sarzyniec - creator, maintainer
