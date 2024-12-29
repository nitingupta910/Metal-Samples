macro(setup_sdl)
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
endmacro() 