{ config, ... }:
{
  imports = [ ./sops.nix ];
  users.users.twostone.hashedPasswordFile = config.sops.secrets.user_password.path;
}
