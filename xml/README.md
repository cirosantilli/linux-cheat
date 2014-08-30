# XML

Very popular plain text data exchange format.

Specified by W3C at: <http://www.w3.org/TR/xml/>. Currently equals the latest stable: XML 1.0 (2008).

Represents data on a tree structure.

Can be easily extended to define new formats, and several key formats are based on it:

- `.docx`, `.odt`, and the other office applications
- SVG
- MathML

HTML looks a lot like XML, but is *not* valid XML for several new syntaxes which are more convenient to web developers. XHTML, an HTML variant version which really is XML.

Minimal XML document:

- XML documents must have a root element.

## Well formed

## Valid

A well formed document has the correct XML syntax.

A valid document is well formed, and also obeys a document definition. E.g.: certain elements can only contain given elements and attributes.

### Document definitions

There are two file formats which specify documents:

- the older Document Type Definition (DTD).
- the newer and XML based, XML Schema (XSD). Yup, specify XMLs with XMLs!

## Minimal document

The minimal well formed-document contains the `prolog` and one, possibly empty root element:

    <?xml version="1.0"?></a>

See: [min.xml](min.xml).

## Declaration

## prolog

Must be the first thing in the document.

Is optional, but the spec says that it RFC2119-SHOULD be present, so just use it always.

TODO: what is the default version if prolog missing?

E.g.:

    <?xml version="1.0"?>

Must contain the version attribute if present.

May contain the encoding:

    <?xml version="1.0" encoding="UTF-8"?>

UTF-8 is the default if not specified.

## Processing instructions

## Question mark tags

Tag like structures delimited by question marks as `<?XXX ?>`.

<http://www.ibm.com/developerworks/library/x-wxxm2/index.html>

Contain tool specific data.

The only predefined one in the XML standard is the `prolog`:

    <?xml version="1.0"?>`

Other common ones include:

- `<?xml-stylesheet type="text/css" href="css.css"?>`: used to specify CSS of an XML.

## Exclamation mark tags

Tag like constructs with exclamation marks like `!DOCTYPE` and comments `<!--` don't have a name: they are just defined one by one on the XML spec.

Full list:

- `<!DOCTYPE`
- `<!ATTLIST`
- `<!ELEMENT`
- `<!ENTITY`
- `<!--`
- `<![CDATA[`

## Namespaces

TODO

## Security

XML leads to some security vulnerabilities, in particular DoS, so you must check if your parser is able to deal with those for untrusted documents.

-   <http://en.wikipedia.org/wiki/Billion_laughs>

    Infinite loop memory CPU DoS. Similar to the Zip bomb, fork bomb or the famous LaTeX `\def~{~}~`.

    Checked by `xmllint`.

    See [billion_laughs.xml](billion_laughs.xml).

-   <https://docs.python.org/2/library/xml.html>

    List of vulnerabilities and which Python parsers are vulnerable to each.

## CSS

HTML attributes can be used to style XML files, and most browsers can then display the XML file as intended.

Specified on a very small REC: <http://www.w3.org/TR/xml-stylesheet/>

The more robust way of styling XML for visualisation is to use XSLT.

Example usage:

    <?xml-stylesheet type="text/css" href="css.css"?>

Only `href` is mandatory, `type` is only advisory.

TODO: are all HTML style attributes allowed?

# XSLT

XML-based Turing complete language used to transform XML documents into other formats, e.g.: other XML documents, PDFs, HTML, etc.

<http://en.wikipedia.org/wiki/XSLT>

# Tools

## libxml

GNOME's implementation.

Homepage: <http://xmlsoft.org/>

## xmllint

libxml CLI frontend.

Usage:

    xmllint min.xml

Checks if:

- well formed
- valid
- entity loops like the billion laughs attack

Pretty print:

    xmllint --format min.xml
