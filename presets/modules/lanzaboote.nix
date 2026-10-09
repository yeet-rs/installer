{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkForce
    ;
  sources = import ../npins;
  lanzaboote = import sources.lanzaboote { inherit pkgs; };
in
{
  imports = [ lanzaboote.nixosModules.lanzaboote ];
  system.extraDependencies = [ sources.lanzaboote lanzaboote.packages.lzbt ];

  environment.systemPackages = [
    pkgs.sbctl
  ];

  boot.loader.systemd-boot.enable = mkForce false;
  boot.loader.grub.enable = mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    configurationLimit = 8;
    autoEnrollKeys = {
      enable = true;
      # Automatically reboot to enroll the keys in the firmware
      autoReboot = true;
    };
  };
}
