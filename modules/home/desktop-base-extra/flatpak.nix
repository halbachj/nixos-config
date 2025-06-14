{ inputs, ... }:
{
  # See https://github.com/gmodena/nix-flatpak
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
  services.flatpak = {
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      # Browsing
      "org.torproject.torbrowser-launcher"
      "com.transmissionbt.Transmission"
      # Media Editors
      "org.gimp.GIMP"
      "org.inkscape.Inkscape"
      "org.libreoffice.LibreOffice"
      # Media Organisers
      "com.calibre_ebook.calibre"
      "org.kde.digikam"
      "org.musicbrainz.Picard"
      # Media Players
      "org.gnome.Loupe"
      "org.videolan.VLC"
      # Messaging
      "com.discordapp.Discord"
      "im.riot.Riot"
      "org.signal.Signal"
    ];
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    uninstallUnmanaged = true;
  };
}

