# xwd

Take screenshots.

Mnemonic: X11 Write Dump.

Take screenshot of all desktop:

	xwd -root -out a.xwd

Wait for mouse click and take screenshot of clicked window only:

	xwd -out a.xwd

Make a `png` screenshot:

	xwd | xwdtopnm | pnmtopng > Screenshot.png
