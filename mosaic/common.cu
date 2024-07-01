#include "common.h"
#include <cuda_runtime.h>
#include <npp.h>
#include <iostream>

namespace common {
    
__host__ void check(cudaError_t result, char const *const func, const char *const file, int const line)
{
    if (result != cudaSuccess) {
        std::cerr << "CUDA Runtime Error at: " 
            << file << ':' << line 
            << " code=" << static_cast<unsigned int>(result) << ' '
            << cudaGetErrorString(result) << " in function " << func << std::endl;
        std::exit(EXIT_FAILURE);
    }
}

__host__ CudaVersion CUDAVersion()
{
    int n_devices;
    CHECK_CUDA_ERROR(cudaGetDeviceCount(&n_devices));
    if (n_devices > 0) {
        cudaDeviceProp prop;
        CHECK_CUDA_ERROR(cudaGetDeviceProperties(&prop, 0));
        return CudaVersion{prop.major,prop.minor};
    }
    return CudaVersion{0,0};
}

__host__ CudaVersion NPPVersion()
{
    const NppLibraryVersion* lib_ver = nppGetLibVersion();
    return (lib_ver != nullptr) ? 
                CudaVersion{lib_ver->major,lib_ver->minor} : 
                CudaVersion{0,0};
}

} // namespace common
