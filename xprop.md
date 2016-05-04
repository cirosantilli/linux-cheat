# xprop

Get window info on a window:

	xprop -name Krusader
	xprop -id 0x2000001

Select window by clicking on it:

	xprop

Keep examining the properties, and print if changes happen:

	xprop -spy -name Krusader

Important properties:

- `_NET_WM_PID`: PID of the window
