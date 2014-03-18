#formats

##stardict

<http://goldendict.org/dictionaries.php>

for dicts, go: <www.stardict.org/download.php>

##bgl

babylon

windows oriented: exes on site!

can open .exe with 7zip to extract data content

now most exes are downloaders without blgs, probably vendor lockin

I found some that actually contained the blg here:

    http://www.babylon.com/dictionaries-glossaries

#goldendict

fork of stardict

select text can make popup windows!

supported formats: stardict, blg,

#sdcv

command line stardict

supported formats: stardict only

to install dict place it under:

    /usr/share/stardict/dic
    $(HOME)/.stardict/dic

list available dicts:

    sdcv -l

#spell checking

##aspell

###features

can add words to dict

understands some predefined formats!

interactively checks files for spelling errors:

    aspell -c f

if modified, change inline but create `.bak` file

french:

    aspell -l fr -c f

must first install wordlist

same but ignore language constructs (modes):

    aspell --mode=tex -c f
    aspell --mode=html -c f

modes can be added/removed. They are called `filters`

    sudo aspell --add-filter=$f
    sudo aspell --remove-filter=$f

#hunspell

Derived from myspell and mostly backwards compatible.

TODO0

#myspell

Superseeded by hunspell.
