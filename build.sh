export NDK=/mnt/tmpbuild/android-ndk-r27c
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
export TARGET=aarch64-linux-android
export API=24

export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export STATIC_BUILD=1
epxort NO_PYTHON=1
make \
  AR=$AR \
  CC=$CC \
  AS=$AS \
  CXX=$CXX \
  LD=$LD \
  RANLIB=$RANLIB \
  STRIP=$STRIP \
  CFLAGS="-Wall -ffunction-sections -fdata-sections -static" \
  LDFLAGS="-Wl,--gc-sections -Wl,-z,max-page-size=4096" \
  -j$(nproc) \
  $1
