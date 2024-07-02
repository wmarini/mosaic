cmake_minimum_required(VERSION 3.16)

if(POLICY CMP0104)
	cmake_policy(SET CMP0104 OLD)
endif()

project(mosaic CXX CUDA)

set(CMAKE_BUILD_TYPE Debug)

set(CMAKE_CXX_COMPILER nvcc)
# if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 11)
# 	message(STATUS "C++17")
# 	# set(CMAKE_CXX_STANDARD 17)
# 	# set(CMAKE_CUDA_STANDARD 17)
# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")
# else()
# 	message(STATUS "C++14")
# 	set(CMAKE_CUDA_STANDARD 14)
# endif()
# set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
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
