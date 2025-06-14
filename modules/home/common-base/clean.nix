{ pkgs, ... }:
{
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    # Keep only the last 10 generations
    # see https://nix.dev/manual/nix/2.25/command-ref/nix-collect-garbage
    # and https://nix.dev/manual/nix/2.25/command-ref/nix-env/delete-generations#generations-count
    # For some reason + number is recongnised as invalid though
    options = "--delete-older-than 5d";
  };
  systemd.user.services.clean-trash = {
    Unit = {
      Description = "Clean xdg trash";
    };
    Service = {
      ExecStart = "${pkgs.trash-cli}/bin/trash-empty 30";
      Type = "oneshot";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}

