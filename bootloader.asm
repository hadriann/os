; CPU is working in real mode (16-bit)
BITS 16

; Specify the RAM address where BIOS loads the bootloader
ORG 0x7C00

jmp main

msg db "Booting the operating system...", 0

; Routine to print 'si' contents
print:
    xor dx, dx
    xor bx, bx
    
    ; Set foreground color to 14
    mov bl, 14 
    mov cx, 1
    cld

    .repeat:
        ; Advance cursor
        mov ah, 0x02
        int 0x10

        ; Fetch character
	    lodsb

        cmp al, 0
	    je .done
        mov ah, 0x09
	    int 0x10
        inc dl
	    jmp .repeat

    .done:
	    ret

setVideoMode:
    mov ah, 0
    mov al, 0x02
    int 0x10
    ret

hideCursor:
    mov ah, 0x01
    mov cx, 0x2607
    int 0x10
    ret

main:
    ; Clean up segments
    xor ax, ax
    mov ds, ax
    mov es, ax

    call setVideoMode
    call hideCursor

    mov si, msg
    call print

    jmp $

; Fill out with zeros all remaining bytes up to offset 510
times 510-($-$$) db 0

; Make the sector bootable with the boot signature in the last 2 bytes
dw 0xAA55
