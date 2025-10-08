# RISC-V 32 Test

A practice project to mess around with RISC-V assembly and C.

Powered by [my own RV32I emulator][rv32-emu]!

## Building

```bash
# Compile and run the emulator
make run

# **In another terminal**, connect with GDB
make debug
```

If you don't like opening more than a single terminal, you can try this out:

```bash
make run &; make debug
```

[rv32-emu]: https://github.com/Grazen0/rv32-emu
