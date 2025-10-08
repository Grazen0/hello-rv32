{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";

    rv32-emu.url = "github:Grazen0/rv32-emu";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem =
        {
          self',
          pkgs,
          system,
          inputs',
          ...
        }:
        let
          riscvCross = import nixpkgs {
            inherit system;
            crossSystem.config = "riscv32-unknown-none-elf";
          };
        in
        {
          devShells.default = pkgs.callPackage ./shell.nix {
            inherit (inputs'.rv32-emu.packages) rv32-emu;
            riscvPackages = riscvCross.buildPackages;
          };
        };
    };
}
