# Unicode

Maps numbers, known as code points, to characters (the idea, no specified font).

Does not specify how sequences of numbers should be encoded: this is typically done by UTF-8 and UTF-16.

Currently only 10% of the code points have been taken up, and since big languages like Chinese are already included, we don't have to worry about running out of space for a long time.

## Standards

Unicode Consortium that maintains the standard: <http://unicode.org/>

Latest version of the standard: <http://www.unicode.org/versions/latest/>

Code chart: browser by category or input as specific hex: <http://www.unicode.org/charts/>

## Plane

<http://en.wikipedia.org/wiki/Plane_(Unicode)>

A plane is a set of 2^16 characters.

There are 17 planes, 0 to 16, so **not** a multiple of 2! This is because historically UTF-16 was the dominant encoding before UTF-8 beat it, and UTF-16 does not encode a power of 2 points because it is variable length (2 or 4 bytes).

0 is filled and has the most important characters.

1 and 2 are used for less common scripts.

3 through 13 are not used yet.

14 and 15 are the private use area.

## Notation

Points are noted as `U+` followed by an hexadecimal number.

Leading plane zeros are stripped.

Therefore:

- plane 0 is noted as `U+XXXX`. Note that leading zeros of the point are not stripped, e.g. `U+0100` since they are not in the plane.
- planes 1 - 9 are noted as: `U+XXXXX`
- planes nd 10 to 16 as `U+XXXXXX`

## Interesting characters

-   Emoticon set: <http://www.unicode.org/charts/PDF/U1F600.pdf>

-   Trigram for heaven `U+2630` ☰

    Similar to the popular "Menu" symbol found in many current applications. Interesting reuse for an ancient Chinese symbol!

-   Middle finger! Introduced in 2014.

    Amazing description: "Reversed hand with middle finger extended."

-   <http://en.wikipedia.org/wiki/Pilcrow> `U+00B6` ¶

    Indicates a paragraph.

-   Unicode has inverted versions of many characters: <http://www.cheesygames.com/upside-down-text/>

    <http://stackoverflow.com/questions/2995340/how-does-u%CA%8Dop-%C7%9Dp%E1%B4%89sdn-text-work>

    There is even a wiki with famous strategies: <http://en.wikipedia.org/wiki/Transformation_of_text>

-   Full width characters <https://en.wikipedia.org/wiki/Halfwidth_and_fullwidth_forms>

    Twice as wide as normal ASCII. Used in Asian languages like Chinese where most characters are also 2x wider than normal ASCII.

        ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯ

### Whitespace

Unicode NBSP variants: <http://en.wikipedia.org/wiki/Non-breaking_space#Width_variations>

Other exotic spaces: <http://en.wikipedia.org/wiki/Whitespace_character>

Ideographic space: <http://www.fileformat.info/info/unicode/char/3000/index.htm>

## Replacement character

`U+FFFD` �

Commonly used when the software does have the glyph in the right font, or for invalid code points.

### Non-characters

<http://en.wikipedia.org/wiki/Universal_Character_Set_characters#Non-characters>

60 characters that are guaranteed never to be mapped to anything.

### Private use area

<http://en.wikipedia.org/wiki/Private_Use_Areas>

Planes 15 and 16.

## Tools

-   <http://shapecatcher.com/index.html>

    Unicode hand drawing to character recognizer. Seems to be down now, and closed source.

    Claims backend runs on CUDA!

## UTF-8

<http://en.wikipedia.org/wiki/UTF-8>

| Number of bits | 1        | 2        | 3        | 4        | 5        | 6        |
|----------------|----------|----------|----------|----------|----------|----------|
| 7              | 0xxxxxxx |          |          |          |          |          |
| 11             | 110xxxxx | 10xxxxxx |          |          |          |          |
| 16             | 1110xxxx | 10xxxxxx | 10xxxxxx |          |          |          |
| 21             | 11110xxx | 10xxxxxx | 10xxxxxx | 10xxxxxx |          |          |
| 26             | 111110xx | 10xxxxxx | 10xxxxxx | 10xxxxxx | 10xxxxxx |          |
| 31             | 1111110x | 10xxxxxx | 10xxxxxx | 10xxxxxx | 10xxxxxx | 10xxxxxx |

Features:

- backwards compatible with ASCII
- easy to spot multi byte chars: if if starts with 1 it is part of a multi byte
- synchronization: easy to spot the start of a character: iff it starts with either `0` or `11` it is the start of a character.
- code length: given by the number of 1 bits on the leading byte

All of 5, 6 and many 4 byte characters don't map to any Unicode point to match the maximum number of characters encoded by Unicode.

### Overlong encoding

It is possible to encode many values in multiple ways, e.g., NUL can be coded as all of:

- `00000000`
- `11000000 10000000`
- `11100000 10000000 10000000`

UTF-8 only allows the shortest possible representation.

One possible use case for overlong representations is to overlong encode NUL as `C0F0`, so that the NUL character can be used as a string or file terminator. This works because there is no other valid 0 byte. This is used by the Java `.class` file format, in a format that Java calls modified UTF-8 string: <http://docs.oracle.com/javase/6/docs/api/java/io/DataInput.html#modified-utf-8>

## UTF-16

Encodes everything with either two or four bytes, never one, making it super inefficient for ASCII.

Therefore it is not ASCII compatible, so it requires special support even for ASCII viewing.

Also, it contains NUL characters all over for ASCII, which requires greater care with C NUL-terminated strings.

## Largest common Unicode gliph

<https://www.quora.com/What-are-the-coolest-Unicode-characters/answer/Ciro-Santilli-%E5%85%AD%E5%9B%9B%E4%BA%8B%E4%BB%B6-%E6%B3%95%E8%BD%AE%E5%8A%9F-%E7%BA%B3%E7%B1%B3%E6%AF%94%E4%BA%9A-%E5%A8%81%E8%A7%86>
