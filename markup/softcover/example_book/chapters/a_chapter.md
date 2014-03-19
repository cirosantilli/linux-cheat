# A chapter
\label{cha:a_chapter}

This is the first paragraph of the Softcover Markdown template. It shows how to write a document in Markdown, a lightweight markup language, augmented with the [kramdown](http://kramdown.rubyforge.org/) converter and some custom extensions, including support for embedded \PolyTeX, a subset of the powerful \LaTeX\ typesetting system.  For more information, see [*The Softcover Book*](http://manual.softcover.io/book). To learn how to easily publish (and optionally sell) documents produced with Softcover, visit [Softcover.io](http://softcover.io/). Softcover is currently in private beta; go to [Softcover.io](http://softcover.io/) to get an invitation.

This is the *second* paragraph, showing how to emphasize text.[^sample-footnote] You can also make text **bold** or _emphasize a second way_.

## A section
\label{sec:a_section}

This is a section. You can refer to it using the \LaTeX\ cross-reference syntax, like so: Section~\ref{sec:a_section}.

### Source code

This is a subsection.

You can typeset code samples and other verbatim text using four spaces of indentation:

    def hello
      puts "hello, world"
    end

Softcover also comes with full support for syntax-highlighted source code using kramdown's default syntax, which combines the language name with indentation:

{lang="ruby"}
    def hello
      puts "hello, world"
    end

Softcover's Markdown mode also extends kramdown to support "code fencing" from GitHub-flavored Markdown:

```ruby
def hello
  puts "hello, world!"
end
```

The last of these can be combined with \PolyTeX's `codelisting` environment to make code listings with linked cross-references (Listing~\ref{code:hello}).

\begin{codelisting}
\codecaption{Hello, world.}
\label{code:hello}
```ruby
def hello
  puts "hello, world!"
end
```
\end{codelisting}


### Mathematics

Softcover's Markdown mode supports mathematical typesetting using \LaTeX\ syntax, including inline math, such as \( \phi^2 - \phi - 1 = 0, \) and centered math, such as
\[ \phi = \frac{1+\sqrt{5}}{2}. \]
It also supports centered equations with linked cross-reference via embedded \PolyTeX\ (Eq.~\eqref{eq:phi}).

\begin{equation}
\label{eq:phi}
\phi = \frac{1+\sqrt{5}}{2}
\end{equation}

Softcover also supports an alternate math syntax, such as {$$}\phi^2 - \phi - 1 = 0{/$$}, and centered math, such as

{$$}
\phi = \frac{1+\sqrt{5}}{2}.
{/$$}

The \LaTeX\ syntax is strongly preferred, but the alternate syntax is included for maximum compatibility with other systems.

## Images and tables

This is the second section.

Softcover supports the inclusion of images, like this:

![Some dude.](images/2011_michael_hartl.png)

Using \LaTeX\ labels, you can also include a caption (as in Figure~\ref{fig:captioned_image}) or just a figure number (as in Figure~\ref{fig:figure_number}).

![Some dude.\label{fig:captioned_image}](images/2011_michael_hartl.png)

![\label{fig:figure_number}](images/2011_michael_hartl.png)

### Tables

Softcover supports raw tables via a simple table syntax:

|**HTTP request** | **URL** | **Action** | **Purpose** |
| `GET` | /users | `index` | page to list all users |
| `GET` | /users/1 | `show` | page to show user with id `1` |
| `GET` | /users/new | `new` | page to make a new user |
| `POST` | /users | `create` | create a new user |
| `GET` | /users/1/edit | `edit` | page to edit user with id `1` |
| `PATCH` | /users/1 | `update` | update user with id `1` |
| `DELETE` | /users/1 | `destroy` | delete user with id `1` |

See [*The Softcover Book*](http://manual.softcover.io/book/softcover_markdown#sec-embedded_tabular_and_tables) to learn how to make more complicated tables.

## Command-line interface

Softcover comes with a command-line interface called `softcover`. To get more information, just run `softcover help`:

```console
$ softcover help
Commands:
  softcover build, build:all           # Build all formats
  softcover build:epub                 # Build EPUB
  softcover build:html                 # Build HTML
  softcover build:mobi                 # Build MOBI
  softcover build:pdf                  # Build PDF
  softcover build:preview              # Build book preview in all formats
  .
  .
  .
```

\noindent You can run `softcover help <command>` to get additional help on a given command:

```console
$ softcover help build
Usage:
  softcover build, build:all

Options:
  -q, [--quiet]   # Quiet output
  -s, [--silent]  # Silent output

Build all formats
```

## Miscellanea

This is the end of the template---apart from two mostly empty chapters. In fact, let’s include the last chapter in its entirety, just to see how mostly empty it is:

<<(chapters/yet_another_chapter.md, lang: text)

Visit [*The Softcover Book*](http://manual.softcover.io) to learn more about what Softcover can do.


[^sample-footnote]: This is a footnote. It is numbered automatically.

[^pronunciation]: Pronunciations of "LaTeX" differ, but *lay*-tech is the one I prefer.
