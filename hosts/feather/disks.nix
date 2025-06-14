{
  lib,
  config,
  disk ? "/dev/vda",
  ...
}:
{
  boot.initrd.luks.devices."cryptroot" = {
    allowDiscards = true;
    preLVM = false;
  };
  #fileSystems = {
  #  # "/".device = lib.mkForce "/dev/disk/by-partlabel/root";
  #  "/boot".device = lib.mkForce "/dev/disk/by-label/NIXOS-BOOT";
  #};


  disko.devices.disk.main = {
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
              extraArgs = [ "-f" ]; # Override existing partition
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
  # Trim because disk is ssd 
  services.fstrim.enable = true;
}
