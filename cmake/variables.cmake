# ---- Developer mode ----

if(PROJECT_IS_TOP_LEVEL)
  option(executable_DEVELOPER_MODE "Enable developer mode" OFF)

  if("$ENV{CI}")
    set(executable_DEVELOPER_MODE ON CACHE INTERNAL "")
  endif()
endif()

# ---- Warning guard ----

if(NOT PROJECT_IS_TOP_LEVEL)
  option(
      executable_INCLUDE_WITHOUT_SYSTEM
      "Enable executable's warnings for dependents"
      OFF
  )
endif()
set(executable_warning_guard SYSTEM)
if(PROJECT_IS_TOP_LEVEL OR executable_INCLUDE_WITHOUT_SYSTEM)
  set(executable_warning_guard "")
endif()
