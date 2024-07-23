#ifndef _SYS_IO_H
#define _SYS_IO_H 1

#include <stdint.h>

static inline uint8_t inb(uint16_t port){
    uint8_t ret;
    __asm__ volatile ( "inb %w1, %b0"
                   : "=a"(ret)
                   : "Nd"(port)
                   : "memory");
    return ret;
}

static inline uint16_t inw(uint16_t port){
    uint16_t ret;
    __asm__ volatile ( "inb %w1, %w0"
                   : "=a"(ret)
                   : "Nd"(port)
                   : "memory");
    return ret;
}

static inline void outb(uint16_t port, uint8_t val){
    __asm__ volatile ( "outb %b0, %w1" : : "a"(val), "Nd"(port) : "memory");
}

static inline void outw(uint16_t port, uint16_t val){
    __asm__ volatile ( "outb %w0, %w1" : : "a"(val), "Nd"(port) : "memory");
}

static inline void io_wait(void){
    outb(0x80, 0);
}

#endif
