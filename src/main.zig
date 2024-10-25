const std = @import("std");
const window = @import("./interfacing/window.zig");
const graphics = @import("./graphics/graphics.zig");

const vkfuncs = @import("./graphics/vulkan/methods.zig");
const vktypes = @import("./graphics/vulkan/types.zig");

pub fn main() !void {
    const os_window = try window.OSWindow.init(.{});
    os_window.show();

    const graphics_instance = try graphics.Graphics.init();

    var properties: vktypes.VkPhysicalDeviceProperties = undefined;
    vkfuncs.vkGetPhysicalDeviceProperties(graphics_instance.active_physical_device.*, &properties);
    std.debug.print("Active physical device name: {s}\n", .{ properties.deviceName });

    os_window.loop();
}
