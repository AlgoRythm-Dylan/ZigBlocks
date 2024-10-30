const win32 = @import("std").os.windows;

pub const VkStructureType = i32;
pub const VkFlags = i32;
pub const VkInstanceCreateFlags = VkFlags;
pub const VkQueueFlags = VkFlags;
pub const VkWin32SurfaceCreateFlagsKHR = i32;
pub const VkResult = i32;
pub const VkInstance = *opaque{};
pub const VkSystemAllocationScope = i32;
pub const VkSystemAllocationType = i32;
pub const VkPhysicalDevice = *opaque{};
pub const VkBool32 = u32;

pub const VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO: VkStructureType = 1;
pub const VK_MAX_PHYSICAL_DEVICE_NAME_SIZE: u32 = 256;
pub const VK_UUID_SIZE: u32 = 16;

pub const VK_QUEUE_GRAPHICS_BIT: VkQueueFlags = 0x00000001;
pub const VK_QUEUE_COMPUTE_BIT: VkQueueFlags = 0x00000002;
pub const VK_QUEUE_TRANSFER_BIT: VkQueueFlags = 0x00000004;
pub const VK_QUEUE_SPARSE_BINDING_BIT: VkQueueFlags = 0x00000008;
pub const VK_QUEUE_PROTECTED_BIT: VkQueueFlags = 0x00000010;
pub const VK_QUEUE_VIDEO_DECODE_BIT_KHR: VkQueueFlags = 0x00000020;
pub const VK_QUEUE_VIDEO_ENCODE_BIT_KHR: VkQueueFlags = 0x00000040;
pub const VK_QUEUE_OPTICAL_FLOW_BIT_NV: VkQueueFlags = 0x00000100;

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

pub const VkDeviceSize = u64;
pub const VkSampleCountFlags = VkFlags;
pub const VkPhysicalDeviceType = i32;

