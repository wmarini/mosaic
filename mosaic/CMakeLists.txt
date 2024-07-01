# OpenCV
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
link_directories(${OpenCV_LIB_DIR})
link_libraries(${OpenCV_LIBS})

# CUDA
include_directories("${CMAKE_SOURCE_DIR}/include/mosaic")
message(STATUS "Platform in use: ${CMAKE_SOURCE_DIR}")
add_library(mosaic STATIC
    "mosaic.cu"
    "common.cu"
)
target_compile_features(mosaic PUBLIC cxx_std_14)
target_link_libraries(mosaic
    PUBLIC
        cuda
        npps
        nppisu_static
        nppif_static
        nppc_static
        culibos
        ${OpenCV_LIBS}
)
set_property(TARGET ${target_name} 
        PROPERTY CUDA_SEPARABLE_COMPILATION ON)
