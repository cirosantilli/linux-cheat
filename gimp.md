# Gimp

Image manipulation.

Huge amount of functions, but has a learning curve.

Learn the shortcuts and be happy.

## Docking

Understand a bit about Gimp's docking: <https://www.youtube.com/watch?v=rEYdWCP9d80>

Avoid multi window madness:

    Menu > Windows > Single-Window Mode

Needs Gimp 2.8 (Ubuntu 12.04 stops at Gimp 2.6).

## Layers

If you don't know what layers are and how to use them, learn *now*

- <https://www.youtube.com/watch?v=jrVnI3l9fgE>

It's basic concept, and if you don't understand it nothing will make sense.

Always keep the layer dialog open: it shows a fundamental image state, and allows you to create, delete and reorder layers.

Some actions like:

- `N` only have effect on the currently layer on the layer dialog
- `M` affect the first Z order non transparent layer

Layer Z order is given by the order on the layer dialog.

The layer lock, when active, makes all locked layers move together via the `M` tool.

## Grid

- View -> Grid: toggle grid visibility
- View -> Snap to Grid
- Image -> Configure Grid: set grid size

## Copy page

`Shift + C` copy saves the current selection

`Shift + V` paste create a new temporary layer

To transform it into an actual layer, select it on the layer dialog and push "Create a new layer and add it to the image."

## Tools

Resize entire image:

    Menu > Image > Scale Image

Shortcuts:

-   `Shift + B`: bucket fill.

-   `Ctrl + D`: duplicate current image.

-   `Shift + E`: eraser

    To get hard edges, there is a checkbox on the tool option.

    On images without alpha layer, eraser does not erase to transparency: it paints the background color!

-   `M`: move.

    Selects the topmost non transparent layer at pixel under cursor.

    `Shift + M`: move current layer regardless of transparency.

-   `N`: `peNcil`

    - `Shift + `

-   `O`: select color of a given pixel

-   `Q`: alignment tool.

    Aligns centers, left, right, top bottom of multiple layers.

-   `Ctrl + PageDown`: go to previous tab

-   `T`: text tool. To move text around, use the Move tool. You must click precisely on a character, not on the background.

-   `Shift + T`: resize, scale selection

-   `Shift + R`: rotate selection tool

-   `X`: swap primary and secondary colors

-   `Y`: redo

-   `Z`: undo

### Selection tools

-   `R`: rectangle select tool.

    While a rectangle selection is on, you can only draw inside the rectangle.

    For example, to draw a rectangle, use this tool, then bucket fill inside the selection.

    While the `R` tool is active, you can use it to move the current rectangle selection.

    To deactivate a rectangle selection, select the tool, and click once without dragging anywhere outside the selection.

    Select a square: start selection, then hold `Shift`.

    Maintain aspect ration of last selection when resizing: start drag, then hold `Shift`.

    - `Ctrl + A + drag`: move the selection elsewhere

    - `Ctrl + Shift + V`: open selection / clipboard as a new image

-   `Ctrl + R`: add new rectangle to existing selection
