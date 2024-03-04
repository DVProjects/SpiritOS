%macro BIOScls 0
	mov ah, 0
	mov al, 3
	int 0x10
%endmacro
