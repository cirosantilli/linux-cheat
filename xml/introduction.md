# Introduction

Represents data on a tree structure.

Can be easily extended to define new formats, and several key formats are based on it:

- `.docx`, `.odt`, and the other office applications
- SVG
- MathML

HTML looks a lot like XML, but is *not* valid XML for several new syntaxes which are more convenient to web developers. XHTML, an HTML variant version which really is XML.

XML has been losing popularity to JSON, which is more lightweight as you don't have to repeat open and closing tags so much, and since JSON is almost of subset of JavaScript notation, which many people know.

## Standards

Specified by W3C at: <http://www.w3.org/TR/xml/>. Currently equals to the latest stable: XML 1.0 (2008).

Funnily, the last version of XML 1.1, the other major version of XML, dates from 2006, i.e. before XML 1.0. This is so because XML 1.0 was created in 1998, but XML 1.1 was created in 2004.

XML 1.0 is much more popular than XML 1.1: <http://stackoverflow.com/questions/6260975/should-i-learn-xml-1-0-or-xml-1-1>

XML Namespaces <http://www.w3.org/TR/REC-xml-names/> from 2009 extends XML with things like `xmlns`.

<http://www.w3.org/TR/xmlschema11-1/> specifies XML

## Well formed vs valid

A well formed document has the correct XML syntax.

A valid document is well formed, and also obeys a document definition. E.g.: certain elements can only contain given elements and attributes.

### Document definitions

There are two file formats which specify documents:

- the older Document Type Definition (DTD).
- the newer and XML based, XML Schema (XSD). Yup, specify XMLs with XMLs!

<http://stackoverflow.com/questions/1544200/what-is-difference-between-xml-schema-and-dtd>

## Minimal document

The minimal well formed-document contains the `prolog` and one, possibly empty root element:

    <?xml version="1.0"?></a>

See: [min.xml](min.xml).

## Element

### Name of elements and attributes

Rules <http://www.w3.org/TR/xml/#NT-NameStartChar>.

In particular:

- `@` is not allowed
- `-` and `.` and digits are allowed but not as the first character
- `:` and `_` are allowed anywhere

### Attributes

Characters that must be encoded on the value: `<&"`

### Elements vs attributes for key value dictionaries

In many cases, both can be used.

Elements can:

-   contain other elements

-   skip DTD check if you let users add arbitrary new keys.

        <elem customKey="customVal />

    vs:

        <elem>
          <entry key="customKey" val="customVal" />
        </elem>

Attributes can:

-   enforce DTD check

## Binary data

Apparently you must text-encode it, e.g. with base64: <http://stackoverflow.com/questions/19893/how-do-you-embed-binary-data-in-xml>

This is because:

- control characters are invalid in XML
- character entities of control characters are also invalid

## Declaration

## prolog

<http://www.w3.org/TR/xml/#sec-prolog-dtd>

### XML declaration

<http://www.w3.org/TR/xml/#NT-XMLDecl>

Must be the first thing in the document: not even whitespace can come before it.

Is optional, but the spec says that it RFC2119-SHOULD be present, so just use it always. <http://stackoverflow.com/questions/7007427/does-a-valid-xml-file-require-an-xml-declaration>

For XML 1.1 it is mandatory, and XML 1.1 says that if it is not present, then the document is XML 1.0.

TODO: what is the default version if prolog missing?

Must contain the version attribute if present.

    <?xml version="1.0"?>

May contain the encoding:

    <?xml version="1.0" encoding="UTF-8"?>

UTF-8 is the default if not specified.

#### standalone

The prolog may contain a `standalone`:

    <?xml version="1.0" encoding="UTF-8" standalone="true"?>

Means that validation should ignore DTD if one is present.

---

`version`, `encoding` and `standalone` are not real attributes, only magic things that look like attributes. Their order is fixed.

### DTD

Define what a valid document is.

<http://www.w3.org/TR/xml/#NT-doctypedecl>

### XSD

TODO

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

## XSLT

XML-based Turing complete language used to transform XML documents into other formats, e.g.: other XML documents, PDFs, HTML, etc.

<http://en.wikipedia.org/wiki/XSLT>
