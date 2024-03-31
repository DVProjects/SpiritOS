#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include "vga.h"
#include "tty.h"

void kernel(void){
	terminal_init();
	terminal_writestring("Hello world!");
	terminal_setcolor(vga_entry_color(VGA_RED,VGA_GREEN));
	terminal_writestring("Nice colors!");
}
