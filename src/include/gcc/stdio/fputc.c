#include <stdio.h>

int fputc(int c, FILE* stream){
	// this is important when writing to vga screen
	if (stream == stdout) {
		switch (c) {
			case '\n':// TODO: add terminal_scroll
				stream->_write_base += stream->_bufsize;
			case '\r':
				stream->_write_ptr = stream->_write_base;
				break;
			default:
				*stdout->_write_ptr = c;
				stream->_write_ptr+=2;
		}
	}// TODO: add support for other streams
	else stream->_write_ptr++;
	return c;
}
