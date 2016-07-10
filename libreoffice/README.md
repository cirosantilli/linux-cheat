# LibreOffice

Open source MS Office. Written in Java.

Forked from OpenOffice after Oracle wanted to impose stricter copyright on it.

WYSIWYG text editor, tables, image editor, database management.

How to add new spell checking language: <http://askubuntu.com/questions/72099/how-to-install-a-libreoffice-dictionary-spelling-check-thesaurus>

## Write

How to end a list??

## Calc

Table /spreadsheet editor like Excel.

To try it out, use the `.csv` files in this directory.

## Configuration

Always show a row or column on stick rows. Useful for the header if the table is long and if there is only a single table in the spreadsheet.

- click on column that *follows* the one that should always show
- Window > Freeze

## Pivot table

<https://www.youtube.com/watch?v=7r7z8YSXG18>

Was called "Data Pilot", but finally gave in to the Microsoft terminology.

Is basically a UI for SQL `GROUP BY` queries.

Create: Select the table > Data > Pivot table. Drag and drop header fields into row, column and data.

Dragging multiple headers on rows or columns creates a hierarchy. It is not possible to open or close hierarchies quickly on the table directly: you must right click and edit the pivot layout.

To drilldown the facts, double click on the data cell. This opens a new tab with the drilldown table.

## How to do GUI stuff

Copy and paste row: <https://ask.libreoffice.org/en/question/13577/how-to-insert-copied-columns/> Possible solution:

- insert multiple rows
- select what you want to copy and copy it
- select all the places you want to paste them and do it

Insert multiple rows: <https://ask.libreoffice.org/en/question/559/inserting-rows-in-a-spreadsheet/>

Sort by column: Select cells then Menu > Data > Sort

## Export only selected Calc cells to a single PDF

- http://stackoverflow.com/questions/19940236/how-to-generate-pdf-from-a-libreoffice-calc-sheet-fitting-the-page-width

## Internals

Uses it's own Widget toolkit! <https://docs.libreoffice.org/vcl.html>
