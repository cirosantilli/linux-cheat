# xmllint

libxml CLI frontend.

Because it is official to the main XML library, looks like the most robust option out there.

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

## stream

Allows validating large files: <http://stackoverflow.com/questions/7528249/tools-to-validate-large-xml-100mb-file/32992580#32992580>

## Extract data

## xpath

### Multiple attributes from different elements

Impossible? <http://stackoverflow.com/questions/26823736/how-to-parse-out-the-value-of-several-attributes-on-different-elements-with-xmll>

`xmlstarlet` solved it: <http://stackoverflow.com/a/32991889/895245>

## Large files

Validation: `--stream`.

XPATH Queries: <http://stackoverflow.com/questions/30305724/how-to-do-command-line-xpath-queries-in-huge-xml-files> TODO impossible?
