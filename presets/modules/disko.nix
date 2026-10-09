{
  ...
}:
let
  sources = import ../npins;
in
{
  imports = [
    "${sources.disko}/module.nix"
  ];

  system.extraDependencies = [ sources.disko ];
}
