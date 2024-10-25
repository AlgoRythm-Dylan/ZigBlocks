const types = @import("./types.zig");

pub extern fn vkCreateInstance(
    pCreateInfo: *const types.VkInstanceCreateInfo,
    pAllocator: ?*const types.VkAllocationCallbacks,
    pInstance: *types.VkInstance
) types.VkResult;

pub extern fn vkDestroyInstance(
    pCreateInfo: types.VkInstance,
    pAllocator: ?*const types.VkAllocationCallbacks
) void;

pub extern fn vkEnumeratePhysicalDevices(
    instance: types.VkInstance,
    pPhysicalDeviceCount: *u32,
    pPhysicalDevices: ?[*]types.VkPhysicalDevice
) types.VkResult;

pub extern fn vkGetPhysicalDeviceProperties(
    physicalDevice: types.VkPhysicalDevice,
    pProperties: *types.VkPhysicalDeviceProperties
) void;

pub extern fn vkCreateWin32SurfaceKH(
    instance: types.VkInstance,
    pCreateInfo: types.VkWin32SurfaceCreateInfoKHR
) types.VkResult;