{ pkgs, ... }:
{
  services.gvfs.enable = true;     # starts gvfs + gvfsd-fuse in the user session
  services.udisks2.enable = true;  # helps with removable-media integration

  environment.systemPackages = with pkgs; [
    gnome.gvfs
    libmtp
    jmtpfs
    android-file-transfer
    usbutils
  ];
}
