const std = @import("std");

var is_for_windows: bool = false;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    is_for_windows = target.result.os.tag == .windows;

    const optimize = b.standardOptimizeOption(.{});

    const entrypoint =
        if (is_for_windows) b.path("src/winmain.zig")
        else b.path("src/main.zig");

    const exe = b.addExecutable(.{
        .name = "ZigBlocks",
        .root_source_file = entrypoint,
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);

    addLibs(b, exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_unit_tests = b.addTest(.{
        .root_source_file = entrypoint,
        .target = target,
        .optimize = optimize,
    });

    addLibs(b, exe_unit_tests);

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}

fn addLibs(b: *std.Build, comp: *std.Build.Step.Compile) void {
    comp.linkLibC();
    if (is_for_windows) {
        comp.linkSystemLibrary("user32");
    }
    else {
        comp.linkSystemLibrary("X11");
    }
    addVulkan(b, comp);
}

fn addVulkan(b: *std.Build, comp: *std.Build.Step.Compile) void {
    if (is_for_windows) {
        comp.addLibraryPath(b.path("./dependency/windows/lib/"));
    }
    else {
        comp.addLibraryPath(b.path("./dependency/linux/lib/"));
    }
    comp.linkSystemLibrary("vulkan-1");
}
