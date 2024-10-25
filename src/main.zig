const std = @import("std");
const window = @import("./interfacing/window.zig");
const graphics = @import("./graphics/graphics.zig");
const vkfuncs = @import("./graphics/vulkan/methods.zig");

pub fn main() !void {
    const os_window = try window.OSWindow.init(.{});
    os_window.show();

    const graphics_instance = try graphics.Graphics.init();
    std.debug.print("Physical device count: {}\n", .{ try graphics_instance.getPhysicalDeviceCount() });

    os_window.loop();
}
