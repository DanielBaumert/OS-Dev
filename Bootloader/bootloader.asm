[bits 16] ;bootloader bit deepness 
[ORG 0x7c00] ;
; Define constans
startaddr EQU  0a000h  ;start of video memory  
start:
    ; change video mode in vga 320x200x256
    mov AH, 0
	mov AL, 13h
	int 10h
    ; load video segment
    mov ax, startaddr   ; video memory address
    mov es, ax          ; load memory address to segment 
    ; put pixel
    mov ax, 320         ; row width
    mov bx, 5h          ; load y offset
    mul bx              ; y offset (5) =>  320 * 5 => pixel 1600  
    add ax, 1           ; x offset (5) => 1600 + 5 => pxiel 1605
    mov di, ax          ; es + destination (di)
    ; init pixel color
    mov al, 0           ; load color
    mov [es:di], al     ; es:[di] -> ptr to destination 
                        ; es + di and from there the ptr
    
end:
    mov AH, 004ch
    int 21h


;fill up to 512byte - AA55
times 510-($-$$) db 0
dw 0xAA55