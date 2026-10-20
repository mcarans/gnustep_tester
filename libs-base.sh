set -eo pipefail

pacboy -S --noconfirm icu libxslt

git clone https://github.com/gnustep/libs-base.git
cd libs-base

. "${MINGW_PREFIX}/share/GNUstep/Makefiles/GNUstep.sh"

./configure --prefix="${MINGW_PREFIX}"
make

make check || true
find . -name "NSString.exe"
pacboy -S --noconfirm gdb ntldd
cd Tests/base/headers/obj/
ntldd -R NSString.exe
gdb -ex "run" -ex "bt" -ex "quit" --args ./NSString.exe

