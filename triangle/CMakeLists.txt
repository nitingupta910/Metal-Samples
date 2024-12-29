project(triangle)

# Add the executable
add_executable(${PROJECT_NAME} main.cpp)

# Setup metal shaders for this project
setup_metal_shaders(${PROJECT_NAME} "${CMAKE_CURRENT_SOURCE_DIR}/shaders.metal")

# Link required libraries
target_link_libraries(${PROJECT_NAME} PRIVATE
    SDL2::SDL2
    metal_frameworks
)
