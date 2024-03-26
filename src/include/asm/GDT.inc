GDT:
.empty:
	dd 0
	dd 0		; 8 empty bytes

.code_limit_low:	; start of code segment descriptor
	dw 0xffff	; limit_low 2 bytes
	dw 0		; 2 bytes +
	db 0		; 1 byte  : base_low 24 bits
	db 0b10011010
	; .present ..ring .type .code .conforming .readable .access

.code_limit_high:
	db 0b11000000
	; .gralunarity .32 bit .64 bit .AVL ....limit_high
	db 0; base_high
	
.data_limit_low:	; start of data segment descriptor
	dw 0xffff	; limit_low 2 bytes
	dw 0		; 2 bytes +
	db 0		; 1 byte  : base_low 24 bits
	db 0b10010010
	;  .present ..ring .type .code .direction .writable .access
	
.data_limit_high:
	db 0b1100000
	;  .gralunarity .32 bit .64 bit .AVL ....limit_high
	db 0		; base_high
	
.end:

GDTdescriptor:
	dw GDT.end - GDT -1	;size
	dd GDT			;start

CODE_SEG equ GDT.code_limit_low - GDT
DATA_SEG equ GDT.data_limit_low - GDT
