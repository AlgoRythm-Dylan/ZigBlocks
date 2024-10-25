pub const Display = *opaque{};
pub const Screen = *opaque{};
pub const Window = u64;

pub const X11DisplayReference = extern struct {
    display: ?Display,
    screen: ?Screen,
    root_window: Window,
    window: Window
};

pub extern fn initX11() X11DisplayReference;
pub extern fn showX11Window(ref: *const X11DisplayReference) void;
pub extern fn loopX11Window(ref: *const X11DisplayReference) void;