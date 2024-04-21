#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "vga.h"
#include "tty.h"
#include "heap.h"

void stdout_init(void){
	stdout->_write_ptr = (char*)VGA_MEMORY;
	stdout->_write_base = (char*)VGA_MEMORY;
	stdout->_bufsize = VGA_WIDTH * 2;
	stdout->_buftype = _IOLBF;
}

void kernel(void){
	int* test;
	terminal_init();
	stdout_init();
	printf("The terminal works...\n");
	heap_init();
	printf("%s\n","Loaded the heap");
	test = malloc(sizeof(int)*3);
	test[0] = 1;
	test[1] = 2;
	test[2] = 3;
	putchar('0' + test[0]);
	putchar('0' + test[1]);
	putchar('0' + test[2]);
	printf("...Malloc is working!");
	free(test);
}
