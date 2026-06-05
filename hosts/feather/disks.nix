{
  lib,
  config,
  diskA ? "/dev/vda",
  diskB ? "/dev/vdb",
  ...
}:
{
  boot.initrd.luks.devices."cryptroot" = {
    allowDiscards = true;
    #preLVM = false;
  };

  #fileSystems = {
  #  # "/".device = lib.mkForce "/dev/disk/by-partlabel/root";
  #  "/boot".device = lib.mkForce "/dev/disk/by-label/NIXOS-BOOT";
  #};

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = diskA;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2000M";
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
                name = "cryptroot";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  #extraArgs = [ "-f" ]; # Override existing partition
                  subvolumes = {
                    "/root" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/";
                    };
                    "/home" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/data";
                    };
                    "/nix" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/nix";
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "28G";
                    };
                  };
                };
              };
            };
          };
        };
      };
      home = {
        type = "disk";
        device = diskB;
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypthome";
                extraOpenArgs = [ ];
                settings = {
                  # if you want to use the key for interactive login be sure there is no trailing newline
                  # for example use `echo -n "password" > /tmp/secret.key`
                  keyFile = "/sysroot/etc/secrets/crypthome.key";
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  #extraArgs = [ "-f" ]; # Override existing partition
                  subvolumes = {
                    "/home" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "nofail"
                        "x-systemd.automount"
                        "x-systemd.device-timeout=5s"
                        "x-systemd.idle-timeout=60s"
                      ];
                      mountpoint = "/home";
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
  #fileSystems."/cryptarch".neededForBoot = false;
  fileSystems."/home".neededForBoot = false;
  # Trim because disk is ssd
  services.fstrim.enable = true;
}
