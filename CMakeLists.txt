cmake_minimum_required(VERSION 3.16)

project(mosaic CXX CUDA)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CXX_COMPILER nvcc)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/../bin)

add_subdirectory(mosaic)
include_directories("include")

function(add_program target_name)
	add_executable(${target_name} ${ARGN})
	target_include_directories(${target_name} 
		PRIVATE include/mosaic)
    set_property(TARGET ${target_name} 
        PROPERTY CUDA_SEPARABLE_COMPILATION ON)
	target_link_libraries(${target_name}
		PRIVATE 
			mosaic
            cuda)
endfunction()


add_program("mosaic.exe" 
	"src/main.cpp"
    "src/appexception.cpp"
)

# reference: https://developer.nvidia.com/blog/building-cuda-applications-cmake/
