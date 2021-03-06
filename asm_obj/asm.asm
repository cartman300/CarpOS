SECTION .text

extern _empty_handler

global _GDTFlush
_GDTFlush:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	jmp 0x8:_EndFlush
_EndFlush:
	ret

_int_handler:
	pusha
	push ds
	push es
	push fs
	push gs
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov eax, esp
	push eax
	mov eax, _empty_handler
	call eax
	pop eax
	pop gs
	pop fs
	pop es
	pop ds
	popa
	add esp, 8
	sti
	iret

%macro DEFINE_ISR_NOERROR 1
	global _isr_%1
	_isr_%1:
		cli
		push byte 0
		push byte %1
		jmp _int_handler
%endmacro

%macro DEFINE_ISR_ERROR 1
	global _isr_%1
	_isr_%1:
		cli
		push byte %1
		jmp _int_handler
%endmacro

DEFINE_ISR_NOERROR 0
DEFINE_ISR_NOERROR 1
DEFINE_ISR_NOERROR 2
DEFINE_ISR_NOERROR 3
DEFINE_ISR_NOERROR 4
DEFINE_ISR_NOERROR 5
DEFINE_ISR_NOERROR 6
DEFINE_ISR_NOERROR 7
DEFINE_ISR_ERROR 8
DEFINE_ISR_NOERROR 9
DEFINE_ISR_ERROR 10
DEFINE_ISR_ERROR 11
DEFINE_ISR_ERROR 12
DEFINE_ISR_ERROR 13
DEFINE_ISR_ERROR 14
DEFINE_ISR_NOERROR 15
DEFINE_ISR_NOERROR 16
DEFINE_ISR_NOERROR 17
DEFINE_ISR_NOERROR 18
DEFINE_ISR_NOERROR 19
DEFINE_ISR_NOERROR 20
DEFINE_ISR_NOERROR 21
DEFINE_ISR_NOERROR 22
DEFINE_ISR_NOERROR 23
DEFINE_ISR_NOERROR 24
DEFINE_ISR_NOERROR 25
DEFINE_ISR_NOERROR 26
DEFINE_ISR_NOERROR 27
DEFINE_ISR_NOERROR 28
DEFINE_ISR_NOERROR 29
DEFINE_ISR_NOERROR 30
DEFINE_ISR_NOERROR 31

; IRQs
DEFINE_ISR_NOERROR 32
DEFINE_ISR_NOERROR 33
DEFINE_ISR_NOERROR 34
DEFINE_ISR_NOERROR 35
DEFINE_ISR_NOERROR 36
DEFINE_ISR_NOERROR 37
DEFINE_ISR_NOERROR 38
DEFINE_ISR_NOERROR 39
DEFINE_ISR_NOERROR 40
DEFINE_ISR_NOERROR 41
DEFINE_ISR_NOERROR 42
DEFINE_ISR_NOERROR 43
DEFINE_ISR_NOERROR 44
DEFINE_ISR_NOERROR 45
DEFINE_ISR_NOERROR 46
DEFINE_ISR_NOERROR 47

DEFINE_ISR_NOERROR 80 ; SYSCALLS

;section .data
;	resb 1024 * 50
;section .bss
;	resb 1024 * 50