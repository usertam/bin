{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";

  outputs = { self, nixpkgs, systems }: let
    forAllSystems = with nixpkgs.lib; genAttrs (import systems);
    forAllPkgs = pkgsWith: forAllSystems (system: pkgsWith nixpkgs.legacyPackages.${system});
    overrideAllPkgs = pkgsWith: forAllPkgs (pkgs: pkgsWith pkgs.pkgsStatic.pkgsLLVM);
  in {
    packages = overrideAllPkgs (pkgs: {
      bash = pkgs.bash;
      coreutils = pkgs.coreutils;
      git = pkgs.gitMinimal;
      hello = pkgs.hello;
      nano = pkgs.nano;
      nix = pkgs.nixVersions.git;
      rsync = pkgs.rsync;
      socat = pkgs.socat;
      zsh = pkgs.zsh;
    });
  };
}
