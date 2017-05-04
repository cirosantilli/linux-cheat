# CPPPATH

Considers header dependencies on current directory: <http://scons.org/doc/1.1.0/HTML/scons-user/x1056.html>

Modify only the header `lib.h`, and recompile to see if the output changes.

This is known as an external dependency.

TODO: appears to work the same with and without `CPPPATH` (except that the redundant `-I.` gets added to the CLI)?
