nasm -f macho64 ./lib/libmincaml.s

function run_asm_test() {
  nasm -f macho64 -o ./tmp/$1.o ./CompilerTests/asm/$1.s
  ld -macosx_version_min 10.7.0 -o ./tmp/$1 -lc ./lib/libmincaml.o ./tmp/$1.o
  OUTPUT=$(./tmp/$1)
  if [ $OUTPUT = $2 ]; then
   echo "[PASS] CompilerTests/asm/$1"
  else
   echo "[FAIL] $1, expected: $2, got: $OUTPUT"
  fi
}

run_asm_test "call_print_int" 2234
