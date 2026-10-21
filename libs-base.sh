set -eo pipefail

pacboy -S --noconfirm icu libxslt

git clone https://github.com/gnustep/libs-base.git
cd libs-base

. "${MINGW_PREFIX}/share/GNUstep/Makefiles/GNUstep.sh"

./configure --prefix="${MINGW_PREFIX}"
make
make install
make check || true

pacboy -S --noconfirm gdb ntldd
cd Tests/base/GSXML/obj/
ntldd -R basic.exe
gdb -ex "run" -ex "bt" -ex "quit" --args ./basic.exe

