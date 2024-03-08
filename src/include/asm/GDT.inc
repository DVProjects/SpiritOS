GDT:
	.empty:
		dd 0
		dd 0		; 8 empty bytes
	.code:
		dw 0xffff	; limit_high 2 bytes
		dw 0		; 2 bytes +
		db 0		; 1 byte  : base_high 24 bits
		db 0b10011010
		; .present ..ring .type .code .conforming .readable .access
		db 0b11001111
		; .gralunarity .32 bit .64 bit .AVL ....limit_low
		db 0; base_low
	
	.data:
		dw 0xffff	; limit_high 2 bytes
		dw 0		; 2 bytes +
		db 0		; 1 byte  : base_high 24 bits
		db 0b10010010
		;  .present ..ring .type .code .direction .writable .access
		db 0b11001111
		;  .gralunarity .32 bit .64 bit .AVL ....limit_low
		db 0		; base_low
	
.end:

GDTdescriptor:
	dw GDT.end - GDT -1	;size
	dd GDT			;start

CODE_SEG equ GDT.code - GDT
DATA_SEG equ GDT.data - GDT
