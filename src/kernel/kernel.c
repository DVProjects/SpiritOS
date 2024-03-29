#include <stdint.h>
#include <string.h>
#include "vga.h"

void kernel(void){
	const char* str = "Hello world";
	uint8_t color = vga_entry_color(VGA_WHITE,VGA_BLUE);
	for (int i = 0;i<strlen(str);i++){
		*(uint16_t*)(0xb8000+i*2) = vga_entry(str[i],color);
	}
}
