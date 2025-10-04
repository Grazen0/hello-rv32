{
  mkShell,

  bear,
  glibc_multi,
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
    glibc_multi
    riscvPackages.binutils
    riscvPackages.gcc
    riscvPackages.gdb
    rv32-emu
    xxd
  ];
}
