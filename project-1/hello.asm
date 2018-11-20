; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls.
; To assemble and run:
;
;     $ nasm -felf64 -g hello.asm
;     $ ld -o hello hello.o
;     $ ./hello
; ----------------------------------------------------------------------------------------

          global    _start

          section   .text
_start:   mov       rax, 1                  ; system call for write
          mov       rdi, 1                  ; file handle 1 is stdout
          mov       rsi, message            ; address of string to output
          mov       rdx, 36                 ; number of bytes
          syscall                           ; invoke operating system to do the write
          mov       rax, 60                 ; system call for exit
          sub       rdi, rdi                ; exit code 0
          syscall                           ; invoke operating system to exit

          section   .data
message:  db        "I sure do hope this message shows up", 10      ; note the newline at the end
