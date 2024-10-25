const std = @import("std");
const win = std.os.windows;
const window = @import("./interfacing/window.zig");
const wintypes = @import("./platform/windows.zig");
const builtin = @import("builtin");
const graphics = @import("./graphics/graphics.zig");

const vkfuncs = @import("./graphics/vulkan/methods.zig");

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

    const graphics_instance = graphics.Graphics.init() catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return 1;
    };

    var physical_device_count: u32 = 99;
    _ = vkfuncs.vkEnumeratePhysicalDevices(graphics_instance.vulkan_instance, &physical_device_count, null);
    std.debug.print("Physical devices found: {d}\n", .{ physical_device_count });


    defer graphics_instance.deinit();
    errdefer graphics_instance.deinit();

    os_win.show();
    os_win.loop();

    if(builtin.mode == .Debug){
        _ = wintypes.FreeConsole();
    }

    return 0;
}