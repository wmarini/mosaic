# Mosaic

Mosaic is a CUDA-enabled program that modifies a grayscale image discriminating high-frequency that is commonly found in object edges. 
The filter was implemented using the NPP library function nppiFilterHighPassBorder_8u_C1R, applying a 5x5 mask.

The program requires CMake. The steps for preparing the environment and compiling the program will be explained later. 

For better clarification, the CUDA code was removed from the C++ code and put in a library. This way, this project can be used as a template for more complex programs that require this kind of architecture.

## Image credits

All original photos by Wagner Marini. Licensed under CC BY 4.0.  

## Requirements

*Mosaic* expected you have the development environment ready to go, with `nvcc` already installed, and uses the following libraries as requirements:

- freeimage
- cuda-samples
- [CUDA Toolkit 12.5](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network)how

*freeimage* installation procedure:  

```bash
$ sudo apt-get -y install libfreeimage-dev
```

*cuda-samples* installation procedure:

```bash
$ wget 'https://github.com/NVIDIA/cuda-samples/archive/refs/tags/v12.4.1.tar.gz'
$ tar -xvf v12.4.1.tar.gz
```

## Installation

Check out the [INSTALL](https://github.com/wmarini/mosaic/blob/main/INSTALL.md) file to learn how to clone this project and build and execute the application.

## Running Mosaic

![lick observatory](https://github.com/wmarini/mosaic/blob/main/data/DSC06580.jpg)  
![lick observatory high pass](https://github.com/wmarini/mosaic/blob/main/data/DSC06580_out.jpg)  

![santa cruz surf museum](https://github.com/wmarini/mosaic/blob/main/data/DSC06609.jpg)  
![santa cruz surf museum high pass](https://github.com/wmarini/mosaic/blob/main/data/DSC06609_out.jpg)  

![santa cruz surfing statue](https://github.com/wmarini/mosaic/blob/main/data/DSC06628.jpg)  
![santa cruz surfing statue high pass](https://github.com/wmarini/mosaic/blob/main/data/DSC06628_out.jpg)  

![oakand bay bridge](https://github.com/wmarini/mosaic/blob/main/data/DSC06834.jpg)  
![oakand bay bridge high pass](https://github.com/wmarini/mosaic/blob/main/data/DSC06834_out.jpg)  


## Rubrics

1. [Code Repository](https://github.com/wmarini/mosaic)
1. Proof of execution artifacts &rarr; This README.
1. Code Project Description &rarr; This README and [output.txt](https://github.com/wmarini/mosaic/blob/main/output.txt) file.

## References

[1] [Image Filtering Functions](https://docs.nvidia.com/cuda/npp/image_filtering_functions.html)
