#!/bin/bash

function setup_toolchain() {
    echo "##############################"
    echo "#### Setting up toolchain ####"
    echo "##############################"
    mkdir -p rpi
    pushd rpi
#    git clone git://github.com/raspberrypi/tools.git
    if [ ! -f "gcc-linaro-arm-linux-gnueabihf-raspbian-x64.tar.gz" ]; then
        wget https://www.dropbox.com/s/pwgtvpvlakjqpi7/gcc-linaro-arm-linux-gnueabihf-raspbian-x64.tar.gz?dl=0 -O gcc-linaro-arm-linux-gnueabihf-raspbian-x64.tar.gz
        tar -zxvf gcc-linaro-arm-linux-gnueabihf-raspbian-x64.tar.gz
    fi
    popd
    export PATH=$PATH:$PWD/rpi/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
    echo $PATH
    arm-linux-gnueabihf-gcc -v
}

function autoconfig_tools() {
    echo "##############################"
    echo "#### aclocal              ####"
    echo "##############################"
    aclocal
    if [ $? -ne 0 ]; then
        echo "Failed aclocal"
        exit -1
    fi

    echo "##############################"
    echo "#### autoconf             ####"
    echo "##############################"
    autoconf
    if [ $? -ne 0 ]; then
        echo "Failed autoconf"
        exit -1
    fi

    echo "##############################"
    echo "#### automake             ####"
    echo "##############################"
    automake --add-missing
    if [ $? -ne 0 ]; then
        echo "Failed automake --add-missing"
        exit -1
    fi

    mkdir -p $BUILD_PACKAGE_NAME
    pushd $BUILD_PACKAGE_NAME

    CC=arm-linux-gnueabihf-gcc ../configure --host=arm-linux-gnueabihf-gcc 
    #CC=arm-linux-gnueabihf-gcc ../configure --prefix=${CSTOOL_DIR}/linux_arm_tool 

    if [ $? -ne 0 ]; then
        echo "Failed ../configure"
        exit -1
    fi
}

function build_app() {
    echo "##############################"
    echo "#### build_app            ####"
    echo "##############################"
    setup_toolchain
    autoconfig_tools

    make
    if [ $? -ne 0 ]; then
        echo "Failed make"
        exit -1
    fi

    file helloworld
    popd
    tar -zcvf $BUILD_PACKAGE_NAME.tgz $BUILD_PACKAGE_NAME
}

function cleanup() {
    rm -rf rpi autom4te.cache
    rm Makefile.in aclocal.m4 compile configure depcomp install-sh missing
    rm -rf $BUILD_PACKAGE_NAME
}

build_app
cleanup
