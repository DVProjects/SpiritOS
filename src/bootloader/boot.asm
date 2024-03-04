[bits 16]
[org 0x7c00]

jmp main16

%include "BIOScls.inc"

main16:
	BIOScls
	hlt

times 510-($-$$) db 0
dw 0xaa55
