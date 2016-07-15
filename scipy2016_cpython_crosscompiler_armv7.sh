#!/usr/bin/env bash

git clone git://github.com/python-cmake-buildsystem/python-cmake-buildsystem
cd python-cmake-buildsystem
export SRC=$(pwd)

docker run -ti -v $SRC:/usr/pysrc:ro \
  thewtex/cross-compiler-linux-armv7 bash -c '\
mkdir /usr/build; cd /usr/build; \
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DPY_VERSION_MAJOR=3 \
  -DPY_VERSION_MINOR=5 \
  -DPY_VERSION_PATCH=2 \
  -DENABLE_OSSAUDIODEV=0 \
  -DENABLE_LINUXAUDIODEV=0 \
  -DENABLE_CTYPES=0 -DENABLE_DECIMAL=0 -DENABLE_TESTCAPI=0 -DENABLE_CTYPES_TEST=0 \
  -DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_FILE ../pysrc; \
make -j8; \
ctest -j8; \
bash'
