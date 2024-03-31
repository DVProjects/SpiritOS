#ifndef TTY_H
#define TTY_H
 
#include <stddef.h>
#include <stdint.h>
 
void terminal_init(void);
void terminal_setcolor(uint8_t);
void terminal_putchar(char c);
void terminal_write(const char* data, size_t size);
void terminal_writestring(const char* data);
 
#endif
