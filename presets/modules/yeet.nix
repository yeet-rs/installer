{
  pkgs,
  ...
}:
let
  sources = import ../npins;
  yeet = import sources.yeet { inherit pkgs; };
in
{
  system.extraDependencies = [ sources.yeet ];
  imports = [
    yeet.nixosModules.yeet
  ];

  # services.journald.settings.Journal
  # services.journald.extraConfig = ''
  #   ForwardToConsole=no
  #   ForwardToWall=no
  #   MaxLevelConsole=emerg
  # '';

  environment.systemPackages = [
    pkgs.nixos-facter
    pkgs.nix-output-monitor
    yeet.packages.yeet
  ];

  services.yeet = {
    enable = true;
    server = "https://yeetme.ch";
    facter = true;
  };

  services.openssh.enable = true;

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  systemd.services.yeet.serviceConfig = {
    StandardOutput = "tty";
    StandardError = "tty";

    TTYPath = "/dev/tty1";

    TTYReset = "yes";
    TTYVHangup = "yes";
    TTYVTDisallocate = "yes";
  };
}
