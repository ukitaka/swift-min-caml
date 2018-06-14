nasm -f macho64 ./lib/libmincaml.s

function run_test() {
  nasm -f macho64 -o ./tmp/$1.o ./smoke/$1.s
  ld -macosx_version_min 10.7.0 -o ./tmp/$1 -lc ./lib/libmincaml.o ./tmp/$1.o
  OUTPUT=$(./tmp/printf)
   if [ $OUTPUT = $2 ]; then
    echo "[PASS] $1"
   else
    echo "[FAIL] $1, expected: $2, got: $OUTPUT"
   fi
}

run_test "printf" 2234
