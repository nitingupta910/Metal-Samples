cmake_minimum_required(VERSION 3.30)

project(metal_samples)

set(CMAKE_CXX_STANDARD 20)

# Include custom CMake functions
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(MetalShaders)
include(SetupSDL)
setup_sdl()
include(SetupMetal)
setup_metal()

set(DEPS_DIR ${CMAKE_SOURCE_DIR}/deps)

# Global Metal-cpp include directory
include_directories(${DEPS_DIR}/metal-cpp)

# Samples
add_subdirectory(triangle)
