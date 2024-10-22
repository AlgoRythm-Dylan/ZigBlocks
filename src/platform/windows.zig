const std = @import("std");
const win = std.os.windows;

pub extern fn DefWindowProcA(
    hwnd: win.HWND,
    uMsg: win.UINT,
    wParam: win.WPARAM,
    lParam: win.LPARAM
) callconv(win.WINAPI) isize;

pub const WNDCLASSA = extern struct {
    style: win.UINT = 0,
    lpfnWndProc: *const fn(win.HWND, win.UINT, win.WPARAM, win.LPARAM) callconv(win.WINAPI) win.LRESULT = DefWindowProcA,
    cbClsExtra: c_int = 0,
    cbWndExtra: c_int = 0,
    hInstance: ?win.HINSTANCE = null,
    hIcon: ?win.HICON = null,
    hCursor: ?win.HCURSOR = null,
    hbrBackground: ?win.HBRUSH = null,
    lpszMenuName: ?win.LPCSTR = null,
    lpszClassName: win.LPCSTR,
};

pub extern fn RegisterClassA(lpWndClass: *const WNDCLASSA) win.ATOM;

pub const WS_BORDER: win.DWORD = 0x00800000;
pub const WS_CAPTION: win.DWORD = 0x00C00000;
pub const WS_CHILD: win.DWORD = 0x40000000;
pub const WS_CHILDWINDOW: win.DWORD = 0x40000000;
pub const WS_CLIPCHILDREN: win.DWORD = 0x02000000;
pub const WS_CLIPSIBLINGS: win.DWORD = 0x04000000;
pub const WS_DISABLED: win.DWORD = 0x08000000;
pub const WS_DLGFRAME: win.DWORD = 0x00400000;
pub const WS_GROUP: win.DWORD = 0x00020000;
pub const WS_HSCROLL: win.DWORD = 0x00100000;
pub const WS_ICONIC: win.DWORD = 0x20000000;
pub const WS_MAXIMIZE: win.DWORD = 0x01000000;
pub const WS_MAXIMIZEBOX: win.DWORD = 0x00010000;
pub const WS_MINIMIZE: win.DWORD = 0x20000000;
pub const WS_MINIMIZEBOX: win.DWORD = 0x00020000;
pub const WS_OVERLAPPED: win.DWORD = 0x00000000;
pub const WS_OVERLAPPEDWINDOW: win.DWORD = (WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX);
pub const WS_POPUP: win.DWORD = 0x80000000;
pub const WS_POPUPWINDOW: win.DWORD = (WS_POPUP | WS_BORDER | WS_SYSMENU);
pub const WS_SIZEBOX: win.DWORD = 0x00040000;
pub const WS_SYSMENU: win.DWORD = 0x00080000;
pub const WS_TABSTOP: win.DWORD = 0x00010000;
pub const WS_THICKFRAME: win.DWORD = 0x00040000;
pub const WS_TILED: win.DWORD = 0x00000000;
pub const WS_TILEDWINDOW: win.DWORD = (WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX);
pub const WS_VISIBLE: win.DWORD = 0x10000000;
pub const WS_VSCROLL: win.DWORD = 0x00200000;

pub extern fn CreateWindowExA(
    dwExStyle: win.DWORD,
    lpClassName: ?win.LPCSTR,
    lpWindowName: ?win.LPCSTR,
    dwStyle: win.DWORD,
    X: c_int,
    Y: c_int,
    nWidth: c_int,
    nHeight: c_int,
    hWndParent: ?win.HWND,
    hMenu: ?win.HMENU,
    hInstance: ?win.HINSTANCE,
    lpParam: ?win.LPVOID
) win.HWND;

pub extern fn ShowWindow(hWnd: win.HWND, nCmdShow: c_int) win.BOOL;

pub const MSG = extern struct {
    hwnd: win.HWND,
    message: win.UINT,
    wParam: win.WPARAM,
    lParam: win.LPARAM,
    time: win.DWORD,
    pt: win.POINT,
    lPrivate: win.DWORD
};

pub extern fn GetMessageA(lpMsg: *MSG, hWnd: ?win.HWND, wMsgFilterMin: win.UINT, wMsgFilterMax: win.UINT) win.BOOL;
pub extern fn TranslateMessage(lpMsg: *const MSG) win.BOOL;
pub extern fn DispatchMessageA(lpMsg: *const MSG) win.BOOL;