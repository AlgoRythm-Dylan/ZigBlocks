const std = @import("std");
const vktypes = @import("./vulkan/types.zig");
const vkfuncs = @import("./vulkan/methods.zig");

const MAX_DEVICE_COUNT = 8;

pub const Graphics = struct {

    vulkan_instance: vktypes.VkInstance,
    physical_device_count: u32 = 0,
    physical_devices: [MAX_DEVICE_COUNT]vktypes.VkPhysicalDevice = undefined,
    active_physical_device: *vktypes.VkPhysicalDevice = undefined,

    pub fn init() !Graphics {
        var instance: vktypes.VkInstance = undefined;

        const create_info = vktypes.VkInstanceCreateInfo { };

        const result = vkfuncs.vkCreateInstance(&create_info, null, &instance);
        if(result != vktypes.VK_SUCCESS){
            return error.VkCreateInstanceFailed;
        }

        var g: Graphics = .{
            .vulkan_instance = instance
        };

        try g.getPhysicalDeviceCount();
        try g.getPhysicalDevices();
        g.pickPhysicalDevice();

        return g;
    }

    pub fn deinit(this: *const Graphics) void {
        vkfuncs.vkDestroyInstance(this.vulkan_instance, null);
    }

    fn getPhysicalDeviceCount(this: *Graphics) !void {
        const result = vkfuncs.vkEnumeratePhysicalDevices(this.vulkan_instance, &this.physical_device_count, null);
        if(result != vktypes.VK_SUCCESS){
            return error.CouldNotEnumeratePhysicalDevices;
        }
    }

    fn getPhysicalDevices(this: *Graphics) !void {
        if(this.physical_device_count > MAX_DEVICE_COUNT){
            return error.TooManyDevices;
        }
        const result = vkfuncs.vkEnumeratePhysicalDevices(this.vulkan_instance, &this.physical_device_count, &this.physical_devices);
        if(result != vktypes.VK_SUCCESS){
            return error.CouldNotEnumeratePhysicalDevices;
        }
    }

    fn pickPhysicalDevice(this: *Graphics) void {
        // For now, just return the first device
        this.active_physical_device = &this.physical_devices[0];
        if(this.hasQueueFamily(vktypes.VK_QUEUE_GRAPHICS_BIT)){
            std.debug.print("Does have graphics bit\n", .{});
        }
        else {
            std.debug.print("Does NOT have graphics bit\n", .{});
        }
    }

    fn hasQueueFamily(this: *const Graphics, flag: vktypes.VkQueueFlags) bool {
        var queueFamilies: [16]vktypes.VkQueueFamilyProperties = undefined;
        var count: u32 = 0;
        vkfuncs.vkGetPhysicalDeviceQueueFamilyProperties(
            this.active_physical_device.*,
            &count,
            &queueFamilies
        );
        for(0..count) | index | {
            if(queueFamilies[index].queueFlags & flag > 0){
                return true;
            }
        }
        return false;
    }

};