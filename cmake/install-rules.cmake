install(
    TARGETS executable_exe
    RUNTIME COMPONENT executable_Runtime
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
