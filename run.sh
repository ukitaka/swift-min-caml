swift build &> /dev/null
swift run > ./tmp/main.s
nasm -f macho64 ./tmp/main.s
ld -macosx_version_min 10.7.0 -o ./tmp/main ./tmp/main.o
./tmp/main
