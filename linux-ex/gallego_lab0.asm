; Chester Ken Gallego

%include "asm_io.inc"

; Initialized data
segment .data
    prompt1 db 'Enter the value of foo: ', 0
    prompt2 db 'Enter the value of bar: ', 0
    outmsg1 db 'The value of foo is ', 0
    outmsg2 db 'The value of bar is ', 0
    outmsg3 db '=== After the swapping ===', 0

; Uninitialized data
segment .bss
    input1 resd 1
    input2 resd 1

; Code
segment .text
    global asm_main
asm_main:
    ; Setup
    enter 0,0
    pusha

    ; Ask the user for the value of foo
    mov eax, prompt1
    call print_string
    call read_int
    mov [input1], eax

    ; Ask the user for the value of bar
    mov eax, prompt2
    call print_string
    call read_int
    mov [input2], eax

    ; Display the value of foo
    mov eax, outmsg1
    call print_string
    mov eax, [input1]
    call print_int
    call print_nl

    ; Display the value of bar
    mov eax, outmsg2
    call print_string
    mov eax, [input2]
    call print_int
    call print_nl

    ; Swap the values of foo and bar
    mov eax, [input1]
    mov ebx, [input2]
    mov [input1], ebx
    mov [input2], eax

    ; Display the after the swapping message
    mov eax, outmsg3
    call print_string
    call print_nl

    ; Display the value of foo
    mov eax, outmsg1
    call print_string
    mov eax, [input1]
    call print_int
    call print_nl

    ; Display the value of bar
    mov eax, outmsg2
    call print_string
    mov eax, [input2]
    call print_int
    call print_nl

    ; Cleanup
    popa
    mov eax,0
    leave
    ret
