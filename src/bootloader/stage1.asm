[bits 16]
[org 0x7c00]

mov [BOOT_DISK],dl ;saving boot disk
jmp main16

%include "BIOScls.inc"
%include "BIOSprintS.inc"

main16:
	;clearing the registers
	xor ax, ax
	mov bx, 0
	mov cx, 0
	mov dx, 0

	;stack setup
	mov bp, 0x7b00
	mov sp,bp

	BIOScls
	mov si, BOOT_STRING
	call BIOSprintS

	;load stage 2
	mov bx, 0x7e00
	mov al, 0x02		;n sectors
	mov ch, 0x00		;cylinder 0
	mov cl, 0x02		;sector 1      +1=2
	mov dh, 0x00		;head 0
	
	mov ah, 0x02
	mov dl, [BOOT_DISK]
	int 0x13
	jc main16
	jmp stage2
	hlt

BOOT_STRING:db "Booting...",0xD,0xA,0

BOOT_DISK:db 0
STAGE2_LOC:db 0

times 510-($-$$) db 0
dw 0xaa55

%include "src/bootloader/stage2.asm"
