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

One littel caveat was that the docs all reference
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