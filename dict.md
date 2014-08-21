#Formats

##stardict

<http://goldendict.org/dictionaries.php>

For dicts, go: <www.stardict.org/download.php>

##bgl

Babylon.

Windows oriented: exes on site!

Can open .exe with 7zip to extract data content.

Now most exes are downloaders without blgs, probably vendor lock-in.

I found some that actually contained the blg here:

    http://www.babylon.com/dictionaries-glossaries

#Goldendict

Fork of stardict.

Select text can make popup windows!

Supported formats: stardict, blg,

#sdcv

Command line stardict.

Supported formats: stardict only.

To install dict place it under:

    /usr/share/stardict/dic
    $(HOME)/.stardict/dic

List available dicts:

    sdcv -l

#Spell checking

##aspell

###features

Can add words to dict.

Understands some predefined formats!

Interactively checks files for spelling errors:

    aspell -c f

If modified, change inline but create `.bak` file.

French:

    aspell -l fr -c f

Must first install wordlist.

Same but ignore language constructs (modes):

    aspell --mode=tex -c f
    aspell --mode=html -c f

Modes can be added/removed. They are called `filters`:

    sudo aspell --add-filter=$f
    sudo aspell --remove-filter=$f

#hunspell

Derived from myspell and mostly backwards compatible.

TODO0

#myspell

Superseeded by hunspell.
