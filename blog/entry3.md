# Cleaning up
I'm not sure how to de-couple from `WinMain`
just yet, but lets get all that ugly message
handling code out of our main file. I want
it to look like this instead:

```zig
const os_win = window.OSWindow.init(.{ .hInstance = hInstance });
os_win.show();
os_win.loop();
```

So, lets work on `init` first.

## OSWindowArgs
In Zig (and many other languages as well), a common
way to initialize a complex object is to actually pass
a sort of config object to it. While it seems overkill
now, I know there's lots of other things I will
eventually want to pass to this function such as width
and height, so starting with a struct object now sounds
right.

```zig
pub const OSWindowArgs = struct {
    hInstance: win.HINSTANCE
};
```

## init
A common Zig design (though not a required one) is
to "construct" structs using an `init` function.

Right now our struct is exclusively going to hold onto
the instance of the main window.

```zig
pub const OSWindow = struct {

    instance: win.HWND = undefined,
```

The `init` object will be responsible for taking
in the arguments struct and turning it into a `HWND`
representing our game window. This is all code that
was already written, but I'm just refactoring it
to fit into more of design instead of sparsely
populated code snippets.

```zig
// Create the "window class" - look and feel,
// capabilities, etc.
const win_class: wintypes.WNDCLASSA = . {
    .hInstance = args.hInstance,
    .lpfnWndProc = ZigWindowProcA,
    .lpszClassName = "ZigBlocks Window Class"
};
// Register the class so we can request instances of it
_ = wintypes.RegisterClassA(&win_class);
// Request an instance of it
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
    args.hInstance,
    null);

// Return a new OSWindow containing that instance
return .{ .instance = instance };
```