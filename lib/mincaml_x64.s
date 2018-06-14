extern _printf

global print_int

section .data
int_fmt: db '%d', 10, 0
float_fmt: db '%f', 10, 0

section .text
print_int:
push rbp
mov rbp, rsp
sub rsp, 16
mov rsi, rdi
mov rdi, int_fmt
call _printf
add rsp, 16
mov rax, 0
leave
ret

