data segment
    greet db 'Hello World!', 10, '$'
data ends

code segment
assume  ds:data, cs:code
start:  mov ax, data
        mov ds, ax
        mov dx, offset greet

        mov ah, 9
        int 21h

        mov ah, 4ch
        int 21h

code ends
        end start