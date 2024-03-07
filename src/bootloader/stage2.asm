%include "testA20.inc"
%include "BIOSenableA20.inc"

stage2:
	mov si, BOOT_STAGE2
	call BIOSprintS
	call checkA20	;call A20 activation protocol
	call BIOSprintS
	hlt

checkA20:
	mov si, A20_ACTIVE	;check if active by system default
	call testA20
	cmp ax, 0x1
	je .end

	call BIOSenableA20	;try activating using BIOS
	call testA20
	cmp ax, 0x1
	je .end
	
	mov si, A20_DISABLED
	.end:
		ret

BOOT_STAGE2:db "Loaded 2nd stage...",0xD,0xA,0
A20_ACTIVE:db "A20 line activated...",0xD,0xA,0
A20_DISABLED:db "A20 line is not activated...",0xD,0xA,0

times 512 db 0
