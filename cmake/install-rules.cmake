include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package executable)

install(
    TARGETS executable_exe
    RUNTIME COMPONENT executable_Runtime
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    executable_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(executable_INSTALL_CMAKEDIR)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${executable_INSTALL_CMAKEDIR}"
    COMPONENT executable_Development
)

# Export variables for the install script to use
install(CODE "
set(executable_NAME [[$<TARGET_FILE_NAME:executable_exe>]])
set(executable_INSTALL_CMAKEDIR [[${executable_INSTALL_CMAKEDIR}]])
set(CMAKE_INSTALL_BINDIR [[${CMAKE_INSTALL_BINDIR}]])
" COMPONENT executable_Development)

install(
    SCRIPT cmake/install-script.cmake
    COMPONENT executable_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
