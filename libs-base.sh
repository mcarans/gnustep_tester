set -euo pipefail

pacboy -S --noconfirm curl gnutls icu libffi libiconv libxml2 libxslt zlib

git clone https://github.com/gnustep/libs-base.git
cd libs-base
mkdir build
cd build

export CC="clang"
export CXX="clang++"

../configure --prefix="/ucrt64"
make
make check
