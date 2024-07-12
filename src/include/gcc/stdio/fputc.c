#include <stdio.h>
#include "vga.h"
#include "tty.h"

int fputc(int c, FILE* stream){
	// this is important when writing to vga screen
	if (stream == stdout){
    switch (c) {
		case '\n':// TODO: add terminal_scroll
			stream->_write_base += stream->_bufsize;
		case '\r':
			stream->_write_ptr = stream->_write_base;
			break;
		default:
      *stream->_write_ptr = c;
	    stream->_write_ptr++;
      *stream->_write_ptr = terminal_color;
      stream->_write_ptr++;
	  }
  } else {
    *stream->_write_ptr = c;
	  stream->_write_ptr++;
    if (stream->_buftype == _IONBF || stream->_buftype == _IOLBF && c == '\n' ||
      stream->_write_ptr - stream->_write_base == stream->_bufsize)
      fflush(stream);
  }
	return c;
}
