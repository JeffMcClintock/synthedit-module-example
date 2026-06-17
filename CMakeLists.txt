cmake_minimum_required(VERSION 3.30)

# Universal (Intel + Apple Silicon) macOS builds.
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.15" CACHE STRING "Minimum macOS deployment version")
set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "macOS build architectures" FORCE)

# Point at a local GMPI checkout, or leave blank to fetch it from GitHub automatically.
set(GMPI_SDK_FOLDER_OVERRIDE "" CACHE PATH "Path to a local GMPI repo, or blank to fetch it.")

include(FetchContent)

# The GMPI SDK is pulled in automatically on the first configure — you don't clone it
# by hand. We only need its 'Core' (the DSP/module API) for a DSP module.
if("${GMPI_SDK_FOLDER_OVERRIDE}" STREQUAL "")
    message(STATUS "Fetching GMPI SDK from GitHub")
    FetchContent_Declare(
        gmpi
        GIT_REPOSITORY https://github.com/JeffMcClintock/GMPI
        GIT_TAG origin/main
        SOURCE_SUBDIR Core
    )
    FetchContent_MakeAvailable(gmpi)
    set(GMPI_SDK ${gmpi_SOURCE_DIR})
else()
    message(STATUS "Using local GMPI SDK at ${GMPI_SDK_FOLDER_OVERRIDE}")
    set(GMPI_SDK ${GMPI_SDK_FOLDER_OVERRIDE})
endif()

project(SynthEditModuleExample)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
add_definitions(-D_UNICODE)
if(NOT CMAKE_BUILD_TYPE MATCHES Debug)
    add_definitions(-DNDEBUG)
endif()
if(MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /fp:fast /GS-")
endif()
if(APPLE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffast-math")
endif()

# gmpi_plugin() — the helper that turns your .cpp into a loadable .gmpi module.
include(${GMPI_SDK}/gmpi_plugin.cmake)

add_subdirectory(Gain)
