set -eo pipefail

pacboy -S --noconfirm icu libxslt

git clone https://github.com/gnustep/libs-base.git
cd libs-base
mkdir build
cd build

. "$(gnustep-config --variable=GNUSTEP_MAKEFILES)/gnustep.sh"

../configure --prefix="${MINGW_PREFIX}"
make
make check
