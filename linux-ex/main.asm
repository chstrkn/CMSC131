; Chester Ken Gallego
; nasm -f elf main.asm && nasm -f elf factorial.asm && gcc -m32 -o main driver.c main.o factorial.o asm_io.o -no-pie && ./main

%include "asm_io.inc"

segment .data
    output db "! = ", 0

segment .bss
    n resd 1

segment .text
    global asm_main
    extern get_int, factorial
asm_main:
    enter 0,0           ; setup routine
    pusha               ; save registers

    call get_int        ; promt user to enter a number
    mov [n], eax        ; store the number in n

    call print_int      ; print the number entered
    mov eax, output     ; print the output string
    call print_string

    mov eax, [n]
    push eax            ; push the number to the stack
    call factorial      ; call the factorial function
    call print_int      ; print the result
    pop eax             ; restore eax

    call print_nl       ; print a new line

    popa                ; restore registers
    mov eax, 0          ; return back to C
    leave               ; restore stack frame
    ret
