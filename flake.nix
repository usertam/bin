{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";

  outputs = { self, nixpkgs, systems }: let
    forAllSystems = with nixpkgs.lib; genAttrs (import systems);
    forAllPkgs = pkgsWith: forAllSystems (system: pkgsWith nixpkgs.legacyPackages.${system});
    overrideAllPkgs = pkgsWith: forAllPkgs (pkgs:
      builtins.mapAttrs
        (name: pkg: pkg.override { stdenv = pkgs.clangStdenv; })
        (pkgsWith pkgs.pkgsStatic)
    );
  in {
    packages = overrideAllPkgs (pkgs: {
      socat = pkgs.hello;
    });
  };
}
