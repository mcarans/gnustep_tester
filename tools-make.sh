set -eo pipefail

pacboy -S --noconfirm autotools

git clone https://github.com/gnustep/tools-make.git
cd tools-make
mkdir build
cd build

export CC="clang"
export CXX="clang++"
export CFLAGS="$CFLAGS -DSTRICT_APPLE_COMPATIBILITY=1 -mllvm -enable-dfa-jump-thread=false"
export LDFLAGS="$LDFLAGS -fuse-ld=lld -lstdc++ -lgcc_s"

export CXXFLAGS="$CXXFLAGS -mllvm -enable-dfa-jump-thread=false"

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
