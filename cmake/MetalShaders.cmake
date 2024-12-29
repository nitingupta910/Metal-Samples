function(setup_metal_shaders TARGET SHADER_SOURCE)
    # Generate config.h for this target
    set(CONFIG_TEMPLATE_CONTENT 
        "#pragma once\n"
        "#define SHADER_NAME \"${TARGET}_shaders.metallib\""
    )
    file(WRITE "${CMAKE_BINARY_DIR}/${TARGET}_config.h.in" ${CONFIG_TEMPLATE_CONTENT})
    configure_file(
        "${CMAKE_BINARY_DIR}/${TARGET}_config.h.in"
        "${CMAKE_BINARY_DIR}/${TARGET}_config.h"
    )
    target_include_directories(${TARGET} PRIVATE ${CMAKE_BINARY_DIR})

    # Generate unique names for this target's shader files
    set(METAL_SHADER_NAME "${TARGET}_shaders.metallib")
    set(METAL_SHADER_AIR "${CMAKE_BINARY_DIR}/${TARGET}_shaders.air")
    set(METAL_SHADER_LIB "${CMAKE_BINARY_DIR}/${METAL_SHADER_NAME}")

    # Add custom command for this target's shaders
    add_custom_command(
        OUTPUT ${METAL_SHADER_LIB}
        COMMAND xcrun metal -c ${SHADER_SOURCE} -o ${METAL_SHADER_AIR}
        COMMAND xcrun metallib ${METAL_SHADER_AIR} -o ${METAL_SHADER_LIB}
        DEPENDS ${SHADER_SOURCE}
        COMMENT "Compiling Metal shaders for ${TARGET}"
    )

    # Create unique target name for this shader compilation
    add_custom_target(${TARGET}_shaders ALL DEPENDS ${METAL_SHADER_LIB})
    add_dependencies(${TARGET} ${TARGET}_shaders)

    # Copy the .metallib file to the build directory
    add_custom_command(
        TARGET ${TARGET}_shaders POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${METAL_SHADER_LIB} ${CMAKE_BINARY_DIR}
        COMMENT "Copying Metal library file for ${TARGET}"
    )
endfunction()
