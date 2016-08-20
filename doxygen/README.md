# Doxygen

Generate API documentation from formatted comments for C, C++, Java, Python and other languages.

De facto standard for C++ used in many major projects such as KDE.

The most common type of output is html, which creates html anchors links between functions and classes (ex return value, arguments).

Besides API doc generation for end users, Doxygen can also generate useful information to help understand code structure and implementation. Those include:

- browsable source code
- inheritance graphs
- call graphs

First, generate a configuration template file called `Doxyfile`:

    doxygen -g

this template is very large and seems to contain all possible options with explanations.

Using `Doxyfile` configuration in current dir, generate the docs;

    doxygen
