testA20:
	push ds
	push es
	push si
	cli
 
	xor ax, ax
	mov es, ax
 
	not ax
	mov ds, ax
 
	mov di, 0x0500
	mov si, 0x0510
 
	mov al, BYTE [es:di]
	push ax
 
	mov al, BYTE [ds:si]
	push ax
 
	mov BYTE [es:di], 0x00
	mov BYTE [ds:si], 0xFF
 
	cmp BYTE [es:di], 0xFF
 
	pop ax
	mov BYTE [ds:si], al
 
	pop ax
	mov BYTE [es:di], al
 
	mov ax, 0
	je .end
 
	mov ax, 1
 
	.end:
	    pop si
	    pop es
	    pop ds
 
	ret
