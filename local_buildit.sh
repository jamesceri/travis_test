#!/bin/bash

# sudo apt update -qq
# sudo apt install -y -qq git
export BUILD_RELEASE_VERSION=`git describe --tags`
export BUILD_PACKAGE_NAME=helloworld-$BUILD_RELEASE_VERSION
export BUILD_PACKAGE_NAME_TGZ=$BUILD_PACKAGE_NAME.tgz

source "./buildit.sh"

rm -rf hello*.tgz
