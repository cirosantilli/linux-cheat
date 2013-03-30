% title
% author
% date

# sources

great documentation page:

``` {.bash}
    man pandoc_markdown
```

# header 1

## header 2

### header 3

# paragraph

paragraph 1

paragraph 2

# list

A list:

- ul 1
- ul 2

Must have blank line after last paragraph:
- this is not an item
- neither is this

##### no need for a blank line after last header
- ul 1
- ul 2

but don't do this, it confusing and hard to read.

## ordered

#. a
#. a
#. a

1) a
2) a
3) a

(1) a
(2) a
(3) a

1. a
2. a
3. a

<!-- -->

2. a
1. a
3. a

## example list

### no tag

(@) no tag. a bit useless.

a paragraph

(@) no tag. a bit useless.

must be at start of line to work: (@)

###  tagged

(@tag1) text of tag1

ref to tag1: (@tag1)

(@tag2) text of tag2

ref to tag1: (@tag1)

(@tag1) <-- cannot start line directly with reference. It will be treated as a list item.

# code block

Inline: ``this is inline code``

Indented:

    this is a block
    it can contain many lines

Must have blank line after last paragraph:
    this is not a block
    because it does not have a blank line before last paragraph

Can have a paragraph afterwards without blank line:

    code block
paragraph after code block without blank line. Don't do this tough: it confusing and hard to read.

Delimited code block with tildes:

~~~
import os

def f(a):
    print a

f("abc")
~~~

with backticks:

```
import os

def f(a):
    print a

f("abc")
```

I prefer backticks for analogy with inline blocks.

Give attributes:

``` {#id .python .numberLines startFrom="100"}
import os

def f(a):
    print a

f("abc")
```

# math

Inline: $x^2$

Firs chars after first dollar and before lats one must not be space: $ x^2$ $x^2 $ $ x^2 $
