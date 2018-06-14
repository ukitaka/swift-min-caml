nasm -f macho64 ./smoke/printf.s
nasm -f macho64 ./lib/mincaml_x64.s
ld -macosx_version_min 10.7.0 -o ./smoke/printf -lc ./lib/mincaml_x64.o ./smoke/printf.o
./smoke/printf
