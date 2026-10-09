crate2nix:
    nix run nixpkgs#crate2nix -- generate

build:
    nom build -f . installer.config.system.build.image

vm:
    nom build -f . installer.config.system.build.vm
    ./result/bin/run-nixos-vm

[working-directory('presets')]
os +MODULES:
    nom build --impure --expr 'import "${(import ./npins).nixpkgs}/nixos/lib/eval-config.nix" { system = null; modules = [ {{ MODULES }} ]; }' config.system.build.vm
    ./result/bin/run-nixos-vm
