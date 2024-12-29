macro(setup_metal)
    # Find all Metal-related frameworks
    find_library(METAL_FRAMEWORK Metal REQUIRED)
    find_library(METAL_KIT_FRAMEWORK MetalKit REQUIRED)
    find_library(QUARTZ_CORE_FRAMEWORK QuartzCore REQUIRED)
    find_library(FOUNDATION_FRAMEWORK Foundation REQUIRED)

    # Create an interface library for Metal dependencies
    add_library(metal_frameworks INTERFACE)
    target_link_libraries(metal_frameworks INTERFACE
        ${METAL_FRAMEWORK}
        ${METAL_KIT_FRAMEWORK}
        ${QUARTZ_CORE_FRAMEWORK}
        ${FOUNDATION_FRAMEWORK}
    )
endmacro() 