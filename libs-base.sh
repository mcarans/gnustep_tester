set -eo pipefail

pacboy -S --noconfirm icu libxslt

git clone https://github.com/gnustep/libs-base.git
cd libs-base

ls "$(gnustep-config --variable=GNUSTEP_MAKEFILES)/GNUstep.sh"
. "$(gnustep-config --variable=GNUSTEP_MAKEFILES)/GNUstep.sh"

./configure --prefix="${MINGW_PREFIX}"
make
make check
