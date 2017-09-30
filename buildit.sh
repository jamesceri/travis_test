#!/bin/bash

aclocal
if [ $? -ne 0 ]; then
    echo "Failed aclocal"
    exit -1
fi

autoconf
if [ $? -ne 0 ]; then
    echo "Failed autoconf"
    exit -1
fi

automake --add-missing
if [ $? -ne 0 ]; then
    echo "Failed automake --add-missing"
    exit -1
fi

automake --add-missing
if [ $? -ne 0 ]; then
    echo "Failed automake --add-missing"
    exit -1
fi

mkdir $BUILD_PACKAGE_NAME
pushd $BUILD_PACKAGE_NAME

./configure
if [ $? -ne 0 ]; then
    echo "Failed ./configure"
    exit -1
fi

make
if [ $? -ne 0 ]; then
    echo "Failed make"
    exit -1
fi

popd

tar -zcvf $BUILD_PACKAGE_NAME.tgz $BUILD_PACKAGE_NAME
