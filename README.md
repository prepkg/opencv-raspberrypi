# opencv-raspberrypi

Precompiled **OpenCV 4.5.2** binaries for **Raspberry Pi 3 & 4**.

## Supported features

* NEON optimization
* VFPV3 optimization
* TBB library
* FFmpeg library
* GStreamer library
* Python 2 and Python 3 bindings

You can read detailed build information [here](build_information.txt).

## Prerequisites

### Supported Boards

* Raspberry Pi 3 Model A+
* Raspberry Pi 3 Model B+
* Raspberry Pi 4 Model B

Tested on Raspberry Pi 4 Model B (8 GB).

### Supported OS

* Raspberry Pi OS Buster (32-bit)

## Install

* `wget https://github.com/prepkg/opencv-raspberrypi/releases/latest/download/opencv.deb`
* `sudo apt install -y ./opencv.deb`

## Uninstall

* `sudo apt purge --autoremove -y opencv`

## Debian Package

Debian package contains the following shared libraries:

* libopencv_calib3d.so
* libopencv_core.so
* libopencv_dnn.so
* libopencv_features2d.so
* libopencv_flann.so
* libopencv_gapi.so
* libopencv_highgui.so
* libopencv_imgcodecs.so
* libopencv_imgproc.so
* libopencv_ml.so
* libopencv_objdetect.so
* libopencv_photo.so
* libopencv_stitching.so
* libopencv_video.so
* libopencv_videoio.so
* libtbb.so
