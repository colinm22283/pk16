cmake_minimum_required(VERSION 3.24)
project(pk16)

set(CMAKE_CXX_STANDARD 20)

set(CMAKE_EXE_LINKER_FLAGS "-static")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/compiler/bin)

include_directories(${PROJECT_SOURCE_DIR}/compiler/header/)

add_executable(pk16
        compiler/source/main.cpp
        )
