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

## Extract data

## xpath

### Multiple attributes from different elements

Impossible? <http://stackoverflow.com/questions/26823736/how-to-parse-out-the-value-of-several-attributes-on-different-elements-with-xmll>

`xmlstarlet` solved it: <http://stackoverflow.com/a/32991889/895245>, looks more output format focused.
