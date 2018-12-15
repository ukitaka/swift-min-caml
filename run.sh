#swift build &> /dev/null
set -e
mkdir -p tmp
./.build/debug/smcc $1 > ./tmp/main.s
nasm -f macho64 ./tmp/main.s
nasm -f macho64 ./lib/libmincaml.s
ld -macosx_version_min 10.7.0 -o ./tmp/main  ./lib/libmincaml.o ./tmp/main.o -lc
./tmp/main
