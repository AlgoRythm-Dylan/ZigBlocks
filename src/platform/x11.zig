pub const Display = *opaque{};
pub const Screen = *opaque{};
pub const Window = u64;

pub extern fn XOpenDisplay(display_name: ?*u8) ?Display;
pub extern fn XCloseDisplay(display: Display) c_int;

pub extern fn X11Helper_DefaultScreenOfDisplay(display: Display) ?Screen;
pub const DefaultScreenOfDisplay = X11Helper_DefaultScreenOfDisplay;

pub extern fn X11Helper_RootWindowOfScreen(screen: Screen) Window;
pub const RootWindowOfScreen = X11Helper_RootWindowOfScreen;

pub extern fn XCreateSimpleWindow(
    display: Display,
    parent: Window,
    x: i32,
    y: i32,
    width: u32,
    height: u32,
    border_width: u32,
    border: u64,
    background: u64
) Window;

pub extern fn XMapWindow(display: Display, w: Window) c_int;

pub const XEvent = extern struct {

};

pub extern fn XNextEvent(display: Display, e: *XEvent) c_int;