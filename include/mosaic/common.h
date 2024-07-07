#ifndef COMMON_H
#define COMMON_H

#include <cuda_runtime.h>

#define CHECK_CUDA_ERROR(val) common::check((val), #val, __FILE__, __LINE__)

namespace common {

struct CudaVersion {
    int major;
    int minor;
};

__host__ void check(cudaError_t result, char const *const func, const char *const file, int const line);
__host__ CudaVersion CUDAVersion();
__host__ CudaVersion NPPVersion();
__host__ std::size_t GetDeviceCount();

} // namespace common

#endif // COMMON_H
