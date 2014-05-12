Markdown is much more popular than rst except for the Python community.

Disadvantages over markdown: it is more verbose in important use cases.

-   Setext `===` style headers *and* without fixed order. Too verbose with respect to ATX `#`, and extremely confusing because no fixed order, e.g. `=` is always `h1`, etc.

-   double quotes for code:

        ``code``

    Code is used too often.

Advantages over markdown:

-   an standard extension mechanism.

`docutils` is a Python package for generating code documentation.

It also contains the specification of `reStructuredTest` and the reference implementations `rst2pdf` and `rst2html`.

While written in and mostly associated with Python, it can also be used to generate C/C++ docs, so i put it here.

Install:

    sudo pip install docutils

Docs: <http://docutils.sourceforge.net/docs/index.html>
