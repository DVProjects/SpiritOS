#include <stdint.h>
#include <string.h>
#include "vga.h"
#include "tty.h"

void kernel(void){
	terminal_init();
	terminal_writestring("Hello world\n");
	terminal_writestring("Line 2\n");
}
