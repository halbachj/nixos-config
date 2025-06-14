{ pkgs, ... }:
{
  boot.loader = {
    timeout = 5;

    efi = {
      efiSysMountPoint = "/boot"; 
    };

    systemd-boot.enable = false;
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      efiInstallAsRemovable = true; # Other wise /boot/EFI/BOOT/BOOTX64.EFI isn't generated.
      devices = [ "nodev" ];
      extraEntriesBeforeNixOS = true;
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
        '';
    };
  };
  boot.supportedFilesystems = [ "ntfs" ];
}
