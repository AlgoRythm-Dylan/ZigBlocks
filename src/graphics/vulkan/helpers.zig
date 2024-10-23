const std = @import("std");

pub fn MakeAPIVersion(variant: u32, major: u32, minor: u32, patch: u32) u32 {
    return variant << 29 | major << 22 | minor << 12 | patch;
}

test "API Version is generated correctly" {
    // TODO
    try std.testing.expect(MakeAPIVersion(0, 1, 3, 0) == 4206592);
}