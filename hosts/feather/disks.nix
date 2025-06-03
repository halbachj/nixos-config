{
  lib,
  config,
  disk ? "/dev/vda",
  ...
}:
{
  boot.initrd.luks.devices."cryptroot" = {
    # TODO: Remove this "device" attr if/when machine is reinstalled.
    # This is a workaround for the legacy -> gpt tables disko format.
    # dm-0 27bbc6ff-6842-44fa-9141-7b66e504f257
    # nvme0n1p2 b840207f-5469-4c39-becc-214b7c69c7b3
    device = lib.mkForce "/dev/disk/by-uuid/727a6e17-eeb0-44b8-b652-3b183c4a0e24";

    allowDiscards = true;
    preLVM = true;
  };
  fileSystems = {
    # "/".device = lib.mkForce "/dev/disk/by-partlabel/root";
    "/boot".device = lib.mkForce "/dev/disk/by-label/NIXOS-BOOT";
  };


  disko.devices.disk.vda = {
    type = "disk";
    device = disk;
    content = {
      type = "gpt";
      partitions = {
        NIXOS-BOOT = {
          type = "EF00";
          start = "1M";
          end = "1G";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            # mountOptions = [ "defaults" ];
          };
        };
        NIXOS-LUKS = {
          start = "1G";
          end = "100%";
          content = {
            type = "luks";
            name = "cryptroot";
            # extraOpenArgs = [ "--allow-discards" ];
            # if you want to use the key for interactive login be sure there is no trailing newline
            # for example use `echo -n "password" > /tmp/secret.key`
            # settings.keyFile = "/tmp/secret.key";
            settings = {
              allowDiscards = true;
            };
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # Override existing partition
              # postCreateHook = ''
              #   MNTPOINT=$(mktemp -d)
              #   mount "/dev/mapper/crypted" "$MNTPOINT" -o subvol=/
              #   trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT
              #   btrfs subvolume snapshot -r $MNTPOINT/root $MNTPOINT/root-blank
              # '';
              subvolumes = {
                "root" = {
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/";
                };
                "home" = {
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/home";
                };
                "nix" = {
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/nix";
                };
                "swap" = {
                  swap.swapfile.size = "24G";
                  mountpoint = "/swap";
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
