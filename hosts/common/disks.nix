{ lib, ... }: {
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/disk/by-id/the-drive"; # Overridden by CLI arguments
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
            #passwordFile = "/tmp/secret.key"; # Interactive
            settings = {
              allowDiscards = true;
              #keyFile = "/tmp/secret.key";
            };
            #additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
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
                # Disable swap for common systems
                #"/swap" = {
                #  mountpoint = "/.swapvol";
                #  swap.swapfile.size = "20M";
                #};
              };
            };
          };
        };
      };
    };
  };
}

