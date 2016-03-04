#!/bin/bash

npm install

export ANDROID_NDK_HOME=~/android-ndk-r10e


if [ ! -d libsodium ]; then
  git clone https://github.com/jedisct1/libsodium.git
  cd libsodium
else
  cd libsodium
  git checkout master ; git fetch origin ; git reset --hard origin/master
fi
./autogen.sh
dist-build/android-armv7-a.sh
cd ..

if [ ! -d jxcore ]; then
  git clone https://github.com/jxcore/jxcore.git
  cd jxcore
  git submodule init && git submodule update
else 
  cd jxcore
  git checkout master ; git fetch origin ; git reset --hard origin/master
  git submodule init ; git submodule update
fi

build_scripts/android-configure.sh "$ANDROID_NDK_HOME"
build_scripts/android_compile.sh "$ANDROID_NDK_HOME" --embed-leveldown
cd ..

if [ ! -d jxcore-cordova ]; then
  git clone https://github.com/jxcore/jxcore-cordova.git
  cd jxcore-cordova
else
  cd jxcore-cordova
  git checkout master ; git fetch origin ; git reset --hard origin/master
fi

if [ ! -d src/android/jxcore-binaries ]; then
  echo making directory
  mkdir -p src/android/jxcore-binaries
fi

rm -f src/android/jxcore-binaries/*
cp -f ../jxcore/out_android/android/bin/* src/android/jxcore-binaries/

cd src/android/jni

$ANDROID_NDK_HOME/ndk-build

cd ../../../../


exit 


#
# if [ "$1" != "npm" ]; then
#   echo "Usage: npm run build"
#   exit 1
# fi
#
# trap ctrl_c INT
#
# function ctrl_c() {
#   echo "** Trapped CTRL-C"
#   exit 1
# }
#
# npm install
#
# # if [ -d mobile ]; then
# # cordova create mobile org.drinkbot.patchwork patchwork
# # cd mobile
# # jxc install
# # cordova platform add android
# # cd ..
# #
#
# cd node_modules/ssb-patchwork
# export npm_config_arch=arm
# npm install
# find node_modules -name \*.gz -exec rm -f "{}" \;
# cd ../..
#
# rm -rf mobile/www
# cp -a node_modules/ssb-patchwork/ui mobile/www
#
# cp -a node_modules/ssb-patchwork mobile/www/jxcore
# rm -rf mobile/www/jxcore/ui
#
# ln -sf main.html index.html
# cd ..
#
# cordova emulate android
