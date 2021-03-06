#include "GDT.h"
#include "Memory.h"
#include "Kernel.h"
#include <string.h>

GDTEntry GDT[GDTSIZE];
GDTPtr GDTP;

extern "C" void GDTFlush();

void GDTInitDesc(int Num, ulong Base, ulong Limit, byte Access, byte Gran) {
	GDT[Num].base_low = (Base & 0xFFFF);
	GDT[Num].base_middle = (Base >> 16) & 0xFF;
	GDT[Num].base_high = (Base >> 24) & 0xFF;

	GDT[Num].limit_low = (Limit & 0xFFFF);
	GDT[Num].granularity = ((Limit >> 16) & 0x0F);

	GDT[Num].granularity |= (Gran & 0xF0);
	GDT[Num].access = Access;
}

void GDTInit() {
	GDTP.limit = sizeof(GDTEntry) * GDTSIZE - 1;
	GDTP.base = (uint)&GDT;
	memset(GDT, 0, sizeof(GDTEntry) * GDTSIZE);

	GDTInitDesc(0, 0, 0, 0, 0);
	GDTInitDesc(1, 0, 0xFFFFFFFF, 0x9A, 0xCF);
	GDTInitDesc(2, 0, 0xFFFFFFFF, 0x92, 0xCF);

	ASM lgdt GDTP;
	GDTFlush();
}