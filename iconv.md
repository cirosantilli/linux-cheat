# iconv

Convert character encodings.

List available encodings:

    iconv -l

Convert contents of F from BIG-FIVE to UTF-8:

    iconv -f BIG-FIVE -t UTF-8 "$F"

No changes made to file: only outputs to stdout.
