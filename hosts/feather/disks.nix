{
  lib,
  config,
  disk ? "/dev/vda",
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
        device = disk;
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
      arch = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
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
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptarch";
                extraOpenArgs = [ ];
                settings = {
                  # if you want to use the key for interactive login be sure there is no trailing newline
                  # for example use `echo -n "password" > /tmp/secret.key`
                  keyFile = "/etc/secrets/cryptarch.key";
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "main";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      main = {
        type = "lvm_vg";
        lvs = {
          home = {
            size = "100%";
            content = {
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
