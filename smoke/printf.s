global start

extern _printf
extern print_int

section .data
hello: db 'hello, world %d', 10, 0

section .text
start:
sub rsp, 16
mov rdi, 2234
call print_int
add rsp, 16
mov rax, 1
add rax, 0x2000000
xor rdi, rdi
syscall
