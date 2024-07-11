# Building Mosaic

## Clone the Github repository

```bash
$ git clone 'https://github.com/wmarini/mosaic.git'
$ cd mosaic
```

You can also download the [Zip](https://github.com) and extract in your local machine.  

## Build the program

```bash
$ mkdir build && cd build/
$ cmake -DCMAKE_BUILD_TYPE="Release" ..
```

```bash
$ cd build/
$ cmake -G Ninja -DCMAKE_BUILD_TYPE="Debug" ..
```

## Executing Mosaic

```bash
$ cd 
# . run.sh
```
