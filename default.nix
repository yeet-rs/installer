{
  system ? builtins.currentSystem,

}:
let
  pins = import ./npins;
  pkgs = import pins.nixpkgs { inherit system; };

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
  pkgs.mkShell = {
    packages = [
      pkgs.rustup
      pkgs.just
    ];
  };
  # packages = {
  #   installer = cargo_nix.workspaceMembers."installer".build;
  # };
  # installer = nixos nixpkgs {
  #   imports = [ ./installer/installer.nix ];
  #   nixpkgs.overlays = [
  #     (final: prev: {
  #       yeet-installer = packages.installer;
  #     })
  #   ];
  # };
}
