%define SYSCALL_WRITE 1
%define SYSCALL_EXIT  60
%define STDOUT_FD     1
%define MAX_NUM       100
%define LEN_FIZZ      4
%define LEN_BUZZ      4
%define LEN_NEWLINE   1

section .data
    fizz    db   "Fizz"
    buzz    db   "Buzz"
    newline db   0xA

section .text
    global _start



_start:
    push    rbp               ; set up stack frame
    mov     rbp, rsp

    mov     rax, 1            ; initialize counters to 1
    mov     rcx, 1            ; rcx counts by three
    mov     rdx, 1            ; rdx counts by five
    call    for_loop

exit:
    mov     rax, SYSCALL_EXIT ; terminate the program
    mov     rdi, 0
    syscall





for_loop:
    push    rbp               ; set up stack frame
    mov     rbp, rsp

loop_start:
    mov     rbx, MAX_NUM      ; compare current counter with max
    cmp     rax, rbx
    je      for_loop_exit     ; if equal, exit the loop

    cmp     rcx, 3            ; compare the three counter with three
    jne     check_5
    push    rax               ; if equal, save counters and print "Fizz"
    push    rcx
    push    rdx
    call    print_fizz
    pop     rdx
    pop     rcx
    pop     rax

check_5:
    cmp     rdx, 5            ; compare the five counter with five
    jne     new_line
    push    rax               ; if equal, save counters and print "Buzz"
    push    rcx
    push    rdx
    call    print_buzz
    pop     rdx
    pop     rcx
    pop     rax

new_line:
    push    rax               ; save counters and print newline
    push    rcx
    push    rdx
    call    print_newline
    pop     rdx
    pop     rcx
    pop     rax

    inc     rax               ; increment counters
    inc     rcx
    inc     rdx

check_rcx:
    cmp     rcx, 4            ; if our three counter goes above three,
    jne     check_rdx         ; then set it back to one
    mov     rcx, 1

check_rdx:
    cmp     rdx, 6            ; if our five counter goes above five,
    jne     continue_loop     ; then set it back to one
    mov     rdx, 1

continue_loop:
    jmp     loop_start


for_loop_exit:
    leave
    ret





; print_fizz()
; This function prints the string "Fizz" to stdout
print_fizz:
    push    rbp                      ; set up stack frame
    mov     rbp, rsp

    mov     rax, SYSCALL_WRITE       ; syscall number in rax
    mov     rdi, STDOUT_FD           ; file descriptor in rdi
    mov     rsi, fizz                ; ptr to buffer in rsi
    mov     rdx, LEN_FIZZ            ; number of bytes in rdx
    syscall

    leave                            ; tear down stack
    ret





; print_buzz()
; This function prints the string "Buzz" to stdout
print_buzz:
    push    rbp          ; same as print_fizz
    mov     rbp, rsp

    mov     rax, SYSCALL_WRITE
    mov     rdi, STDOUT_FD
    mov     rsi, buzz
    mov     rdx, LEN_BUZZ
    syscall

    leave
    ret





; print_newline()
; This function prints the newline character to stdtout
print_newline:
    push    rbp         ; same as print_fizz
    mov     rbp, rsp

    mov     rax, SYSCALL_WRITE
    mov     rdi, STDOUT_FD
    mov     rsi, newline
    mov     rdx, LEN_NEWLINE
    syscall

    leave
    ret

