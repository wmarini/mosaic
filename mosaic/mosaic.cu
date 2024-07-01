#include "mosaic.h"
#include <npp.h>
#include <cuda_runtime.h>
#include <filesystem>
#include <iostream>

namespace mosaic {

namespace {

ImageList GetImageList(const std::string& images_dir)
{
    const std::filesystem::path images_path(images_dir);
    ImageList image_list;

    for (auto p : std::filesystem::directory_iterator(images_path)) {
        if (p.is_regular_file()) {
            std::cout << p.path().string() << std::endl;
            image_list.push_back(p.path().string());
        }
    }
    return image_list;
}

} // namespace

__host__
void ProcessMosaic(const MosaicConfig&& config)
{
    std::cout << "Images directory: " 
        << config.images_path << std::endl;
    auto image_list = GetImageList(config.images_path);
    std::cout << "# Images to be processed: " 
        << std::size(image_list) << std::endl;
}

}