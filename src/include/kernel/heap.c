#include <stdint.h>
#include <stdbool.h>
#include "heap.h"

struct heap_entry heap_tail;
struct heap_entry heap_table[256];
int heap_counter;

void heap_init(void){
	heap_tail.size = UINT32_MAX;
	heap_tail.offset = 0;
	heap_counter = 0;
}

size_t heap_add_entry(size_t size){
	heap_table[heap_counter].size = size;
	heap_table[heap_counter].offset = heap_tail.offset;
	heap_tail.offset += size;
	return heap_table[heap_counter++].offset;
	//TODO find a way to fill empty memory chunks 
	//instead of always making new ones
}

bool heap_delete_entry(size_t offset){
	bool found = false;
	for (size_t i = 0; i < heap_counter && !found; i++){
		if (heap_table[i].offset == offset){
			heap_table[i].offset = 0;
			heap_table[i].size = 0;
			found = true;
		}
	}
	return found;
}