pub const VkPhysicalDeviceLimits = extern struct {
    maxImageDimension1D: u32 = undefined,
    maxImageDimension2D: u32 = undefined,
    maxImageDimension3D: u32 = undefined,
    maxImageDimensionCube: u32 = undefined,
    maxImageArrayLayers: u32 = undefined,
    maxTexelBufferElements: u32 = undefined,
    maxUniformBufferRange: u32 = undefined,
    maxStorageBufferRange: u32 = undefined,
    maxPushConstantsSize: u32 = undefined,
    maxMemoryAllocationCount: u32 = undefined,
    maxSamplerAllocationCount: u32 = undefined,
    bufferImageGranularity: VkDeviceSize = undefined,
    sparseAddressSpaceSize: VkDeviceSize = undefined,
    maxBoundDescriptorSets: u32 = undefined,
    maxPerStageDescriptorSamplers: u32 = undefined,
    maxPerStageDescriptorUniformBuffers: u32 = undefined,
    maxPerStageDescriptorStorageBuffers: u32 = undefined,
    maxPerStageDescriptorSampledImages: u32 = undefined,
    maxPerStageDescriptorStorageImages: u32 = undefined,
    maxPerStageDescriptorInputAttachments: u32 = undefined,
    maxPerStageResources: u32 = undefined,
    maxDescriptorSetSamplers: u32 = undefined,
    maxDescriptorSetUniformBuffers: u32 = undefined,
    maxDescriptorSetUniformBuffersDynamic: u32 = undefined,
    maxDescriptorSetStorageBuffers: u32 = undefined,
    maxDescriptorSetStorageBuffersDynamic: u32 = undefined,
    maxDescriptorSetSampledImages: u32 = undefined,
    maxDescriptorSetStorageImages: u32 = undefined,
    maxDescriptorSetInputAttachments: u32 = undefined,
    maxVertexInputAttributes: u32 = undefined,
    maxVertexInputBindings: u32 = undefined,
    maxVertexInputAttributeOffset: u32 = undefined,
    maxVertexInputBindingStride: u32 = undefined,
    maxVertexOutputComponents: u32 = undefined,
    maxTessellationGenerationLevel: u32 = undefined,
    maxTessellationPatchSize: u32 = undefined,
    maxTessellationControlPerVertexInputComponents: u32 = undefined,
    maxTessellationControlPerVertexOutputComponents: u32 = undefined,
    maxTessellationControlPerPatchOutputComponents: u32 = undefined,
    maxTessellationControlTotalOutputComponents: u32 = undefined,
    maxTessellationEvaluationInputComponents: u32 = undefined,
    maxTessellationEvaluationOutputComponents: u32 = undefined,
    maxGeometryShaderInvocations: u32 = undefined,
    maxGeometryInputComponents: u32 = undefined,
    maxGeometryOutputComponents: u32 = undefined,
    maxGeometryOutputVertices: u32 = undefined,
    maxGeometryTotalOutputComponents: u32 = undefined,
    maxFragmentInputComponents: u32 = undefined,
    maxFragmentOutputAttachments: u32 = undefined,
    maxFragmentDualSrcAttachments: u32 = undefined,
    maxFragmentCombinedOutputResources: u32 = undefined,
    maxComputeSharedMemorySize: u32 = undefined,
    maxComputeWorkGroupCount: [3]u32 = undefined,
    maxComputeWorkGroupInvocations: u32 = undefined,
    maxComputeWorkGroupSize: [3]u32 = undefined,
    subPixelPrecisionBits: u32 = undefined,
    subTexelPrecisionBits: u32 = undefined,
    mipmapPrecisionBits: u32 = undefined,
    maxDrawIndexedIndexValue: u32 = undefined,
    maxDrawIndirectCount: u32 = undefined,
    maxSamplerLodBias: f32 = undefined,
    maxSamplerAnisotropy: f32 = undefined,
    maxViewports: u32 = undefined,
    maxViewportDimensions: [2]u32 = undefined,
    viewportBoundsRange: [2]f32 = undefined,
    viewportSubPixelBits: u32 = undefined,
    minMemoryMapAlignment: usize = undefined,
    minTexelBufferOffsetAlignment: VkDeviceSize = undefined,
    minUniformBufferOffsetAlignment: VkDeviceSize = undefined,
    minStorageBufferOffsetAlignment: VkDeviceSize = undefined,
    minTexelOffset: i32 = undefined,
    maxTexelOffset: u32 = undefined,
    minTexelGatherOffset: i32 = undefined,
    maxTexelGatherOffset: u32 = undefined,
    minInterpolationOffset: f32 = undefined,
    maxInterpolationOffset: f32 = undefined,
    subPixelInterpolationOffsetBits: u32 = undefined,
    maxFramebufferWidth: u32 = undefined,
    maxFramebufferHeight: u32 = undefined,
    maxFramebufferLayers: u32 = undefined,
    framebufferColorSampleCounts: VkSampleCountFlags = undefined,
    framebufferDepthSampleCounts: VkSampleCountFlags = undefined,
    framebufferStencilSampleCounts: VkSampleCountFlags = undefined,
    framebufferNoAttachmentsSampleCounts: VkSampleCountFlags = undefined,
    maxColorAttachments: u32 = undefined,
    sampledImageColorSampleCounts: VkSampleCountFlags = undefined,
    sampledImageIntegerSampleCounts: VkSampleCountFlags = undefined,
    sampledImageDepthSampleCounts: VkSampleCountFlags = undefined,
    sampledImageStencilSampleCounts: VkSampleCountFlags = undefined,
    storageImageSampleCounts: VkSampleCountFlags = undefined,
    maxSampleMaskWords: u32 = undefined,
    timestampComputeAndGraphics: VkBool32 = undefined,
    timestampPeriod: f32 = undefined,
    maxClipDistances: u32 = undefined,
    maxCullDistances: u32 = undefined,
    maxCombinedClipAndCullDistances: u32 = undefined,
    discreteQueuePriorities: u32 = undefined,
    pointSizeRange: [2]f32 = undefined,
    lineWidthRange: [2]f32 = undefined,
    pointSizeGranularity: f32 = undefined,
    lineWidthGranularity: f32 = undefined,
    strictLines: VkBool32 = undefined,
    standardSampleLocations: VkBool32 = undefined,
    optimalBufferCopyOffsetAlignment: VkDeviceSize = undefined,
    optimalBufferCopyRowPitchAlignment: VkDeviceSize = undefined,
    nonCoherentAtomSize: VkDeviceSize = undefined,
};

pub const VkPhysicalDeviceSparseProperties = extern struct {
    residencyStandard2DBlockShape: VkBool32 = undefined,
    residencyStandard2DMultisampleBlockShape: VkBool32 = undefined,
    residencyStandard3DBlockShape: VkBool32 = undefined,
    residencyAlignedMipSize: VkBool32 = undefined,
    residencyNonResidentStrict: VkBool32 = undefined,
};

pub const VkPhysicalDeviceProperties = extern struct {
    apiVersion: u32 = undefined,
    driverVersion: u32 = undefined,
    vendorID: u32 = undefined,
    deviceID: u32 = undefined,
    deviceType: VkPhysicalDeviceType = undefined,
    deviceName: [VK_MAX_PHYSICAL_DEVICE_NAME_SIZE:0]u8 = undefined,
    pipelineCacheUUID: [VK_UUID_SIZE]u8 = undefined,
    limits: VkPhysicalDeviceLimits = undefined,
    sparseProperties: VkPhysicalDeviceSparseProperties = undefined
};

pub const VkExtent3D = extern struct {
    width: u32 = undefined,
    height: u32 = undefined,
    depth: u32 = undefined,
};

pub const VkQueueFamilyProperties = extern struct {
    queueFlags: VkQueueFlags = undefined,
    queueCount: u32 = undefined,
    timestampValidBits: u32 = undefined,
    minImageTransferGranularity: VkExtent3D = undefined
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