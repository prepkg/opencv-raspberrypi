#!/bin/bash
set -eo pipefail

APP=$(pwd)
TARGET_ROOT=/opt/target
TOOLCHAIN=/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu
QEMU="qemu-aarch64 -L /opt/aarch64-linux-gnu/aarch64-linux-gnu/sysroot -E LD_LIBRARY_PATH=$TARGET_ROOT/usr/local/lib"

dpkg -x $APP/build/opencv-aarch64-linux-gnu.deb $TARGET_ROOT

$QEMU $TARGET_ROOT/usr/local/bin/opencv_version

$TOOLCHAIN-g++ $APP/scripts/test/main.cpp -o /tmp/test -s \
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

ACCEPTED_LIBS='libc\.so.*|libm\.so.*|libpthread\.so.*|libdl\.so.*|libopencv_.*\.so.*'

for f in $TARGET_ROOT/usr/local/lib/*.so.*.* $TARGET_ROOT/usr/local/bin/* /tmp/test; do
  echo "File: $f"

  if $TOOLCHAIN-readelf -S "$f" | grep -q '\.symtab'; then
    echo "Error: $f is not stripped"
    exit 1
  fi

  needed=$($TOOLCHAIN-readelf -d "$f" | grep NEEDED)
  echo "$needed"
  if grep -vE "$ACCEPTED_LIBS" <<< "$needed"; then
    echo "Error: unaccepted NEEDED library in $f"
    exit 1
  fi
done
