# opencv-raspberrypi

![opencv-raspberrypi](https://i.ibb.co/n6PQvVF/opencv-raspberrypi.png)

Precompiled **OpenCV 4.5.3** binaries for **Raspberry Pi 3 & 4**. 
Read the following [blog post](https://lindevs.com/install-precompiled-opencv-on-raspberry-pi) for additional information.

## Supported features

* NEON optimization
* VFPv3 optimization
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

| Library                     | Description                                              |
| :-------------------------  | :------------------------------------------------------- |
| libopencv_calib3d.so        | Camera calibration and 3D reconstruction                 |
| libopencv_core.so           | The Core Functionality                                   |
| libopencv_dnn.so            | Deep Neural Networks                                     |
| libopencv_features2d.so     | 2D Features framework                                    |
| libopencv_flann.so          | Feature Matching with FLANN                              |
| libopencv_gapi.so           | Graph API                                                |
| libopencv_highgui.so        | High Level GUI and Media                                 |
| libopencv_imgcodecs.so      | Image Input and Output                                   |
| libopencv_imgproc.so        | Image Processing                                         |
| libopencv_ml.so             | Machine Learning                                         |
| libopencv_objdetect.so      | Object Detection                                         |
| libopencv_photo.so          | Computational photography                                |
| libopencv_stitching.so      | Images stitching                                         |
| libopencv_video.so          | Video analysis                                           |
| libopencv_videoio.so        | Video Input and Output                                   |
| libtbb.so                   | TBB (Threading Building Blocks)                          |

## Reference

1. [OpenCV repository](https://github.com/opencv/opencv)
