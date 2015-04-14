# xmllint

libxml CLI frontend.

## Without arguments

Usage:

    xmllint min.xml

Checks if:

- well formed
- entity loops like the billion laughs attack

Does not check for DTD validity: use `--valid` for that.

## format

Pretty print:

    xmllint --format min.xml

## valid

Also check DTD validity:

    xmllint --format min.xml

## schema

Check XSD validity:

    xmllint --schema schema.xsd min.xml
