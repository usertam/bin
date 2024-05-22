# Bin

A set of static, clang-built binaries for multiple [platforms](https://github.com/nix-systems/default/blob/da67096a3b9bf56a91d16901293e51ba5b49a27e/default.nix), built with nix. About half of them will fail to build, until `pkgs/top-level/stage.nix` gets better support.

Successful builds are available in [latest release](https://github.com/usertam/bin/releases/latest).

## Fixed dependencies
- aarch64-darwin: `nixpkgs#pkgsLLVM.stdenv.cc.bintools.bintools`

## Broken dependencies
- aarch64-linux: `nixpkgs#pkgsStatic.pkgsLLVM.gmp`,  (but not with single `pkgsStatic` or `pkgsLLVM`)  
  `configure: error: C++ compiler not available, see config.log for details`
- basically everything else

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
