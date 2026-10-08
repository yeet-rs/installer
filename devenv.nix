{ pkgs, ... }:

{
  packages = with pkgs; [
    rustup
    just
    nix-output-monitor
  ];
}
