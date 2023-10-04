start:
mov ax, 0
mov bx, ax
mov cx, ax
mov dx, ax
mov si, ax

call IVTclear

; Change color/Palette
mov ah, 0x0B
mov bh, 0x00
mov bl, 0x01
int 0x10

mov si, welcome
call IVTprintString
.terminalLoop:
mov al, 0x00
mov si, username
call IVTprintString
mov cx, 0x00
mov di, command
call IVTgetString

;commands check goes here
;mov di, command
;mov si, reboot
;call stringCompare
;je start
call commandsCheck

;keep as last
call wrongCommand
call end.commandClear
jmp .terminalLoop


end:
jmp $

.commandClear:
mov di, command
ret

wrongCommand:
mov si, command
mov al, '"'
int 0x10
call IVTprintString
mov al, '"'
int 0x10
mov si, unfoundCommand
call IVTprintString
ret

%include "IVTprint.asm"
%include "IVTclear.asm"
%include "IVTinput.asm"
%include "IVTfileBrowser.asm"
%include "string.asm"
%include "commandsList.asm"

unfoundCommand: db " command not found", 0x0A, 0x0D, 0
welcome: db "Welcome to SpiritOS",0x0A, 0x0D, 0
username: db "<User>",0
command: db '',0
