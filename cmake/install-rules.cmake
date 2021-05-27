if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_INCLUDEDIR include/executable CACHE PATH "")
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

install(
    TARGETS executable_executable
    EXPORT executableTargets
    RUNTIME COMPONENT executable_Runtime
)

write_basic_package_version_file(
    executableConfigVersion.cmake
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    executable_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/executable"
    CACHE STRING "CMake package config location relative to the install prefix"
)
mark_as_advanced(executable_INSTALL_CMAKEDIR)

install(
    FILES
    cmake/executableConfig.cmake
    "${PROJECT_BINARY_DIR}/executableConfigVersion.cmake"
    DESTINATION "${executable_INSTALL_CMAKEDIR}"
    COMPONENT executable_Development
)

install(
    EXPORT executableTargets
    NAMESPACE executable::
    DESTINATION "${executable_INSTALL_CMAKEDIR}"
    COMPONENT executable_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
