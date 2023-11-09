; Chester Ken Gallego

%include "asm_io.inc"

segment .data
    prompt db "Enter a number to calculate its factorial: ", 0

segment .text
    global get_int, factorial
get_int:
    mov eax, prompt         ; promt user to enter a number
    call print_string
    call read_int
    ret                     ; jump back to caller

factorial:
    enter 4,0               ; create stack frame with 4 bytes for local variables
    push ebx                ; save ebx

    mov ebx, [ebp+8]        ; ebx = n
    mov dword [ebp-4], 1    ; c = 1
    mov eax, 1              ; r = 1

for_loop:
    cmp [ebp-4], ebx        ; check if c <= n
    jnle end_for            ; if false, exit loop

    imul eax, [ebp-4]       ; r = r * c

    inc dword [ebp-4]       ; c++;
    jmp for_loop

end_for:
    pop ebx                 ; restore ebx
    leave                   ; restore stack frame
    ret                     ; jump back to caller
