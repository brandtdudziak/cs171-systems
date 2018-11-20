; ----------------------------------------------------------------------------------------
; Counts down from 9 to 0, printing each.
; To assemble and run:
;
;     $ nasm -felf64 -g countdown.asm
;     $ ld -o countdown countdown.o
;     $ ./countdown	
; ----------------------------------------------------------------------------------------

; ----------------------------------------------------------------------------------------
        global    _start
; ----------------------------------------------------------------------------------------

; ----------------------------------------------------------------------------------------
        section   .text

_start:	mov rax, 1
	mov rdi, 1
	mov rsi, digit
	mov rdx, 2
	mov r10, 9
	
top:	cmp r10, 0
	jl end
	dec r10
	syscall
	dec byte[rsi]
	mov rax, 1
	jmp top

	;; YOUR CODE GOES HERE.
	;; Make the program print, one line at a time: 9, 8, 7, ..., 1, 0.
	
	;; Call the kernel to exit.
end:	mov       rax, 60                 ; System call code for "exit".
        mov       rdi, 0                  ; Exit code for "normal exit".
        syscall                           ; Make it so.
; ----------------------------------------------------------------------------------------

; ----------------------------------------------------------------------------------------
          section   .data
digit:    db        "9", 10	; The first digit to print, as a string with the appended newline.
; ----------------------------------------------------------------------------------------
