cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

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
    executable_lib ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

target_compile_features(executable_lib PUBLIC cxx_std_17)

# ---- Declare executable ----

add_executable(executable_exe source/main.cpp)
add_executable(executable::exe ALIAS executable_exe)

set_property(TARGET executable_exe PROPERTY OUTPUT_NAME executable)

target_compile_features(executable_exe PRIVATE cxx_std_17)

target_link_libraries(executable_exe PRIVATE executable_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT executable_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of executable"
  )
endif()

include(cmake/dev-mode.cmake)
