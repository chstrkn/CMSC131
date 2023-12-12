; Chester Ken Gallego
; nasm -f elf gallego_lab11.asm && gcc -m32 -no-pie -o gallego_lab11 driver.c gallego_lab11.o asm_io.o && ./gallego_lab11

%include "asm_io.inc"

%define SYS_READ 3
%define SYS_WRITE 4
%define STDIN 0
%define STDOUT 1

%define MAX_LENGTH 1000
%define MAX_ASCII 256

segment .data
    line db "-------------------------------------------------", 0
    title db " Find the maximum occuring character in a string", 0
    prompt db "Enter a string: ", 0
    output db "The highest frequency character '%c' appears %d times.", 0

segment .bss
    string resb MAX_LENGTH
    frequencies resb MAX_ASCII

segment .text
    extern printf
    global asm_main
asm_main:
    enter 0,0                           ; setup routine
    pusha                               ; save registers

    mov eax, line
    call print_string                   ; print a horizontal line
    call print_nl
    mov eax, title
    call print_string                   ; print title
    call print_nl
    mov eax, line
    call print_string                   ; print a horizontal line
    call print_nl

    mov eax, SYS_WRITE                  ; system call for write
    mov ebx, STDOUT                     ; file descriptor
    mov ecx, prompt                     ; prompt string
    mov edx, 16                         ; length of prompt
    int 80h                             ; call kernel

    mov eax, SYS_READ                   ; system call for read
    mov ebx, STDIN                      ; file descriptor
    mov ecx, string                     ; address to store string
    mov edx, MAX_LENGTH                 ; maximum length of string
    int 80h                             ; call kernel

process_string:
    movzx eax, byte [ecx]               ; get current character in string

    cmp eax, 10                         ; check if character is newline
    je end_process                      ; end process if newline

    inc byte [frequencies + eax]        ; increment frequency of current character

    inc ecx                             ; increment string pointer
    jmp process_string                  ; process next character

end_process:
    xor eax, eax                        ; clear eax
    xor edx, edx                        ; set max frequency to 0
    mov esi, 0                          ; index of current character

max_frequency:
    cmp esi, MAX_ASCII                  ; check if end of frequencies array
    je print_result                     ; print result if end of frequencies array

    mov al, byte [frequencies + esi]    ; get current frequency
    cmp al, byte [frequencies + edx]    ; compare current frequency with max frequency
    jl next_frequency                   ; process next frequency if current frequency is less than max frequency

    mov edx, esi                        ; set max frequency to current frequency

next_frequency:
    inc esi                             ; increment string pointer
    jmp max_frequency                   ; process next frequency

print_result:
    mov al, byte [frequencies + edx]    ; get max frequency

    push eax                            ; push max frequency
    push edx                            ; push max character
    push output                         ; push output string
    call printf                         ; print output string
    add esp, 12                         ; clear stack

    call print_nl                       ; print a newline

    popa                                ; restore registers
    mov eax, 0                          ; return back to C
    leave                               ; restore stack frame
    ret
