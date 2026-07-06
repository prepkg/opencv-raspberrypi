#!/bin/bash
set -eo pipefail

if [[ ! $1 =~ ^(build-image|build-lib|test-lib)$ ]]; then
  echo 'Available arguments: build-image, build-lib, test-lib'
  exit 1
fi

if [[ $1 == build-image ]]; then
  docker build -t opencv scripts

  exit 0
fi

if [[ $1 == build-lib ]]; then
  docker run --rm -v ./:/app opencv scripts/compile.sh
  sudo chown -R $USER:$USER build

  exit 0
fi

if [[ $1 == test-lib ]]; then
  docker run --rm -v ./:/app opencv scripts/test.sh

  exit 0
fi
