## Requirements
A [custom build](https://github.com/jxcore/jxcore/blob/master/doc/Android_Compile.md) of jxcore is required. 
[Android NDK](https://developer.android.com/ndk/downloads/index.html#download)
[jxcore](https://github.com/jxcore/jxcore.git)


    git clone https://github.com/jxcore/jxcore.git
    cd jxcore
    git submodule init && git submodule update
    build_scripts/android-configure.sh ~/android-ndk-r10e/
    build_scripts/android_compile.sh ~/android-ndk-r10e/ --embed-leveldown

Then we need to update the jxcore binaries to include leveldown

