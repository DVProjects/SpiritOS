#include <stdlib.h>
#include <stddef.h>
#include "heap.h"

void free(void *ptr){
	size_t offset = (size_t)ptr - HEAP_DATA;
	heap_delete_entry(offset);
}
