BIOSprintS:
	push ax
	mov ah, 0x0e
	.loop:
		lodsb
		test al, al
		je .end
		int 0x10
		jmp .loop
	.end:
		pop ax
		ret
