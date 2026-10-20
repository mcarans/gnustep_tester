set -eo pipefail

pacman -Syu --noconfirm
pacman -S --noconfirm git pactoys
pacboy -S --noconfirm cc-libs clang cmake lld libblocksruntime-swift robin-map

git clone https://github.com/gnustep/libobjc2.git
cd libobjc2
mkdir build
cd build

extra_config+=("-DCMAKE_BUILD_TYPE=RelWithDebInfo")
export LDFLAGS="$LDFLAGS -fuse-ld=lld -lstdc++ -lgcc_s"

cmake \
    -GNinja \
    -DCMAKE_INSTALL_PREFIX="${MINGW_PREFIX}" \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DCMAKE_C_COMPILER="clang" \
    -DCMAKE_CXX_COMPILER="clang++" \
    -DOLDABI_COMPAT=OFF \
    -DSTRICT_APPLE_COMPATIBILITY=ON \
    -DCMAKE_DLL_NAME_WITH_SOVERSION=ON \
    -DTESTS=ON \
    "${extra_config[@]}" \
    ..

cmake --build .
ctest -j 4 --output-on-failure -T test
cmake --install .
