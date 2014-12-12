# Dictionary

## Formats

### stardict

<http://goldendict.org/dictionaries.php>

For dictionaries see: <http://www.stardict.org/download.php>

### bgl

Babylon.

Windows oriented: exes on site!

Can open .exe with 7zip to extract data content.

Now most exes are downloaders without `blgs`, probably vendor lock-in.

I found some that actually contained the `blg` here:

    http://www.babylon.com/dictionaries-glossaries

## GoldenDict

Fork of StarDict.

Select text can make popup windows!

Supported formats: StarDict, `blg`.

## sdcv

Command line for StarDict.

Supported formats: StarDict only.

To install a dictionary, place it under:

    /usr/share/stardict/dic
    $(HOME)/.stardict/dic

List available dictionaries:

    sdcv -l

## Spell checking

### Aspell

#### Features

Can add words to dictionary.

Understands some predefined formats!

Interactively checks files for spelling errors:

    aspell -c f

If modified, change inline but create `.bak` file.

French:

    aspell -l fr -c f

Must first install the word lists.

Same but ignore language constructs (modes):

    aspell --mode=tex -c f
    aspell --mode=html -c f

Modes can be added/removed. They are called `filters`:

    sudo aspell --add-filter=$f
    sudo aspell --remove-filter=$f

## Hunspell

Derived from MySpell and mostly backwards compatible.

## MySpell

Superseded by Hunspell.
