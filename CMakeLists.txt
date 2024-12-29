cmake_minimum_required(VERSION 3.30)

project(metal_samples)

set(CMAKE_CXX_STANDARD 20)

set(DEPS_DIR ${CMAKE_SOURCE_DIR}/deps)

# Global Metal-cpp include directory
include_directories(${DEPS_DIR}/metal-cpp)

# Find all Metal-related frameworks once
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

# SDL2

# We don't care about deprecation warnings for SDL
# Set up compiler flags for SDL before including it
if(APPLE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-deprecated-declarations")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations")
endif()

add_subdirectory(deps/SDL)

# Reset compiler flags after SDL
if(APPLE)
    string(REPLACE " -Wno-deprecated-declarations" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
    string(REPLACE " -Wno-deprecated-declarations" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
endif()

# End SDL2

add_subdirectory(triangle)
