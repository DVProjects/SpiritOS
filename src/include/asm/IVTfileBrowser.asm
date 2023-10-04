IVTfileBrowser:
pusha
mov si,fileCommandString.heading
call IVTprintString
xor cx, cx              ; reset counter for # chars in file/pgm name
mov ax, 0x1000          ; file table location
mov es, ax              ; ES = 0x1000
xor bx, bx              ; ES:BX = 0x1000:0
mov ah, 0x0e            ; get ready to print to screen
.loop:
    inc bx
    mov al, [ES:BX]
    cmp al, '}'             ; at end of filetable?
    je .end
    cmp al, '-'             ; at sector number of element?
    je .sectorNumber
    cmp al, ','             ; between table elements?
    je .nextElement
    inc cx                  ; increment counter
    int 0x10
    jmp .loop

.end:
mov al, 0x0D
int 0x10
mov al, 0x0A
int 0x10
mov ax, 0x2000
mov es, ax
popa
ret

.sectorNumber:
    cmp cx, 21
    je .loop
    mov al, ' '
    int 0x10
    inc cx
    jmp .sectorNumber

.nextElement:
    xor cx, cx              ; reset counter
    mov al, 0xA
    int 0x10
    mov al, 0xD
    int 0x10
    mov al, 0xA
    int 0x10
    mov al, 0xD
    int 0x10
    jmp .loop
