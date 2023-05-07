cmake_minimum_required(VERSION 3.24)
project(pk16)

set(CMAKE_CXX_STANDARD 20)

include_directories(${PROJECT_SOURCE_DIR}/compiler/header/)

add_executable(pk16 compiler/source/main.cpp)
