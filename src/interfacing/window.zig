const std = @import("std");
const win = std.os.windows;
const wintypes = @import("../platform/windows.zig");

pub fn showTestWindow(hInstance: win.HINSTANCE) void {
    const win_class: wintypes.WNDCLASSA = . {
        .hInstance = hInstance,
        .lpszClassName = "ZigBlocks Window Class"
    };
    _ = wintypes.RegisterClassA(&win_class);
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
    _ = wintypes.ShowWindow(instance, 1);
}