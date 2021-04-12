# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

add_executable(executable_test source/executable_test.cpp)
target_link_libraries(executable_test PRIVATE executable_lib)
target_compile_features(executable_test PRIVATE cxx_std_17)

add_test(NAME executable_test COMMAND executable_test)
