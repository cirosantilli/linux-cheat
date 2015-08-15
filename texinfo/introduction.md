# Introduction

Format used for all GNU docs.

Gotta learn it if you will contribute to GNU.

The reference implementation is `mkinfo`. It can output:

- HTML
- info files, viewable with the `info` utility
- PDF (uses LaTeX)

Format documentation: <http://www.gnu.org/software/texinfo/manual/texinfo/texinfo.html>

## Pros and cons

Quite nice format actually, maybe even neater syntax than LaTeX, but more focused on manual page writing than mathematics.

Unlike Autotools and Guile, GNU got it right this time.

Cons:

- tools that generate documentation from source code comments like Doxygen are better than this. You can't beat those if they are available for your language, as they put documentation close to the source, making it easier for programmers to find them while hacking, and increasing the probability that both will be updated.

- there are two methods for creating headers: chpater / setions *and* menu nodes. This leads to a lot of duplication, as manuals tend to use both.
