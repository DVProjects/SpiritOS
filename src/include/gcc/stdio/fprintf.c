#include <stdio.h>

int vfprintf(FILE *stream, const char *format, va_list args){
	int char_count;
	while (*format) {
		if (*format != '%') {
			putc(*format, stream);
			char_count++;
			format++;
		} else {
			format++;
			switch (*format) {
			//TODO implement better format tags
				case 'c':
					putc(va_arg(args, int), stream);
					char_count++;
				case 's':
					fputs(va_arg(args, char*), stream);
					break;
				case 'd':
				case 'i':
					break;
			}
			format++;
		}
	}
}

int fprintf(FILE *stream, const char *format, ...){
	int r;
	va_list arg;
	va_start(arg, format);
	r =  vfprintf(stream, format, arg);
	va_end(arg);
	return r;
}
