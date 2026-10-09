{
  system ? builtins.currentSystem,

}:
let
  sources = import ./presets/npins;
  pkgs = import sources.nixpkgs { inherit system; };

  cargo_nix = pkgs.callPackage ./Cargo.nix { };

  nixos =
    nixpkgs: configuration:
    import "${nixpkgs}/nixos" {
      inherit configuration;
      specialArgs = {
        inherit nixpkgs;
      };
    };

in
rec {
  packages = {
    installer = cargo_nix.rootCrate.build;
  };
  installer = nixos sources.nixpkgs {
    imports = [ ./modules/installer.nix ];
    nixpkgs.overlays = [
      (final: prev: {
        yeet-installer = packages.installer;
      })
    ];
  };
}
