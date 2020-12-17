set(CMAKE_CXX_STANDARD 17)

add_executable(problem1 main.cpp CSI.cpp CSI.h TestHelper.cpp TestHelper.h)

configure_file(test/test.in  test/test.in COPYONLY)
configure_file(test/test1.out test/test1.out COPYONLY)
configure_file(test/test2.out test/test2.out COPYONLY)
configure_file(test/test3.out test/test3.out COPYONLY)
configure_file(test/test4.out test/test4.out COPYONLY)
configure_file(test/test5.out test/test5.out COPYONLY)