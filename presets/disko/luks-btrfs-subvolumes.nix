{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/INSTALLER_DISK_MAIN";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                # askPassword = true; # if you want to manually input your password
                # enrollFido2 = true; # enroll you fido-key. can be added later by executing `yeet tpm enroll-fido`
                # enrollRecovery = false; # (recommended) you can use `enrollFido` in combination with `passwordFile` to skip the recovery

                # creates a new password and the stores it on the new system so that it can be recorded as an artifact
                # currently only supports a single luks password for all disks. if you need more than that, please create an issue
                passwordFile = "/INSTALLER_LUKS_PASSWORD";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "20M";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
