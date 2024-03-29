#include "string.h"

size_t strlen(const char* str){
	size_t len;
	for (;str[len];len++);
	return len;
}
