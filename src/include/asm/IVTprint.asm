IVTprintString:
;		pusha
;		mov ah, 0x0e
;		mov bh, 0x00
;		mov bl, 0x07
;		.loop:
;		lodsb
;		cmp al, 0
;		je .end
;		int 0x10
;		jmp .loop
;	.end:
;		popa
;		ret
    pusha                       ; store all registers onto stack
    mov ah, 0x0e                ; int 10h/ ah 0x0e BIOS teletype output
    mov bl, 0x07                ; color
	jmp IVTprintChar

.end:
    popa                        ; restroe all registers from stack
    ret

IVTprintChar:
    lodsb                       ; move byte at si into al
    cmp al, 0
    je IVTprintString.end                ; jump if equal (al = 0) to halt label
    int 0x10                    ; print character in al
    jmp IVTprintChar              ; loop


IVTprintRegs:
	mov dx, 0x1234
    call IVTprintHex          ; print dx
	mov al, 0x0D
	int 0x10
	mov al, 0x0A
	int 0x10

    ret

IVTprintHex:
	pusha
	xor cx, cx
hexLoop:
	cmp cx, 4 ;check if at end
	je endHexLoop

	mov ax, dx
	and ax, 0x000F ;first 3 (hex) digits set to 0
	add al, 0x30
	cmp al, 0x39
	jle .moveInBX
	add al, 0x07

.moveInBX:
	mov bx, baseHexString + 5
	sub bx, cx
	mov [bx], al
	ror dx, 4

	inc cx
	jmp hexLoop

endHexLoop:
	mov bx, baseHexString
	call IVTprintString
	popa
	ret

baseHexString: db "0x0000",0
regString: db 0xA,0xD,'dx         ',0 ; hold string of current register

