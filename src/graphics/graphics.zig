const vktypes = @import("./vulkan/types.zig");
const vkfuncs = @import("./vulkan/methods.zig");

pub const Graphics = struct {

    vulkan_instance: vktypes.VkInstance,

    pub fn init() !Graphics {
        var instance: vktypes.VkInstance = undefined;

        const create_info = vktypes.VkInstanceCreateInfo { };

        const result = vkfuncs.vkCreateInstance(&create_info, null, &instance);
        if(result != vktypes.VK_SUCCESS){
            return error.VkCreateInstanceFailed;
        }

        return Graphics {
            .vulkan_instance = instance
        };
    }

    pub fn deinit(this: *const Graphics) void {
        vkfuncs.vkDestroyInstance(this.vulkan_instance, null);
    }

    pub fn getPhysicalDeviceCount(this: *const Graphics) !u32 {
        var count: u32 = undefined;
        const result = vkfuncs.vkEnumeratePhysicalDevices(this.vulkan_instance, &count, null);
        if(result != vktypes.VK_SUCCESS){
            return error.CouldNotEnumeratePhysicalDevices;
        }
        return count;
    }

};