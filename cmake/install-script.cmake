file(
    RELATIVE_PATH relative_path
    "/${executable_INSTALL_CMAKEDIR}"
    "/${CMAKE_INSTALL_BINDIR}/${executable_NAME}"
)

get_filename_component(prefix "${CMAKE_INSTALL_PREFIX}" ABSOLUTE)
set(config_dir "${prefix}/${executable_INSTALL_CMAKEDIR}")
set(config_file "${config_dir}/executableConfig.cmake")

message(STATUS "Installing: ${config_file}")
file(WRITE "${config_file}" "\
get_filename_component(
    _executable_executable
    \"\${CMAKE_CURRENT_LIST_DIR}/${relative_path}\"
    ABSOLUTE
)
set(
    EXECUTABLE_EXECUTABLE \"\${_executable_executable}\"
    CACHE FILEPATH \"Path to the executable executable\"
)
")
