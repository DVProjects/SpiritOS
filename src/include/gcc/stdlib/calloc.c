#include <stdlib.h>
#include <stddef.h>
#include "heap.h"

void *calloc(size_t nitems, size_t size){
	void *ret = (void*)HEAP_DATA+heap_add_entry(size);
	for (size_t i = 1; i < nitems; i++){	//This is ok for now
		heap_add_entry(size);
	}
	return ret;
}
