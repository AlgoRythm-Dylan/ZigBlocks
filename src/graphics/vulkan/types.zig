const win32 = @import("std").os.windows;

pub const VkStructureType = i32;
pub const VkInstanceCreateFlags = i32;
pub const VkWin32SurfaceCreateFlagsKHR = i32;
pub const VkResult = i32;
pub const VkInstance = *opaque{};
pub const VkSystemAllocationScope = i32;
pub const VkSystemAllocationType = i32;
pub const VkPhysicalDevice = *opaque{};

pub const VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO: VkStructureType = 1;

pub const VK_SUCCESS: VkResult = 0;

pub const VkApplicationInfo = extern struct {
    /// A VkStructureType value identifying this structure.
    sType: VkStructureType,
    /// NULL or a pointer to a structure extending this structure
    pNext: ?*const anyopaque,
    /// NULL or is a pointer to a null-terminated UTF-8
    /// string containing the name of the application
    pApplicationName: ?[*:0]const u8,
    /// an unsigned integer variable containing the
    /// developer-supplied version number of the application
    applicationVersion: u32 = 1,
    /// NULL or is a pointer to a null-terminated
    /// UTF-8 string containing the name of the
    /// engine (if any) used to create the application.
    pEngineName: ?[*:0]const u8,
    /// An unsigned integer variable containing
    /// the developer-supplied version number
    /// of the engine used to create the application
    engineVersion: u32 = 0,
    /// **Must** be the highest version of Vulkan
    /// that the application is designed to use,
    /// encoded as described in
    /// https://registry.khronos.org/vulkan/specs/1.3-extensions/html/vkspec.html#extendingvulkan-coreversions-versionnumbers.
    /// The patch version number specified in
    /// apiVersion is ignored when creating an
    /// instance object. The variant version of the
    /// instance must match that requested
    /// in apiVersion. (use VK_MAKE_API_VERSION)
    apiVersion: u32
};

pub const VkInstanceCreateInfo = extern struct {
    /// a VkStructureType value identifying this structure
    sType: VkStructureType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
    /// NULL or a pointer to a structure extending
    /// this structure
    pNext: ?*const anyopaque = null,
    /// a bitmask of VkInstanceCreateFlagBits indicating
    /// the behavior of the instance
    flags: VkInstanceCreateFlags = 0,
    /// NULL or a pointer to a VkApplicationInfo
    /// structure. If not NULL, this information
    /// helps implementations recognize behavior
    /// inherent to classes of applications
    pApplicationInfo: ?*VkApplicationInfo = null,
    /// is the number of global layers to enable
    enabledLayerCount: u32 = 0,
    /// is a pointer to an array of
    /// enabledLayerCount null-terminated
    /// UTF-8 strings containing the
    /// names of layers to enable for the
    /// created instance. The layers are
    /// loaded in the order they are listed
    /// in this array, with the first array
    /// element being the closest to the
    /// application, and the last array
    /// element being the closest to the
    /// driver. See the
    /// https://registry.khronos.org/vulkan/specs/1.3-extensions/html/vkspec.html#extendingvulkan-layers
    /// section for further details
    ppEnabledLayerNames: ?[*][*:0]const u8 = null,
    /// the number of global extensions to enable
    enabledExtensionCount: u32 = 0,
    /// a pointer to an array of
    /// enabledExtensionCount null-terminated
    /// UTF-8 strings containing the names
    /// of extensions to enable
    ppEnabledExtensionNames: ?[*][*:0]const u8 = null
};



pub const PFN_vkAllocationFunction =
    *const fn(pUserData: *anyopaque, size: usize, alignment: usize, allocationScope: VkSystemAllocationScope)
    callconv(.C) *anyopaque;
pub const PFN_vkReallocationFunction =
    *const fn(pUserData: *anyopaque, pOriginal: *anyopaque, size: usize, alignment: usize, allocationScope: VkSystemAllocationScope)
    callconv(.C) *anyopaque;
pub const PFN_vkFreeFunction =
    *const fn(pUserData: *anyopaque, pMemory: *anyopaque)
    callconv(.C) void;
pub const PFN_vkInternalAllocationNotification =
    *const fn(pUserData: *anyopaque, size: usize, type: VkSystemAllocationType, allocationScope: VkSystemAllocationScope)
    callconv(.C) void;
pub const PFN_vkInternalFreeNotification =
    *const fn(pUserData: *anyopaque, size: usize, type: VkSystemAllocationType, allocationScope: VkSystemAllocationScope)
    callconv(.C) void;

pub const VkAllocationCallbacks = extern struct {
    pUserData: *anyopaque,
    pfnAllocation: PFN_vkAllocationFunction,
    pfnReallocation: PFN_vkReallocationFunction,
    pfnFree: PFN_vkFreeFunction,
    pfnInternalAllocation: PFN_vkInternalAllocationNotification,
    pfnInternalFree: PFN_vkInternalFreeNotification
};

/// Structure specifying parameters of a newly created Win32 surface object
pub const VkWin32SurfaceCreateInfoKHR = extern struct {
    /// a VkStructureType value identifying this structure
    sType: VkStructureType,
    /// NULL or a pointer to a structure extending this structure
    pNext: ?*const anyopaque,
    /// reserved for future use
    flags: VkWin32SurfaceCreateFlagsKHR = 0,
    /// the Win32 HINSTANCE for the window to associate the surface with
    hInstance: win32.HINSTANCE,
    /// the Win32 HWND for the window to associate the surface with
    hwnd: win32.HWND
};