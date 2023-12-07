; Chester Ken Gallego
; nasm -f elf searchArray.asm && gcc -m32 -no-pie -o searchArray array1c.c searchArray.o && ./searchArray

section .data
    prompt1 db "Enter array size: ", 0
    prompt2 db "Enter value @ array[%d]: ", 0
    output1 db "Array contents:", 0
    prompt3 db "Enter number to be searched: ", 0
    output2 db "%d is @ array[%d]", 0
    output3 db "%d is not found in the array", 0
    nl db 10, 0
    input_format db "%d", 0
    array_format db "%d ", 0

section .bss
    array resd 100

section .text
    extern  puts, printf, scanf
    global  asm_main
asm_main:
    enter 8,0                       ; create stack frame with 8 bytes for local variables
    push ebx                        ; save registers
    push esi

enter_size:
    push prompt1
    call printf                     ; prompt user for array size
    add esp, 4

    lea eax, [ebp-4]                ; store array size at ebp-4
    push eax
    push input_format
    call scanf                      ; read the entered array size
    add esp, 8

    cmp dword [ebp-4], 0
    je end                          ; jump to end if array size is 0

    xor esi, esi                    ; initialize index to 0

enter_value:
    push esi
    push prompt2
    call printf                     ; prompt user for array value
    add esp, 8

    lea eax, [array + esi*4]        ; store array value at array[esi]
    push eax
    push input_format
    call scanf                      ; read the entered array value
    add esp, 8

    inc esi                         ; move to the next index

    cmp esi, [ebp-4]
    jl enter_value                  ; repeat if index is less than array size

print_array:
    push output1
    call puts                       ; print array contents string
    add esp, 4

    xor esi, esi                    ; initialize index to 0

print_loop:
    push dword [array + esi*4]
    push array_format
    call printf                     ; print array value at array[esi]
    add esp, 8

    inc esi                         ; move to the next index

    cmp esi, [ebp-4]
    jl print_loop                   ; repeat if index is less than array size

    push nl
    call printf                     ; print a newline
    add esp, 4

search_value:
    push prompt3
    call printf                     ; prompt user for number to be searched
    add esp, 4

    lea eax, [ebp-8]                ; store number to be searched at ebp-8
    push eax
    push input_format
    call scanf                      ; read the entered number
    add esp, 8

    xor esi, esi                    ; initialize index to 0

search_loop:
    mov eax, [ebp-8]                ; store number to be searched at eax
    cmp dword [array + esi*4], eax  ; compare number to be searched with array[esi]
    je found                        ; jump to found if number is found

    inc esi                         ; move to the next index

    cmp esi, [ebp-4]
    jl search_loop                  ; repeat if index is less than array size

not_found:
    push dword [ebp-8]
    push output3
    call printf                     ; print number to be searched and not found message
    add esp, 8

    jmp end

found:
    push esi
    push dword [ebp-8]
    push output2
    call printf                     ; print number to be searched and its index
    add esp, 12

end:
    push nl
    call printf                     ; print a newline
    add esp, 4

    pop esi                         ; restore registers
    pop ebx
    mov eax, 0                      ; return back to C
    leave                           ; restore stack frame
    ret
