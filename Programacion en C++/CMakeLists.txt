cmake_minimum_required(VERSION 3.10)
project(mi_proyecto)

set(CMAKE_CXX_STANDARD 17)

find_package(mongocxx REQUIRED)
find_package(bsoncxx REQUIRED)

add_executable(mi_app main.cpp)

target_link_libraries(mi_app PRIVATE 
    mongo::mongocxx_shared 
    mongo::bsoncxx_shared)