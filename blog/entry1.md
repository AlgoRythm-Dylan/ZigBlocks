# The beginning
The journey of a thousand compiler errors begins
with one hello world, and this is no exception.

I figured I'd start with the simple task of showing
a window on the screen. Dear reader, it has been
three hours and only now have I been able to take the
first shaky step towards this goal.

In my naivety, I had heard that Zig and c were best
pals and worked together very well. I expected this
task to essentially be calling the c Windows API from
Zig.

Unfortunately, c and Zig are not as well aquainted as
you might hope, and you're going to have to do manual
bindings (the bright side: from within Zig) a lot of
the time.

This amalgamation of both zig and c-like structures
is a working code snippet for calling MessageBoxA from
Zig.

```zig
const std = @import("std");
const win = std.os.windows;

extern "user32" fn MessageBoxA(
    hWnd: ?win.HWND,
    lpText: [*:0]const u8,
    lpCaption: [*:0]const u8,
    nCmdShow: u32
) callconv(win.WINAPI) i32;

pub fn main() !void {
    _ = MessageBoxA(null, "Hello", "World", 0);
}
```

## Creating a window
Welcome back. For you it's been mere moments.
For me, it's been another two hours. I just now
got a window to flash open and then close on
my screen. Here's how I did it.

### What a Window needs
Let's get an overview of what needs to happen.

Firstly, we need to register a "window class". Think
of this more as a CSS class than a C++ class - describing
certain attributes of a window such as if it is disabled
or not. We reference this class by a name - a string.

This is done using the function `RegisterClassA` which
wants a `WNDCLASSA` struct. I originally tried just
using `@cImport` and `@cInclude` but it turns out
that doesn't cut it: Zig is good, but not perfect at
interpreting c code, and `windows.h` happens to be a
pretty rough test case. One which, as of the time of
this writing, fails.

Instead, I needed to write the bindings by hand.
Let's take a look at that:

```zig
pub const WNDCLASSA = extern struct {
    style: win.UINT = 0,
    lpfnWndProc: *const fn(win.HWND, win.UINT, win.WPARAM, win.LPARAM) callconv(win.WINAPI) win.LRESULT = DefWindowProcA,
    cbClsExtra: c_int = 0,
    cbWndExtra: c_int = 0,
    hInstance: ?win.HINSTANCE = null,
    hIcon: ?win.HICON = null,
    hCursor: ?win.HCURSOR = null,
    hbrBackground: ?win.HBRUSH = null,
    lpszMenuName: ?win.LPCSTR = null,
    lpszClassName: win.LPCSTR,
};

pub extern fn CreateWindowExA(
    dwExStyle: win.DWORD,
    lpClassName: ?win.LPCSTR,
    lpWindowName: ?win.LPCSTR,
    dwStyle: win.DWORD,
    X: c_int,
    Y: c_int,
    nWidth: c_int,
    nHeight: c_int,
    hWndParent: ?win.HWND,
    hMenu: ?win.HMENU,
    hInstance: ?win.HINSTANCE,
    lpParam: ?win.LPVOID
) win.HWND;
```

`DefWindowProcA` is a function provided by Microsoft
that handles messages for the window and just does
the default action.

Lets see how these things come together. First things
first, we need a `WinMain`. Since we're writing a
graphical Windows program, we cannot use the typical
`main`, but instead, we need to implement `WinMain`,
which passes some specific Windows stuff (which we need)
into it. Specifically, we need `hInstance`.

```zig
pub export fn WinMain(hInstance: win.HINSTANCE,
                      hPrevInstance: ?win.HINSTANCE,
                      pCmdLine: [*:0]u16,
                      nCmdShow: u32) callconv(win.WINAPI) win.INT {
    return wWinMain(hInstance, hPrevInstance, pCmdLine, nCmdShow);
}

pub export fn wWinMain(hInstance: win.HINSTANCE,
                      hPrevInstance: ?win.HINSTANCE,
                      pCmdLine: [*:0]u16,
                      nCmdShow: u32) callconv(win.WINAPI) win.INT {
    _ = hPrevInstance;
    _ = pCmdLine;
    _ = nCmdShow;

    window.showTestWindow(hInstance);

    return 0;
}
```

You can see `window.showTestWindow(hInstance)`. This is
our end goal! Let's see how we do it.

First, we need to create a `WNDCLASSA` type. This
passes in the `hInstance` we got from `WinMain` and
defines our window class; "ZigBlocks Window Class".

```zig
const win_class: wintypes.WNDCLASSA = . {
    .hInstance = hInstance,
    .lpszClassName = "ZigBlocks Window Class"
};
```

Next, we need just register that class:

```zig
_ = wintypes.RegisterClassA(&win_class);
```

The return value should be checked if I'm being a mega
nerd, but I am not, so I just discard it and pray.

Next, we need to actually create the window using
the class we just registered. We can use the function
`CreateWindowExA`, which of course I had to bind by hand.
Here is the usage of it:

```zig
const instance  = wintypes.CreateWindowExA(
    0,
    "ZigBlocks Window Class",
    "ZigBlocks",
    wintypes.WS_OVERLAPPEDWINDOW | wintypes.WS_VISIBLE,
    100,
    100, 
    600,
    400,
    null,
    null,
    hInstance,
    null);
```

Notice our "ZigBlocks Window Class" comes into
play here. It's referenced by name, which surprised
me! I thought I'd be plugging in yet another classic
Windows Handle. I also defined some types, painstakingly,
for window style (WS_xyz in this code).

Now believe it or not, this will work, but we should
show the window too. Luckily, there's a very simple
`ShowWindow` procedure.

```zig
_ = wintypes.ShowWindow(instance, 1);
```

And that's it! When I ran the program, it tripped
my anti-virus, so maybe disable your own before you
run this code. Either way, you should get
an unresponsive window that flashes and goes away
basically as soon as it gets shown. You can add
a "while true" loop after showing the window
if you want it to stick around.

That was pretty exhausting, so before I move onto
handling messages, I'm going to call it here.