FROM ubuntu:26.04

WORKDIR /app

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        curl ca-certificates make ninja-build qemu-user \
    && VERSION=$(basename $(curl -sILo /dev/null -w '%{url_effective}' https://github.com/Kitware/CMake/releases/latest)) \
    && curl -sSL https://github.com/Kitware/CMake/releases/latest/download/cmake-${VERSION#v}-linux-x86_64.tar.gz | tar xz --strip-components=1 -C /usr/local \
    && curl -sSL https://github.com/prepkg/gcc-toolchain/releases/latest/download/gcc-aarch64-linux-gnu.tar.gz | tar xz -C /opt \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]
