#include <X11/Xlib.h>
#include <assert.h>
#include <stdio.h>

typedef struct {
    Display* display;
    Screen* screen;
    Window window, root_window;
} X11DisplayReference;

extern X11DisplayReference initX11(){
    X11DisplayReference ref;

    ref.display = XOpenDisplay(NULL);
    assert(ref.display != NULL);

    ref.screen = DefaultScreenOfDisplay(ref.display);
    assert(ref.display != NULL);

    ref.root_window = RootWindowOfScreen(ref.screen);

    const int screenId = DefaultScreen(ref.display);

    ref.window = XCreateSimpleWindow(
        ref.display,
        ref.root_window,
        10, 10,
        500, 300,
        0,
        BlackPixel(ref.display, screenId),
        WhitePixel(ref.display, screenId)
    );
    XStoreName(ref.display, ref.window, "ZigBlocks");

    return ref;
}

extern void showX11Window(X11DisplayReference* ref){
    XMapWindow(ref->display, ref->window);
}

extern void loopX11Window(X11DisplayReference* ref){
    XEvent ev;
    while(1){
        XNextEvent(ref->display, &ev);
    }
}