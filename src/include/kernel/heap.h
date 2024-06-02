#ifndef HEAP_H
#define HEAP_H 1

#define HEAP_DATA 0x10000
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

struct heap_entry {
	size_t offset;
	size_t size;
};

extern struct heap_entry heap_tail;
extern struct heap_entry heap_table[256];
extern int heap_counter;

void heap_init(void);
size_t heap_add_entry(size_t);
bool heap_delete_entry(size_t);

#endif 
