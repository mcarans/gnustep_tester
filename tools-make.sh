set -eo pipefail

pacboy -S --noconfirm autotools clang22 lld22

git clone https://github.com/gnustep/tools-make.git
cd tools-make
mkdir build
cd build

export CC="clang"
export CXX="clang++"
export CFLAGS="$CFLAGS -g -DSTRICT_APPLE_COMPATIBILITY=1"
export CXXFLAGS="$CXXFLAGS -g"
export LDFLAGS="$LDFLAGS -fuse-ld=lld -lstdc++ -lgcc_s"
export PATH="${MINGW_PREFIX}/opt/llvm22/bin:${PATH}"

../configure \
--with-library-combo=ng-gnu-gnu \
--with-runtime-abi=gnustep-2.2 \
--with-libdir="${MINGW_PREFIX}" \
--prefix="${MINGW_PREFIX}" \
--build="${MINGW_CHOST}" \
--host="${MINGW_CHOST}" \
--target="${MINGW_CHOST}"

make
make install
