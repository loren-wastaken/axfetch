# axfetch
## A fetch tool designed for AtomiXOS.
**Architecture**: i386 (32-bit x86)
# What's in this fetch tool
- [x] Basic CPU info (vendor and brand)

Example:
[example1.png](assets/example1.png)

# Planned features
- [ ] RAM Amount
- [ ] Disk space (if disk available)
# How to build
Clone the repo (`git clone https://github.com/loren-wastaken/axfetch.git`)
Make sure you have NASM, GNU ld and GNU Make.

If you dont have these tools then
`sudo pacman -S nasm binutils make` for Arch/Manjaro or `sudo apt install nasm binutils make` for Ubuntu/Debian

Then build axfetch:
``` bash
make
```
This will produce `axfetch.elf`
# Requirements
- AtomiXOS
- i386 (32-bit x86) environment

> [!WARNING]
> axfetch currently calls AtomiXOS's `print_text()` directly using its
> linked kernel address. This address may change when the kernel is rebuilt.
> A proper userspace syscall/API is planned for a future version.
