{
  pkgs ? import <nixpkgs> { },
}:
let
  riscvCross = import <nixpkgs> {
    crossSystem = {
      config = "riscv32-none-elf";
    };
  };
in
pkgs.mkShell {
  packages = with pkgs; [
    dtc
    riscvCross.buildPackages.binutils
    riscvCross.buildPackages.gcc
    spike
    xxd
  ];
}
