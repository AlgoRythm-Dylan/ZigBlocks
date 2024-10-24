# It's time to Vulk
One thing that always confuses the hell out
of me is dependency management - especially
in c/c++ projects. It's time to add a layer of
complexity and throw Zig in the mix!

## The SDK
I spent a good amount of time reading about Vulkan
before I decided to dive into this and various tutorials all
recommend installing the SDK. It's 4GB, but that's
not uncommon for an SDK - plus it comes with lots
of tools that might help me in the future.

The real advanrage is that it comes with all the
header files and libraries I need to get my program
running.

## The lib
So, I'm pretty sure I don't need the include
directories because I'm writing Zig and not c,
but if `cImport` and `cInclude` end up working
with the Vulkan header files, maybe it could
speed up some work. I have a feeling I'll be
manually binding anyways, though.

In any case, I've created a `dependency` folder
in the root of my project and added a lib folder
to that. I don't know which libraries I need
specifically, so I just threw the most obvious one
in there for now ("vilkan-1.lib") and if I get
linker errors, I will just keep adding libs until
the issue is fixed!

## The Zig
One of the respectable things about Zig that I
completely hate when it affects me is Zig is
NOT afraid of breaking changes. In fact, it's
extremely commonplace, and it's affecting me
in this project right now.

Adding a library folder used to work something
like this:

```zig
exe.addLibraryPath("./dependency/lib");
```

Well, now it takes something called a `LazyPath`.
I couldn't really find any examples on how to
construct one so I resorted to asking ChatGPT.
I learned that if you ask it to search the
internet BEFORE trying to guess the right answer,
it will listen. It found the correct way to do
this in my version of Zig. Where `b` is my build
object:

```zig
exe.addLibraryPath(b.path("./dependency/lib"));
```

The next step is to inform the linker what to
link:

```zig
exe.linkSystemLibrary("vulkan-1");
```

And to my surprise, `zig build` didn't return any
errors! This is maybe because I'm not actually
using Vulkan yet, so let's fix that.

## Some binding work
Since I don't trust `cImport` and `cInclude`, I
have just straight up skipped trying them and am
instead doing the bindings myself. The down-side:
it takes *forever*. The up-side: I get to *really*
learn the Vulkan API, and as a bonus, I can add
Zig doc comments to everything.

I've created a folder in called `src/graphics/vulkan`
and I am going to try and separate each item by
type: functions, types, etc.

[https://vulkan-tutorial.com/](https://vulkan-tutorial.com/)
started off by saying to fill out a `VkApplicationInfo`
but then later (after I already wrote the bindings)
clarified it was optional. Damn. There goes five
minutes.

I implemented the macro VK_MAKE_API_VERSION in Zig
in the `helpers.zig` file and also wrote my first
unit test. This is where I learned that your
testing project also needs the same linking setup
that your exe project does. I added the links
and ran test, but nothing happened. I am assuming
this is because `helpers.zig` is not reached by the
entrypoint yet.

Next up was one I really do need. `VkInstanceCreateInfo`
is a structure that we pass to create a Vulkan instance,
and it tells Vulkan critical information about our
usage, such as the extensions we need.

Vulkan itself doesn't have support for rendering to
a win32 window. Instead, we need to use an extension.
This project *hopes* to support X11, but again,
that's a project for another day (very soon, probably
after I render my first triangle)

## A little detour
On Windows, since we are entering a graphical context,
the console no longer works. This means I can't
"poor man's debug" using `std.debug.print` anymore
because the output just goes off into the `void`.

Believe it or not, there's actually an easy solution.
`AllocConsole` and `FreeConsole` allow me to create and
then destroy a console where stdout will finally be
displayed. Just a little bit of binding work and now
I have a console in Windows again!

```zig
if(builtin.mode == .Debug){
    _ = wintypes.AllocConsole();
    // defer can't be used here because it executes
    // at the end of this "if" scope, when we need
    // it to execute at the end of the containing scope.
}

os_win.show();
os_win.loop();

if(builtin.mode == .Debug){
    _ = wintypes.FreeConsole();
}
```

This actually helped me correct my message loop,
which needed to be changed to this:

```zig
if(uMsg == wintypes.WM_CLOSE){
    wintypes.PostQuitMessage(0);
    std.debug.print("Posted quit message!\n", .{});
}
return wintypes.DefWindowProcA(hwnd, uMsg, wParam, lParam);
```

Originally, I was `return 0` inside of the if statement.
This worked on Win 11, but for some reason, not Win 10.
Having the function return the default made it Win 10
compatible, which does make sense.