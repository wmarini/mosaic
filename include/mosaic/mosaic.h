#ifndef MOSAIC_H
#define MOSAIC_H

#include "common.h"
#include <string>
#include <vector>

namespace mosaic {

struct MosaicConfig {
    std::size_t kernel_size{5};
};

__host__ void ProcessMosaic(
        const MosaicConfig& config, 
        const std::string&, const std::string&);


} // namespace mosaic

#endif // MOSAIC_H
