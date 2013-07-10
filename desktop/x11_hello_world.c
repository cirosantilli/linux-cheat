/*
x11 c interface hello world

sources:

- <http://www.linuxjournal.com/article/4879>

	nice hello world and intro
*/

#include "X11/Xlib.h"

int main(){

    Display *dsp = XOpenDisplay( NULL );
    if( !dsp ){ return 1; }

    int screenNumber = DefaultScreen(dsp);
    unsigned long white = WhitePixel(dsp,screenNumber);
    unsigned long black = BlackPixel(dsp,screenNumber);

    Window win = XCreateSimpleWindow(
		dsp,
		DefaultRootWindow(dsp),
		50, 50,     // origin
		200, 200, // size
		0, black, // border
		white // backgd
	);

    XMapWindow( dsp, win );


    long eventMask = StructureNotifyMask;
    XSelectInput( dsp, win, eventMask );

    XEvent evt;
    do {
        XNextEvent( dsp, &evt );     // calls XFlush
    } while ( evt.type != MapNotify );


    GC gc = XCreateGC(
    	dsp,
    	win,
        0,              // mask of values
        NULL			// array of values
    );
    XSetForeground( dsp, gc, black );

    XDrawLine(dsp, win, gc, 10, 10,190,190); //from-to
    XDrawLine(dsp, win, gc, 10,190,190, 10); //from-to

    eventMask = ButtonPressMask|ButtonReleaseMask;
    XSelectInput(dsp,win,eventMask); // override prev

    do {
        XNextEvent( dsp, &evt );     // calls XFlush()
    } while ( evt.type != ButtonRelease );

    XDestroyWindow( dsp, win );
    XCloseDisplay( dsp );

    return 0;
}
