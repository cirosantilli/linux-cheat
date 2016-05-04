# Game engines

Lists:

https://github.com/showcases/game-engines
http://www.greatsoftline.com/the-best-open-source-game-engine-in-search-of-perfection/

## libgdx

GitHub number 1

<https://github.com/libgdx/libgdx>

Lists of games that use it:

- <https://www.quora.com/What-are-the-most-popular-games-written-in-libGDX>
- <https://www.reddit.com/r/gamedev/comments/1qzvdg/games_using_libgdx/>

Offers a nice Java API.

Games that use it:

- Five nights at Freddie's

TODO how to run demos locally / install and run a hello world?

    sudo apt-get install gradle
    git clone https://github.com/libgdx/libgdx
    cd libgcx

- http://askubuntu.com/questions/432812/installed-libgdx-and-opengl-in-ubuntu
- http://askubuntu.com/questions/537730/setting-up-libgdx-on-ubuntu-14-04

## Irrlicht

<http://irrlicht.sourceforge.net/>

<https://en.wikipedia.org/wiki/Irrlicht_Engine>

Run examples: align with your OS package manager installed version:

    svn checkout svn://svn.code.sf.net/p/irrlicht/code/branches/releases/1.8 irrlicht
    cd irrlicht/exmaples
    ./buildAllExamples.sh
    cd ../bin/Linux

## XNA

<https://en.wikipedia.org/wiki/Microsoft_XNA>

Dead: <http://www.gamasutra.com/view/news/185894/Its_official_XNA_is_dead.php>

## Ogre

<http://www.ogre3d.org>

Not a game engine, only a rendering engine.

Run samples:

    hg clone https://bitbucket.org/sinbad/ogre/
    hg checkout # TODO
    mkdir -p build
    cd build
    cmake ..
    make

## Cocos2D-x

2D games only.

C++ API.

Used for:

- Badlands
- Castle Clash

## Python 2D

Feels old.

Showcase:

- <https://www.quora.com/What-are-the-most-fun-and-coolest-games-built-with-pygame>
- <http://inventwithpython.com/blog/2013/02/19/what-professional-games-use-pygame/>

## Proprietary

### Unity

Very popular.

Free to start using, charges a percent of game profit after 5k units sold or something.

Has an asset store! <https://www.assetstore.unity3d.com/en/>
