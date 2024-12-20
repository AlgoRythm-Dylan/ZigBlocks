const std = @import("std");
const builtin = @import("builtin");
const win = std.os.windows;
const wintypes = @import("../platform/windows.zig");
const x11 = @import("../platform/x11.zig");

const is_windows: bool = builtin.os.tag == .windows;

pub fn ZigWindowProcA(
    hwnd: win.HWND,
    uMsg: win.UINT,
    wParam: win.WPARAM,
    lParam: win.LPARAM
) callconv(win.WINAPI) isize {
    if(uMsg == wintypes.WM_CLOSE){
        wintypes.PostQuitMessage(0);
        std.debug.print("Posted quit message!\n", .{});
    }
    return wintypes.DefWindowProcA(hwnd, uMsg, wParam, lParam);
}

const DEFAULT_WIDTH: u32 = 500;
const DEFAULT_HEIGHT: u32 = 300;

pub const OSWindowArgs = if(is_windows) struct {
    hInstance: win.HINSTANCE,
    width: u32 = DEFAULT_WIDTH,
    height: u32 = DEFAULT_HEIGHT,
}
else struct {
    width: u32 = DEFAULT_WIDTH,
    height: u32 = DEFAULT_HEIGHT,
};

pub const OSWindowReference = if(is_windows) win.HWND else x11.X11DisplayReference;

pub const OSWindow = struct {

    instance: OSWindowReference = undefined,

    pub fn init(args: OSWindowArgs) !OSWindow {
        if(is_windows){
            return initWindows(args);
        }
        else {
            return try initX11(args);
        }
    }
    pub fn show(this: *const OSWindow) void {
        if(is_windows){
            this.showWindows();
        }
        else {
            this.showX11();
        }
    }
    pub fn loop(this: *const OSWindow) void {
        if(is_windows){
            this.loopWindows();
        }
        else {
            this.loopX11();
        }
    }

    fn initWindows(args: OSWindowArgs) OSWindow {
        // Create the "window class" - look and feel,
        // capabilities, etc.
        const win_class: wintypes.WNDCLASSA = . {
            .hInstance = args.hInstance,
            .lpfnWndProc = ZigWindowProcA,
            .lpszClassName = "ZigBlocks Window Class"
        };
        // Register the class so we can request instances of it
        _ = wintypes.RegisterClassA(&win_class);
        // Request an instance of it
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
            args.hInstance,
            null);

        // Return a new OSWindow containing that instance
        return .{ .instance = instance };
    }

    fn showWindows(this: *const OSWindow) void {
        _ = wintypes.ShowWindow(this.instance, 1);
    }

    fn loopWindows(this: *const OSWindow) void {
        var message: wintypes.MSG = undefined;
        while(wintypes.GetMessageA(&message, this.instance, 0, 0) > 0){
            _ = wintypes.TranslateMessage(&message);
            _ = wintypes.DispatchMessageA(&message);
        }
        std.debug.print("Out of the message loop now\n", .{});
    }

    fn initX11(args: OSWindowArgs) !OSWindow {
        _ = args;
        const ref = x11.initX11();
        return .{ .instance = ref };
    }

    fn showX11(this: *const OSWindow) void {
        x11.showX11Window(&this.instance);
    }

    fn loopX11(this: *const OSWindow) void {
        x11.loopX11Window(&this.instance);
    }
};