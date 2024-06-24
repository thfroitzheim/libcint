#!/bin/bash

# git clone git@github.com:marvinfriede/libcint.git && cd libcint
# ./autocode.sh
# ./build.sh


# exit whole script and not only the current command (CTRL+C)
trap "echo Exited!; exit;" SIGINT SIGTERM

# deactivate conda to not use mkl from miniforge
if ! command -v conda &>/dev/null; then
    conda deactivate
fi

DIR="libcint"
export FC=ifort
export CC=icc
export CXX=icpc

if [[ "$(basename "$(pwd)")" == "$DIR" ]]; then
    BUILD_DIR="$PWD/_build"
    if [ ! -d "$BUILD_DIR" ]; then
        mkdir "$BUILD_DIR"
    fi
    cd $BUILD_DIR

    cmake \
        -DCMAKE_INSTALL_PREFIX:PATH=/home/froitzheim/bin/libcint \
        -DBUILD_SHARED_LIBS=0 \
        -DWITH_F12=OFF \
        -DWITH_CINT2_INTERFACE=OFF \
        -DMIN_EXPCUTOFF=10\
        ..
        #-DPXPYPZ=ON \
        #-DD

    make install
else
    echo "The current directory is not '$DIR'."
    exit 1
fi
