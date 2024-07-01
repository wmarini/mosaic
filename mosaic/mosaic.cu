#include "mosaic.h"
#include <npp.h>
#include <cuda_runtime.h>
#include <opencv2/opencv.hpp>
#include <filesystem>
#include <iostream>

namespace mosaic {

namespace {

ImageList GetImageList(const std::string& images_dir)
{
    ImageList image_list;

    
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
        << image_list.size() << std::endl;

    using namespace cv;
    //Create an 8 bit single channel image
    Mat img = imread("data/lenna.png", IMREAD_GRAYSCALE );
    std::cout << img.size() << std::endl;
}

}