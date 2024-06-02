#include "vga.h"
#include <stdio.h>

FILE *stdout;

void stdout_init(void){
        stdout->_write_ptr = (char*)VGA_MEMORY;
        stdout->_write_base = (char*)VGA_MEMORY;
        stdout->_bufsize = VGA_WIDTH * 2;
        stdout->_buftype = _IOLBF;
}
