# cs171-systems
Projects from Computer Systems

Project 1: (countdown.asm) Write a loop that counts down from 9 to 0, generating output along
the way.

Project 2: (neo-hello.asm) Notice that there is a label, string_length, followed by no code. You
must write that procedure. Specifically, this procedure has one parameter—a pointer to a string—
and it returns one value—the length of that string. Write this procedure to count the number of
bytes in the string, using the zero-valued byte as the marker of the string’s end.

(exp.asm) Write the exp() procedure recursively. Assuming 64-bit integer parameters
x and y, calculate and return x^y. Do not worry about error handling (e.g., negative values for y).


Project 3: (pb-alloc.c) Implement a reclaiming, first-fit heap allocator. Here, your allocator will need to
keep a free list. That is, blocks passed to free() are placed onto a list and again made available
for allocation. malloc() should preferentially select the first sufficiently large block from that
list when an allocation is requested; if there is no such block in the free list, then it should use
pointer-bumping to allocate a new portion of the heap.


Project 4: (mmu.c) Your task is to implement the simulated MMU, making it translate simulated addresses to real
ones using page tables created and managed by other vmsim code.
