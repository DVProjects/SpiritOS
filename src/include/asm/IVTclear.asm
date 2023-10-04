IVTclear:
	pusha
	mov al, 0x03
	int 0x10
	popa
	ret
