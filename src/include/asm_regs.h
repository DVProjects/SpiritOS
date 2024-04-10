#ifndef X86_REGS
#define X86_REGS 1

struct register {
	uint32_t ds, es, fs, gs; //segment registers
	uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax; //extended registers
	uint32_t ip, cs, eflags, useresp, ss;
};

#endif
