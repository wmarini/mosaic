# Installing and Building Mosaic

## Dependencies

*Mosaic* has the following dependencies:

- [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads)

## Clone the Github repository

```bash
git clone 'https://github.com/wmarini/mosaic.git'
```

You can also download the [Zip](https://github.com) and extract in your local machine.  

## Build the program

```bash
cd build/
cmake -G Ninja -DCMAKE_BUILD_TYPE="Release" ..
```

```bash
cd build/
cmake -G Ninja -DCMAKE_CUDA_FLAGS="-arch=sm_50" -DCMAKE_BUILD_TYPE="Release" ..
```

## Executing Mosaic

```bash
cd 
run.sh
```
