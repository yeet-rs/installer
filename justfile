crate2nix:
    nix run nixpkgs#crate2nix -- generate

build:
    nom build -f . installer.config.system.build.image
