; Chester Ken Gallego
; nasm -f elf mult.asm && gcc -m32 -no-pie -o mult main.c mult.o asm_io.o && ./mult

%include "asm_io.inc"

segment .data
    tab db 9

segment .text
    global mult
mult:
    enter 8,0               ; create stack frame with 8 bytes for local variables
    pusha                   ; save registers

    mov ebx, [ebp+8]        ; ebx = n
    mov dword [ebp-4], 1    ; i = 1

for_loop1:
    cmp [ebp-4], ebx        ; i <= n
    jnle end_for1           ; if not, end for_loop1
    mov dword [ebp-8], 1    ; j = 1

for_loop2:
    cmp [ebp-8], ebx        ; j <= n
    jnle end_for2           ; if not, end for_loop2
    mov eax, tab
    call print_string       ; print tab
    mov eax, [ebp-4]        ; eax = i
    imul eax, [ebp-8]       ; eax = i * j
    call print_int          ; print i * j
    inc dword [ebp-8]       ; j++
    jmp for_loop2           ; repeat for loop

end_for2:
    call print_nl           ; print new line
    inc dword [ebp-4]       ; i++
    jmp for_loop1           ; repeat for loop

end_for1:
    popa                    ; restore registers
    leave                   ; restore stack frame
    ret                     ; jump back to caller
