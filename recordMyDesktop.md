# recordeMyDesktop

Makes videos out of your desktop.

Capable of generating only `ogv` container, not `mkv`.

Comes in both command line, and GUI versions. The GUI does not add much, so stick to the CLI.

Most useful command:

    alias rmd='sleep2 && paplay ~/share/sounds/alert.ogg && recordmydesktop --stop-shortcut Control+Mod1+z'

- start recording in 2 seconds
- play a sound before it starts
- stop on `Ctrl + C` on terminal or `Control + Alt + Z` from any window. Rationale: easy to press with a single hand.
- save output to `out.ogv`, `out-1.ogv`, ...

Use if from a drop-down terminal like Guake so in the 2 seconds you can make it disappear.
