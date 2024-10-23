# It's time to Vulk
One thing that always confuses the hell out
of me is dependency management - especially
in c/c++ projects. It's time to add a layer of
complexity and throw Zig in the mix!

## The SDK
I spent a good amount of time reading about Vulkan
before I decided to dive into this and they all
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