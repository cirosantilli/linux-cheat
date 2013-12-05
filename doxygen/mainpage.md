This is my custom main page.

Even though this is an `.md` file,
doxygen markup will still apply to it just as if it were inside a C++ comment.

# headers

The markdown version is a bit fussy about spaces: be sure to put a space after the
number sign `#` as: `# header` and *not* `#header`.

# references

Reference to a class: Main2

Reference to a class in a namespace: MainNamespace::Main

Must be in namespace to work: Main

Reference to a method: Main2::method()

Escape a reference to a class: %Main2

Reference to a file: main.cpp

Reference to a global function: ::main(int,char**)

# math

$x^2$

# page

`.dox` files are considered by default by Doxygen, that is,
they are included in the default Doxyfile `FILE_PATTERNS` list.

You must include at least on `\\page` in your `.dox` file for it to be considered by `doxygen`.

# subpage

Subpage does two things:

- create links to other pages
- determines that the other page will be a subpage of this one.

The first argument is the page id set by the `\\page id name` command.

Usage is:

- \subpage dox_cheat_subpage
- \subpage dox_sample "Custom text"

\page dox_cheat_subpage Dox Cheat Subpage

This will produce another Related Pages page.

\page dox_cheat2 Dox Cheat 2

This will produce another Related Pages page.
