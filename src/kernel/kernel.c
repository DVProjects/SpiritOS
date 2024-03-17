#include <stdint.h>

void kernel(void){
	*(char*)0xb8000 = 'A';
	*(char*)0xb8001 = 0x1F;
}
