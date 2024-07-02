#include "mosaic.h"
#include "UtilNPP/Exceptions.h"
#include "UtilNPP/ImageIO.h"
#include "UtilNPP/ImagesCPU.h"
#include "UtilNPP/ImagesNPP.h"
#include <npp.h>
#include "helper_cuda.h"
#include "helper_string.h"
#include <cuda_runtime.h>
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

    // declare a host image object for an 8-bit grayscale image
    npp::ImageCPU_8u_C1 oHostSrc;
    // load gray-scale image from disk
    npp::loadImage("/home/wmarini/projects/gpulab/game/mosaic/data/lenna-gray.png", oHostSrc);
    // declare a device image and copy construct from the host image,
    // i.e. upload host to device
    npp::ImageNPP_8u_C1 oDeviceSrc(oHostSrc);

    // create struct with box-filter mask size
    NppiSize oMaskSize = {5, 5};

    NppiSize oSrcSize = {(int)oDeviceSrc.width(), (int)oDeviceSrc.height()};
    NppiPoint oSrcOffset = {0, 0};

    // create struct with ROI size
    NppiSize oSizeROI = {(int)oDeviceSrc.width(), (int)oDeviceSrc.height()};
    // allocate device image of appropriately reduced size
    npp::ImageNPP_8u_C1 oDeviceDst(oSizeROI.width, oSizeROI.height);
    // set anchor point inside the mask to (oMaskSize.width / 2,
    // oMaskSize.height / 2) It should round down when odd
    NppiPoint oAnchor = {oMaskSize.width / 2, oMaskSize.height / 2};

    // run box filter
    NPP_CHECK_NPP(nppiFilterBoxBorder_8u_C1R(
        oDeviceSrc.data(), oDeviceSrc.pitch(), oSrcSize, oSrcOffset,
        oDeviceDst.data(), oDeviceDst.pitch(), oSizeROI, oMaskSize, oAnchor,
        NPP_BORDER_REPLICATE));

    // declare a host image for the result
    npp::ImageCPU_8u_C1 oHostDst(oDeviceDst.size());
    // and copy the device result data into it
    oDeviceDst.copyTo(oHostDst.data(), oHostDst.pitch());
    std::string sResultFilename = "/home/wmarini/projects/gpulab/game/mosaic/data/lenna-gray-out.png";
    npp::saveImage(sResultFilename, oHostDst);
    std::cout << "Saved image: " << sResultFilename << std::endl;

    nppiFree(oDeviceSrc.data());
    nppiFree(oDeviceDst.data());
}

}