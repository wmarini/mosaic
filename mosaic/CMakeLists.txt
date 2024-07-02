# OpenCV
find_package(OpenCV)

# CUDA
include_directories("${CMAKE_SOURCE_DIR}/include/mosaic")
message(STATUS "Platform in use: ${CMAKE_SOURCE_DIR}")
add_library(mosaic STATIC
    "mosaic.cu"
    "common.cu"
)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 11)
    target_compile_features(mosaic PUBLIC cxx_std_17)
else()
    target_compile_features(mosaic PUBLIC cxx_std_14)
endif()

target_link_libraries(mosaic
    PUBLIC
        ${OpenCV_LIBS}
        cuda
        npps
        nppisu_static
        nppif_static
        nppc_static
        culibos
        pthread
)
set_property(TARGET ${target_name} 
        PROPERTY CUDA_SEPARABLE_COMPILATION ON)
