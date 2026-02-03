# not windows

A minimal OS kernel that boots on x86, prints "not windows" in VGA text mode, and runs in QEMU.

## What you need

- **gcc** (with 32-bit support, e.g. `gcc-multilib` on Debian/Ubuntu)
- **nasm** (assembler)
- **make**
- **QEMU** (`qemu-system-x86` or `qemu-system-i386`)

On Debian/Ubuntu:

```bash
sudo apt install build-essential nasm qemu-system-x86
```

## Build and run

```bash
make
make run
```

QEMU will start and you should see a blue screen with **not windows** in the middle.

## What’s in the repo

- `boot.asm` — Multiboot 1 header and entry point
- `kernel.c` — Minimal kernel: VGA text buffer, prints the message
- `linker.ld` — Linker script so the kernel is loaded at 1 MiB
- `Makefile` — Builds the kernel and runs it in QEMU

This is a starting point: you can add interrupts, memory management, a shell, and more from here.
