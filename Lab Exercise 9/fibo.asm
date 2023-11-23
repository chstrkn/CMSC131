; Chester Ken Gallego
; nasm -f elf fibo.asm && gcc -m32 -no-pie -o fibo main.c fibo.o asm_io.o && ./fibo

%include "asm_io.inc"

segment .text
    global fibonacci
fibonacci:
    enter 4,0               ; create stack frame with 4 bytes for local variables
    pusha                   ; save registers
    mov ecx, [ebp+8]        ; n
    mov eax, 0              ; a = 0
    mov dword [ebp-4], 1    ; b = 1

loop_start:
    call print_int          ; print a
    call print_nl           ; print a new line
    mov edx, [ebp-4]        ; c = b
    add [ebp-4], eax        ; b = a + b
    mov eax, edx            ; a = c
    loop loop_start         ; decrement n and loop until n = 0

end:
    popa                    ; restore registers
    mov eax, 0              ; return back to C
    leave                   ; restore stack frame
    ret
