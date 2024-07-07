#include "mosaic.h"
#include "mosaicexceptions.h"
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

inline void HighPassBorderFilter(
        const Npp8u* pSrc, Npp32s nSrcStep, NppiSize oSrcSize, NppiPoint oSrcOffset, 
        Npp8u* pDst, Npp32s nDstStep, NppiSize oSizeROI)
{
    NPP_CHECK_NPP(nppiFilterHighPassBorder_8u_C1R(
        pSrc, nSrcStep, oSrcSize, oSrcOffset,
        pDst, nDstStep, oSizeROI, 
        NPP_MASK_SIZE_5_X_5, NPP_BORDER_REPLICATE));
}

} // namespace

__host__
void ProcessMosaic(
        const MosaicConfig& config,
        const std::string& in_image_fname,
        const std::string& out_image_fname)
{
    try {
        // declare a host image object for an 8-bit grayscale image
        npp::ImageCPU_8u_C1 oHostSrc;
        // load gray-scale image from disk
        npp::loadImage(in_image_fname, oHostSrc);
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
        HighPassBorderFilter(
            oDeviceSrc.data(), oDeviceSrc.pitch(), oSrcSize, oSrcOffset,
            oDeviceDst.data(), oDeviceDst.pitch(), oSizeROI);

        // declare a host image for the result
        npp::ImageCPU_8u_C1 oHostDst(oDeviceDst.size());
        // and copy the device result data into it
        oDeviceDst.copyTo(oHostDst.data(), oHostDst.pitch());
        npp::saveImage(out_image_fname, oHostDst);
        std::cout << "Saved image: " << out_image_fname << std::endl;

        nppiFree(oDeviceSrc.data());
        nppiFree(oDeviceDst.data());
        cudaDeviceReset();
    } catch (const npp::Exception& e) {
        throw mosaic::MosaicException(e.toString());
    }
}

}