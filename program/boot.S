        .global _start
        .section .text.boot

_start: la sp, _STACK_PTR
	call main
	j .
