commandsCheck:
	mov di, command
	mov si, helpCommandString
	call stringCompare
	je helpCommand

	mov di, command
	mov si, fileCommandString
	call stringCompare
	je fileCommand

	mov di, command
	mov si, rebootCommandString
	call stringCompare
	je rebootCommand

	mov di, command
	mov si, regsCommandString
	call stringCompare
	je regsCommand
	;keep at end
	.end:
	ret
	.succeded:
		jmp start.terminalLoop

fileCommand:
	call IVTfileBrowser
	jmp commandsCheck.succeded

helpCommand:
	mov si, helpCommandMenu
	call IVTprintString
	mov si, fileCommandString.info
	call IVTprintString
	mov si, testCommandString.info
	call IVTprintString
	mov si, rebootCommandString.info
	call IVTprintString
	mov si, regsCommandString.info
	call IVTprintString
	jmp commandsCheck.succeded

rebootCommand:
	jmp 0xFFFF:0x0000

regsCommand:
	pusha
;	mov si, regsCommandString.heading
;	call IVTprintString
	mov dx, 0x0000
	call IVTprintString
	popa
	jmp commandsCheck.succeded

helpCommandString:	db "help", 0
;general commands
fileCommandString:	db "file", 0
.info:			db "file: opens file browser to search through memory", 0x0A, 0x0D, 0
.heading:       db "------------         ------",0xA,0xD,\
        "File/Program         Sector", 0xA, 0xD,\
        "------------         ------",0xA, 0xD, 0
rebootCommandString:	db "reboot", 0
.info:			db "reboot:warm restart", 0x0A, 0x0D, 0
regsCommandString:	db "regs", 0
.info:			db "regs:shows values of registers", 0x0A, 0x0D, 0
.heading:        db "--------   ------------",0xA,0xD,\
        "Register   Mem Location", 0xA,0xD,\
        "--------   ------------",0xA,0xD,0
testCommandString:	db "test", 0
.info:			db "test: usually doesn't do anything usefull", 0x0A, 0x0D, 0

;help menu first strings no need to change
helpCommandMenu:	db "Available commands:", 0x0A, 0x0D, "help: prints this message", 0x0A, 0x0D, 0
