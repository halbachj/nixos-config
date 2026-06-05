{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    age
    sops
  ];

  sops.secrets.user_password = {
    neededForUsers = true;
    sopsFile = ./secrets.yaml;
  };
}
