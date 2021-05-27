cmake_minimum_required(VERSION 3.14)

include(cmake/in-source-guard.cmake)

project(
    executable
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    executable_lib OBJECT
    source/lib.cpp
)

target_include_directories(
    executable_lib
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_compile_features(executable_lib PUBLIC cxx_std_17)

# ---- Declare executable ----

add_executable(executable_executable source/main.cpp)
add_executable(executable::executable ALIAS executable_executable)

set_target_properties(
    executable_executable PROPERTIES
    OUTPUT_NAME executable
    EXPORT_NAME executable
)

target_compile_features(executable_executable PRIVATE cxx_std_17)

target_link_libraries(executable_executable PRIVATE executable_lib)

# ---- Install rules ----

include(cmake/install-rules.cmake)

# ---- Developer mode ----

if(NOT executable_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of executable"
  )
endif()

include(CTest)
if(BUILD_TESTING)
  add_subdirectory(test)
endif()

add_custom_target(
    run_exe
    COMMAND "$<TARGET_FILE:executable_executable>"
    VERBATIM
)

option(BUILD_DOCUMENTATION "Build documentation using Doxygen and m.css" OFF)
if(BUILD_DOCUMENTATION)
  include(cmake/docs.cmake)
endif()

option(ENABLE_COVERAGE "Enable coverage support separate from CTest's" OFF)
if(ENABLE_COVERAGE)
  include(cmake/coverage.cmake)
endif()
