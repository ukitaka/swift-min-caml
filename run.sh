swift build &> /dev/null
swift run > ./tmp/main.s
nasm -f macho64 ./tmp/main.s
nasm -f macho64 ./lib/libmincaml.s
ld -macosx_version_min 10.7.0 -o ./tmp/main  ./lib/libmincaml.o ./tmp/main.o -lc
./tmp/main
