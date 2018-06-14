extern _printf
global start
section .data
hello: db 'hello, world', 10
section .text
start:
sub rsp, 16
mov rdi, hello
call _printf
add rsp, 16
mov rax, 1
add rax, 0x2000000
xor rdi, rdi
syscall

