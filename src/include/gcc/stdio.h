#ifndef _STDIO_H
#define _STDIO_H 1

#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>

#define EOF (-1)

#define _IOFBF 1
#define _IONBF 0
#define _IOLBF (-1)

typedef struct _IO_FILE {
	char* _write_ptr;
	char* _write_base;
	char* _read_ptr;
	char* _read_base;
	size_t _bufsize;
	int8_t _buftype;
} FILE;

FILE* stdout;
//TODO: add stdin & stderr

#define putchar(char) fputc(char, stdout)
#define putc(char, stream) fputc(char, stream)

int fputc(int c,FILE* stream);

#define printf(format, ...) fprintf(stdout, format,##__VA_ARGS__)
#define vprintf(format, args) vfprintf(stdout, format, args)

int fprintf(FILE *stream, const char *format, ...);
int vfprintf(FILE *stream, const char *format, va_list args);

#define fputs(str, stream) fprintf(stream, str)
#define puts(str) fputs(str, stdio)

#endif
