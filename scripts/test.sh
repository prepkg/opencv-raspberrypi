#!/bin/bash
set -eo pipefail

APP=$(pwd)
TARGET_ROOT=/opt/target
QEMU="qemu-aarch64 -L /opt/aarch64-linux-gnu/aarch64-linux-gnu/sysroot -E LD_LIBRARY_PATH=$TARGET_ROOT/usr/local/lib"

dpkg -x $APP/build/opencv-aarch64-linux-gnu.deb $TARGET_ROOT

$QEMU $TARGET_ROOT/usr/local/bin/opencv_version

/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-g++ $APP/scripts/test/main.cpp -o /tmp/test \
  -I$TARGET_ROOT/usr/local/include \
  -L$TARGET_ROOT/usr/local/lib \
  -static-libstdc++ \
  -static-libgcc \
  -lopencv_calib \
  -lopencv_core \
  -lopencv_dnn \
  -lopencv_features \
  -lopencv_flann \
  -lopencv_geometry \
  -lopencv_highgui \
  -lopencv_imgcodecs \
  -lopencv_imgproc \
  -lopencv_objdetect \
  -lopencv_photo \
  -lopencv_ptcloud \
  -lopencv_stereo \
  -lopencv_stitching \
  -lopencv_video \
  -lopencv_videoio

$QEMU /tmp/test

for f in /opt/target/usr/local/lib/*.so.*.* /opt/target/usr/local/bin/* /tmp/test; do
  echo "File: $f"
  /opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-readelf -d "$f" | grep NEEDED
done
