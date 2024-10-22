const std = @import("std");
const win = std.os.windows;
const window = @import("./interfacing/window.zig");
const wintypes = @import("./platform/windows.zig");

// pub fn main() !void {
//     window.showTestWindow();
// }

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
    var message: wintypes.MSG = undefined;
    while(wintypes.GetMessageA(&message, null, 0, 0) > 0){
        _ = wintypes.TranslateMessage(&message);
        _ = wintypes.DispatchMessageA(&message);
    }

    return 0;
}