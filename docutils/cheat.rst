=============================================================================
Document title must be completelly underlined and upperlined with =
=============================================================================

asdf

.. contents:: toc title
    :depth: 5

.. sectnum::
    :depth:

h1
=======

must have at least as many underline symbols as length

underline symbol can be anything.

the first time it appears defines the level of a symbol.

if you change that aftewards, you get an error.

very confusing.

h2
##

h3
++

h4
^^

h5
--

par
===

par1

par2

pre
===

::

    this is a *preformatted* section
        indent
 indent minus
    must end in blank line!

not anymore. must have blank line above.

another::

    this is the **pre**

another ::

    this is the **pre**

``*inline pre*``

link
====

inline: `inline to google <http://www.google.com>`_

note that the name is kept from now on! `inline to google`_

`can also to this <inline to google_>`_

explicit: http://www.google.com a@b.c with no link text: `<www.google.com>`_

except you do ``__``: `one hit <onehit>`__, then the following would be undefined: ```one hit`_``

google_

.. _google: http://www.google.com

`multi word`_

.. _multi word: http://www.google.com

links to subdir unless if fits into some known protocol such as ``http`` or email: tosubdir_ maillink_

.. _tosubdir: www.the.subdir.com

.. _maillink: a@b.c

anonymous
#########

__ ano1

__ ano2

`text of ano1`__

__ ano3

`text of ano2`__

`text of ano3`__

internal
########

partarget_

.. _partarget:

this par has id "partarget"

partarget1_
partarget2_

.. _partarget1:
.. _partarget2:

this par has ``partarget2`` and starts with a span ``partarget1``

_`inline internal target`. a link to it: `inline internal target`_. This makes a span with id.

toid_

.. _toid: #partarget

uitarget_

.. _uitarget:


- this ui has id "uitarget"

to headers makes a span before the header:

htarget_

.. _htarget:

doctest
=======

same as pre.

no check is actually done.

>>> print 'a'
a
>>> print 'a'
b

blockquote
===========

par

same as pre.

no check is actually done.

    blockquote
    line 2

another:

    blockquote
    line 2

    -- author

dl
==

term 1
    Definition 1.

term 2
    Definition 2, paragraph 1.

    Definition 2, paragraph 2.

term 3 : classifier
    Definition 3.

term 4 : classifier one : classifier two
    Definition 4.

comment
=======

.. This is a comment
..
   _so: is this!

field list
==========

:key: value

:key2: value 2

directive
=========

.. note:: note content

.. topic:: Topic Title

    stuff inside the topic

before

sidebar

.. sidebar:: Sidebar Title
    :subtitle: Optional Sidebar Subtitle

    body of sidebar

after

sidebar

.. code:: python

 def my_function():
     "just a test"
     print 8/2

.. math::

  α_t(i) = P(O_1, O_2, … O_t, q_t = S_i λ)

.. |reST| replace:: reStructuredText

replaced: |reST|

unicode: |copy| |BogusMegaCorp (TM)| |---|

.. |copy| unicode:: 0xA9 .. copyright sign
.. |BogusMegaCorp (TM)| unicode:: BogusMegaCorp U+2122
   .. with trademark sign
.. |---| unicode:: U+02014 .. em dash
   :trim:

.. |date| date::
.. |time| date:: %H:%M

datetime: |date| |time|

raw
###

is only used for respective output:

.. raw:: html

   <p>raw html</p>

.. raw:: latex

    {\it raw latex}
