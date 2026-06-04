section .multiboot
align 4
multiboot_header:
    dd 0x1BADB002              
    dd 0x00000003               
    dd -(0x1BADB002 + 0x00000003) 

section .text
global _start
_start:
    mov esp, stack_top
    push eax                     
    push ebx                     
    extern kernel_main
    call kernel_main
.hang:
    cli
    hlt
    jmp .hang

section .bss
align 16
stack_bottom:
    resb 16384                  
stack_top:

section .note.GNU-stack noalloc noexec nowrite progbits
