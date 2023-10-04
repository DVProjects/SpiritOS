[org 0x7c00]

main16:

mov ah, 0x0
call IVTclear

mov si, bootConfirm
call IVTprintString
call diskLoad

;extern files
%include "IVTprint.asm"
%include "IVTclear.asm"
%include "disk.asm"

;strings
bootConfirm: db "Bootsector: successfully entered 16 bit real mode",0xA, 0xD, 0

;fill bootsector with 0s
times 510-($-$$) db 0
;magic num 
dw 0xaa55
