target remote :3333

tui new-layout src-regs {-horizontal src 1 regs 1} 2 cmd 1
tui new-layout src-asm {-horizontal src 1 asm 1} 2 cmd 1
tui new-layout regs-asm {-horizontal regs 1 asm 1} 2 cmd 1

layout src-regs

define reload
    file build/hello.elf
    target remote :3333
end
