{ pkgs, ... }:
{
  # Terminal-first remote workflow: run hx through SSH, or open
  # `distant://` paths from a local hx.
  programs.helix.extraPackages = with pkgs; [
    openssh    # ssh
    sshfs      # file mounts
    distant    # remote FS/LSP bridge
    mosh       # resilient connections
    tmux
  ];
}

