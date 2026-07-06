#!/bin/bash
set -eo pipefail

APP=$(pwd)
mkdir -p $APP/build /tmp/{openblas,opencv}

VERSION=$(basename $(curl -sILo /dev/null -w '%{url_effective}' https://github.com/OpenMathLib/OpenBLAS/releases/latest))
curl -sSL https://github.com/OpenMathLib/OpenBLAS/archive/refs/tags/$VERSION.tar.gz | tar xz --strip-components=1 -C /tmp/openblas

VERSION=$(basename $(curl -sILo /dev/null -w '%{url_effective}' https://github.com/opencv/opencv/releases/latest))
curl -sSL https://github.com/opencv/opencv/archive/refs/tags/$VERSION.tar.gz | tar xz --strip-components=1 -C /tmp/opencv

{
  echo $VERSION

  cd /tmp/openblas && rm -rf build
  cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=$APP/scripts/pi.cmake \
    -DCMAKE_C_FLAGS='-w'
  cmake --build build -j$(nproc)
  cmake --install build --strip

  cd /tmp/opencv && rm -rf build
  cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=$APP/scripts/pi.cmake \
    -DCMAKE_INSTALL_PREFIX=build/install/usr/local \
    -DCMAKE_INSTALL_RPATH='$ORIGIN' \
    -DCMAKE_EXE_LINKER_FLAGS='-static-libstdc++ -static-libgcc' \
    -DCMAKE_SHARED_LINKER_FLAGS='-static-libstdc++ -static-libgcc' \
    -DCMAKE_CXX_FLAGS='-w -Wno-psabi' \
    -DBUILD_APPS_LIST='version' \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_TESTS=OFF \
    -DWITH_ZLIB_NG=ON \
    -DOPENCV_GENERATE_SETUPVARS=OFF \
    -DOPENCV_PYTHON_SKIP_DETECTION=ON \
    -DOPENCV_INCLUDE_INSTALL_PATH=include \
    -DOPENCV_OTHER_INSTALL_PATH=/tmp/opencv-share \
    -DOPENCV_LICENSES_INSTALL_PATH=/tmp/opencv-share
  cmake --build build -j$(nproc)
  cmake --install build --strip
} 2>&1 | tee $APP/build/opencv-aarch64-linux-gnu.txt

cd /tmp/opencv/build && mkdir install/DEBIAN

cat << EOF > install/DEBIAN/control
Package: opencv
Version: $VERSION-1
Architecture: arm64
Maintainer: prepkg <precompiledpkg@gmail.com>
Description: Computer vision library
EOF

cat << EOF > install/DEBIAN/postinst
#!/bin/bash

ldconfig
EOF

chmod 755 install/DEBIAN/postinst
dpkg-deb -Zxz --build install $APP/build/opencv-aarch64-linux-gnu.deb
