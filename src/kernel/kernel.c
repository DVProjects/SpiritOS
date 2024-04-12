#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include "vga.h"
#include "tty.h"
#include "heap.h"

void kernel(void){
	int* test;
	terminal_init();
	terminal_writestring("The terminal works...\n");
	heap_init();
	terminal_writestring("Loaded the heap\n");
	test = malloc(sizeof(int)*3);
	test[0] = 1;
	test[1] = 2;
	test[2] = 3;
	terminal_putchar('0' + test[0]);
	terminal_putchar('0' + test[1]);
	terminal_putchar('0' + test[2]);
	terminal_writestring("...Malloc is working!");
	free(test);

}
