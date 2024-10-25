const std = @import("std");
const window = @import("./interfacing/window.zig");

pub fn main() !void {
    const os_window = try window.OSWindow.init(.{});
    os_window.show();
    os_window.loop();
}
