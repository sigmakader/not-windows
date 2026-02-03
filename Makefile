# not-windows: minimal OS kernel
# Build and run in QEMU

CC   = gcc
ASM  = nasm
LD   = ld

CFLAGS  = -m32 -ffreestanding -nostdlib -Wall -Wextra -O2
ASMFLAGS = -f elf32
LDFLAGS = -m elf_i386 -T linker.ld -nostdlib

OBJS = boot.o kernel.o
KERNEL = kernel.elf

.PHONY: all run clean

all: $(KERNEL)

$(KERNEL): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

boot.o: boot.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c -o $@ $<

run: $(KERNEL)
	qemu-system-i386 -kernel $(KERNEL)

clean:
	rm -f $(OBJS) $(KERNEL)
