#ifndef MOSAIC_H
#define MOSAIC_H

#include "common.h"
#include <string>
#include <vector>

namespace mosaic {

using ImageList = std::vector<std::string>;

struct MosaicConfig {
    std::string images_path{"./data/"};
};

__host__ void ProcessMosaic(const MosaicConfig&& config);

} // namespace mosaic

#endif // MOSAIC_H
