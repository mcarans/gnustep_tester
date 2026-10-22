set -eo pipefail

pacboy -S --noconfirm cc-libs gnutls icu libffi libiconv libxml2 libxslt zlib

git clone https://github.com/gnustep/libs-base.git
cd libs-base

. "${MINGW_PREFIX}/share/GNUstep/Makefiles/GNUstep.sh"

export PATH="${MINGW_PREFIX}/opt/llvm22/bin:${PATH}"
./configure --prefix="${MINGW_PREFIX}"
make
make install
make check || true

pacboy -S --noconfirm gdb ntldd
cd Tests/base/GSXML/obj/
ntldd -R basic.exe
gdb -ex "run" -ex "bt" -ex "quit" --args ./basic.exe

