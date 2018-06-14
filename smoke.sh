nasm -f macho64 ./smoke/printf.s
ld -macosx_version_min 10.7.0 -o ./smoke/printf ./smoke/printf.o -lc
./smoke/printf
