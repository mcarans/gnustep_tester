set -eo pipefail

pacboy -S --noconfirm autotools
pacboy -R --noconfirm gcc-objc || true

git clone https://github.com/gnustep/tools-make.git
cd tools-make
mkdir build
cd build

export CC="clang"
export CXX="clang++"
export CFLAGS="$CFLAGS -DSTRICT_APPLE_COMPATIBILITY=1"
export LDFLAGS="$LDFLAGS -fuse-ld=lld -lstdc++ -lgcc_s"


../configure \
--with-library-combo=ng-gnu-gnu \
--with-runtime-abi=gnustep-2.2 \
--prefix="/ucrt64" \
--build="x86_64-w64-mingw32" \
--host="x86_64-w64-mingw32" \
--target="x86_64-w64-mingw32"

make
make install
