;;; ----------------------------------------------------------------------------------------
;;; Calculate 
;;; the console, and then exit.
;;;
;;; To assemble and run:
;;;
;;;     $ nasm -felf64 -g exp.asm
;;;     $ gcc -o exp exp.o
;;;     $ ./exp
;;; ----------------------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------------------
        global  main
	global  exp
	extern  printf
;;; ----------------------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------------------
        section	.text	              ; The start of the code portion of the program.
	
main:                                 ; Called by the C library stub code.

	;; Call exp to calculate x^y.
	mov	rdi, [x]	      ; arg[0] = base
	mov	rsi, [y]	      ; arg[1] = exponent
	sub	rsp, 8		      ; Align rsp to double-world boundary.
	call	exp		      ; Calculate rax = x^y
	add	rsp, 8		      ; Restore rsp.

	;; Print the result of x^y.
	mov	rdi, int_format_string ; arg[0] = formatting string.
	mov	rsi, rax	       ; arg[1] = x^y (supra)
	mov	rax, 0		       ; arg[2] = 0 (end of arguments marker for varargs)
	sub	rsp, 8		       ; Align rsp.
	call	printf
	add	rsp, 8		       ; Restore rsp.

	mov	rax, 0		       ; Exit status code = "all normal".
	ret			       ; End of main.

exp:

	mov 	rax, 1
	cmp	rsi, 0
	je	end
	dec	rsi
	sub	rsp, 8
	call	exp
	add	rsp, 8
	imul	rax, rdi
end:	ret
	
	;; YOUR CODE GOES HERE.  Calculate x^y, where:
	;;   rdi = x (the base)
	;;   rsi = y (the exponent)
	;;   rax = x^y (the return value carried back to the caller)
	
;;; ----------------------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------------------
        section   .data		         ; The start of the data portion of the program.

x:	dq	2
y:	dq	5
	
int_format_string:	
	db        "%d", 10, 0	         ; Formatting string for an int, newline, null-terminator.
;;; ----------------------------------------------------------------------------------------
