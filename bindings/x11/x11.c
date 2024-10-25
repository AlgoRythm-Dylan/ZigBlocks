#include <X11/Xlib.h>

Screen* X11Helper_DefaultScreenOfDisplay(Display *d){
    return DefaultScreenOfDisplay(d);
}

Window X11Helper_RootWindowOfScreen(Screen *s){
    return RootWindowOfScreen(s);
}