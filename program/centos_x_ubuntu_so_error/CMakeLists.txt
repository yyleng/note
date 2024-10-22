cmake_minimum_required(VERSION 2.0)
project(test)

add_library(shared SHARED shared.cpp)
target_include_directories(shared PUBLIC ${CMAKE_CURRENT_LIST_DIR})

add_executable(main main.cpp)
target_link_libraries(main PUBLIC shared)
