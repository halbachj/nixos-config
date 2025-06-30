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
                      mountpoint = "/home";
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
      data = {
        type = "disk";
        device = diskB;
        content = {
          neededForBoot = false;
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
              };
            };
            data = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptdata";
                extraOpenArgs = [ ];
                settings = {
                  # if you want to use the key for interactive login be sure there is no trailing newline
                  # for example use `echo -n "password" > /tmp/secret.key`
                  keyFile = "/sysroot/etc/secrets/cryptarch.key";
                  allowDiscards = true;
                };
                content = {
                  neededForBoot = false;
                  type = "lvm_pv";
                  vg = "data";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      data = {
        type = "lvm_vg";
        lvs = {
          home = {
            size = "100%";
            content = {
              neededForBoot = false;
              type = "filesystem";
              format = "ext4";
              mountpoint = "/cryptarch";
            };
          };
        };
      };
    };
  };

  # Trim because disk is ssd 
  services.fstrim.enable = true;
}
