const std = @import("std");
const win = std.os.windows;
const window = @import("./interfacing/window.zig");
const wintypes = @import("./platform/windows.zig");
const builtin = @import("builtin");

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

    const os_win = window.OSWindow.init(.{ .hInstance = hInstance });

    if(builtin.mode == .Debug){
        _ = wintypes.AllocConsole();
    }

    os_win.show();
    os_win.loop();

    if(builtin.mode == .Debug){
        _ = wintypes.FreeConsole();
    }

    return 0;
}