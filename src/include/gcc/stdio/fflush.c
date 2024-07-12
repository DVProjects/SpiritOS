#include <stdio.h>

int fflush(FILE *stream){
  stream->_write_ptr = stream->_write_base;
  stream->_read_ptr = stream->_read_base;
}
