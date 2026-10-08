{ pkgs, ... }:

{
  packages = with pkgs; [
    rustup
    just
  ];
}
