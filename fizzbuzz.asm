section .data
    fizz    db   "Fizz"
    buzz    db   "Buzz"
    newline db   0xA
    max_num db   100
    err_msg db   "Please enter a number 0-9."
    ascii_zero db 0x30
    ascii_nine db 0x39

section .text
    global _start



_start:
    push    rbp
    mov     rbp, rsp

    mov     rax, 1 
    mov     rcx, 1
    mov     rdx, 1
    call    for_loop

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall



for_loop:
    push    rbp
    mov     rbp, rsp

loop_start:
    mov     rbx, 100
    cmp     rax, rbx
    je      for_loop_exit
    cmp     rcx, 3
    jne     check_5
    push    rax
    push    rcx
    push    rdx
    call    print_fizz
    pop     rdx
    pop     rcx
    pop     rax

check_5:
    cmp     rdx, 5
    jne     new_line
    push    rax
    push    rcx
    push    rdx
    call    print_buzz
    pop     rdx
    pop     rcx
    pop     rax

new_line:
    push    rax
    push    rcx
    push    rdx
    call    print_newline
    pop     rdx
    pop     rcx
    pop     rax
    inc     rax
    inc     rcx
    inc     rdx
    cmp     rcx, 4
    jne     check_rdx
    mov     rcx, 1

check_rdx:
    cmp     rdx, 6
    jne     continue_loop
    mov     rdx, 1

continue_loop:
    jmp     loop_start


for_loop_exit:
    leave
    ret



print_fizz:
    push    rbp
    mov     rbp, rsp
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, fizz
    mov     rdx, 4
    syscall
    leave
    ret



print_buzz:
    push    rbp
    mov     rbp, rsp
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, buzz
    mov     rdx, 4
    syscall
    leave
    ret



print_newline:
    push    rbp
    mov     rbp, rsp
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, newline
    mov     rdx, 1
    syscall
    leave
    ret

print_invalid_input:
    push    rbp
    mov     rbp, rsp
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, err_msg
    mov     rdx, 26
    syscall
    leave
    ret
