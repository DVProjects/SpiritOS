#include <stdint.h>
#include "vga.h"

void kernel(void){
	uint8_t color = vga_entry_color(VGA_WHITE,VGA_BLUE);
	*(uint16_t*)0xb8000 = vga_entry('A',color);
}
