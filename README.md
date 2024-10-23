# ZigBlocks
ZigBlocks is a YAMCC (Yet Another Minecraft Clone).

Every once in a while, another YAMCC video series
pops up on YouTube. These YAMCC series generally
follow the same pattern. They get a single block
rendering, then work on the world mesh, world mesh
optimization, then add noise to the terrain and
usually end around the lighting/trees/caves landmark.

Unfortunately, while these problems are very hard
to solve, there's two things left to be desired:

- It's been done before
- There's TONS of things that haven't been tackled

I want to tackle the harder problems. These may
include:

- Physics engine
- Game serialization (save/load)
- AI (mainly: pathfinding. Animations are not a focus)
- Actual game ticks and world updates
- Flowing water
- Multiplayer / account system / dedicated server
- Scripting / modding
- Vulkan rendering
- UI / font / 2D rendering

I believe multiplayer has been done before, but
I've never seen a dedicated server and certainly never
seen a login system where you get a persistent account.

I also want to try Vulkan out just because everyone
always uses OpenGL.

## I Don't Know
Just about all of my goals are completely and totally
insane because, to varying degrees, I am a complete and
total beginner at most of them. I've just barely used
any Zig before, never used Vulkan, I have never implemented
any physics at all, and I've never tried to implement
advanced AI with pathfinding and behavior. Nor have I
ever made a game with such complex multiplayer.

This project is honestly doomed from the start, but it's
OK if I come out the other end without any product to show
for it. I just want to learn and test my abilities. Maybe
I will come back five years later and see how much farther
I can get. Until then, I guess we can only see what happens.

## The Blog
Read about my progress and see what it's like to be me!

- [entry1](blog/entry1.md): I create a basic win32 window
- [entry2](blog/entry2.md): Implementing a win32 message loop for the window
- [entry3](blog/entry3.md): Code re-org of previous two entries