# opencv-raspberrypi

[![GitHub Release](https://img.shields.io/github/v/release/prepkg/opencv-raspberrypi)](https://github.com/prepkg/opencv-raspberrypi/releases/latest)
[![License](https://img.shields.io/github/license/prepkg/opencv-raspberrypi)](https://github.com/prepkg/opencv-raspberrypi/blob/master/LICENSE)
[![Downloads](https://img.shields.io/github/downloads/prepkg/opencv-raspberrypi/total)](https://github.com/prepkg/opencv-raspberrypi/releases)
[![Linux](https://github.com/prepkg/opencv-raspberrypi/actions/workflows/linux.yaml/badge.svg)](https://github.com/prepkg/opencv-raspberrypi/actions/workflows/linux.yaml)

> 🚀️ Always up-to-date [OpenCV](https://github.com/opencv/opencv) binaries for Raspberry Pi - just download and use it.

> ⭐ If you find this repository useful, please consider giving it a star.

OpenCV binaries are compiled with the [GCC Toolchain](https://github.com/prepkg/gcc-toolchain) targeting older glibc
versions, ensuring compatibility across a wide range of Raspberry Pi boards running Raspberry Pi OS 64-bit. GitHub CI
workflows are used to automate the build process: pipelines run daily, but new builds are triggered only when a new
OpenCV release is available.

## Why?

* **No official OpenCV packages.** There are no prebuilt official OpenCV packages for Raspberry Pi OS, forcing users
  to compile it from source themselves.
* **Slow compilation on Raspberry Pi.** Building OpenCV directly on a Raspberry Pi can take hours and often runs into
  the limited RAM available on the device.
* **Always up to date.** GitHub CI workflows rebuild and publish OpenCV automatically whenever a new version is released
  upstream.
* **No extra dependencies.** The required libraries are statically linked, so the OpenCV binaries only depend on the
  base system libraries already present on Raspberry Pi OS.

## Build Information

* Dynamically linked with an older glibc version. For details, see the [GCC Toolchain](https://github.com/prepkg/gcc-toolchain).
* Statically linked with libstdc++, libgcc, and OpenBLAS.

## Precompiled Binaries

If you prefer not to build the OpenCV yourself, a precompiled OpenCV can be downloaded from the [releases page](https://github.com/prepkg/opencv-raspberrypi/releases).

```shell
curl -sSLo opencv.deb https://github.com/prepkg/opencv-raspberrypi/releases/latest/download/opencv-aarch64-linux-gnu.deb \
  && sudo apt install -y ./opencv.deb \
  && rm -rf opencv.deb
```

## Compilation

### Requirements

* Git
* Docker

### Instructions

* Clone the repository:

```shell
git clone https://github.com/prepkg/opencv-raspberrypi.git && cd opencv-raspberrypi
```

* Build the Docker image:

```shell
./setup.sh build-image
```

* Build the library:

```shell
./setup.sh build-lib
```

After compilation, the `deb` package will be available in the `build` directory.

* (Optional) Run the test to verify that the library links correctly and the resulting binary runs under QEMU:

```shell
./setup.sh test-lib
```
