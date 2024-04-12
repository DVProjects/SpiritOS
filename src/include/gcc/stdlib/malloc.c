#include <stdlib.h>
#include "heap.h"

void* malloc(size_t size){
	return (void*)HEAP_DATA+heap_add_entry(size);
}
