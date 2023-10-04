IVTgetKey:
	mov ah, 0x00
	int 0x16
	mov ah, 0x0e
	int 0x10
	ret

IVTgetString:
	;affected Regs: ax, cx di (contains string buffer)
	mov ah, 0x00
        int 0x16
        mov ah, 0x0e
	cmp al, 0x0D
	je .end
        int 0x10
	cmp al, 0x08 ; check for backspace
	je .backspaceControl
	mov [di], al
	inc di
	inc cx
	jmp IVTgetString
	.backspaceControl:
	dec di
	dec cx
	mov al, 0x20 ; space character
	int 0x10
	mov al, 0x08
	int 0x10
	mov byte [di], 0x0
	jmp IVTgetString
	.end:
	mov al, 0x0A
	int 0x10
	mov al, 0x0D
	int 0x10
	mov byte [di], 0x00
        ret
