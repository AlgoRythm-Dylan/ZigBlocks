# Making that window stick around
Since our window isn't actually processing messages,
Windows identifies it as unresponsive and if you
try to interact with it in any way, it will get that
ghostly-white appearance to it and try to close itself.

Not super ideal.

So, let's handle messages. This actually wasn't
super hard to do, but I had to come up with a new
trick to see if a function was a c macro or not.

Let's dive in.

## The Big Three
In order to accomplish our goal, we need three
Windows functions: `GetMessageA`, `TranslateMessage`,
and `DispatchMessageA`.

`GetMessage` reads a message off the queue, and the other
two things do stuff where the docs basically said
"don't worry about it", and so, I do not worry about it.

One little caveat was that the docs all reference
`GetMessage` and `DispatchMessage` (note: the lack of
the "A"). I spent about 20 minutes trying to track
down the linking error I was getting. Eventually
I just opened Visual Studio, typed the same code in c,
and watched to see if it turned purple (the macro color).
Then, I just added -A to the function name and viola.

I also had to implement the `MSG` structure. Just
more manual work, nothing special.

`GetMessageA` also returns 0 when it's time to exit
the program (something we're doing next time). So
putting it all together, here's what we get:

```zig
window.showTestWindow(hInstance);
var message: wintypes.MSG = undefined;
while(wintypes.GetMessageA(&message, null, 0, 0) > 0){
    _ = wintypes.TranslateMessage(&message);
    _ = wintypes.DispatchMessageA(&message);
}
```

Now if I run the code, the window still does practically
nothing, but at least it doesn't "crash" anymore.

## Closing
Something a bit annoying: in order to actually close
ZigBlocks, you need to go into task manager and end the process.

Let's fix that by handling the `WM_DESTROY` message!

If you remember, up until this point, I have been using the
default handler for window messages. To remind you, that was
this:

```zig
pub extern fn DefWindowProcA(
    hwnd: win.HWND,
    uMsg: win.UINT,
    wParam: win.WPARAM,
    lParam: win.LPARAM
) callconv(win.WINAPI) isize;
```

To accomplish our goals, we need just a single additional
Windows API function: `PostQuitMessage`

```zig
pub extern fn PostQuitMessage(c_int) void;
```

Essentially, when I call this function, it will put a message
on the message queue that will make `GetMessage` return `0`,
which if you'll remember my graphics/message/event loop,
means the program will exit.

I started by implementing my own version of a window
procedure:

```zig
pub fn ZigWindowProcA(
    hwnd: win.HWND,
    uMsg: win.UINT,
    wParam: win.WPARAM,
    lParam: win.LPARAM
) callconv(win.WINAPI) isize {
    if(uMsg == WM_CLOSE){
        PostQuitMessage(0);
        return 0;
    }
    else {
        return DefWindowProcA(hwnd, uMsg, wParam, lParam);
    }
}
```

Simply enough, it just catches `WM_CLOSE` messages and
when it finds one, it raises a quit message, exiting our
loop.

This actually was astoundingly simple, and I think a
lot of my recent "steam" has been due to the fact that
I know a bit of what I'm doing now. I hope.

At this point I feel like a lot of the windowing code
I need to make is already done and it's time to move on.
I want to spend some time turning this collection of code
into a real program - with structure and flow and maybe
just the basic idea of the beginnings of cross-platform
ideas. Maybe.