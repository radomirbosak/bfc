%define sys_read 0
%define sys_write 1

%define stdin 0
%define stdout 1

%ifndef INCFILE
	%fatal "Please specify file to include in INCFILE variable(macro)"
%endif

%macro begin 0
	%push repeat
	%$begin:
	cmp byte [tape+r8], 0
	je %$end
%endmacro

%macro end 0
	jmp %$begin
	%$end:
	%pop
%endmacro

%macro plus 0
	inc byte [tape+r8]
%endmacro

%macro minus 0
	dec byte [tape+r8]
%endmacro

%macro right 0
	inc r8b
%endmacro

%macro left 0
	dec r8b
%endmacro

%macro read 0
	mov rax, sys_read ;sys_read
	mov rdi, stdin ;stdin
	lea rsi, [tape+r8]
	mov rdx, 1
	syscall
%endmacro

%macro write 0
	mov rax, sys_write
	mov rdi, stdout
	lea rsi, [tape+r8]
	mov rdx, 1
	syscall
%endmacro

global _start

section .data
tape: times 256 db 0
iocell: db 0

section .text
_start:
	xor r8,r8
	mov r8b, 0 ; current tape address
	
	%include %[INCFILE]
		
exit:
	mov rax, 60
	mov rdi, 0
	syscall
