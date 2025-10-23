{
  mkShell,

  bear,
  riscvPackages,
  rv32-emu,
  xxd,
}:
mkShell {
  hardeningDisable = [
    "relro"
    "bindnow"
  ];

  packages = [
    bear
    riscvPackages.binutils
    riscvPackages.gcc
    riscvPackages.gdb
    riscvPackages.glibc_multi
    rv32-emu
    xxd
  ];
}
