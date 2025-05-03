{ pkgs, userSettings, ... }:
{
  environment.systemPackages = with pkgs; [
    cloudflare-warp
  ];
  systemd.packages = with pkgs; [
    cloudflare-warp
  ];
  systemd.targets.multi-user.wants = [ "warp-svc.service" ]; # causes warp-svc to be started automatically
  systemd.user.services.warp-taskbar.wantedBy = [ "graphical.target" ];
}
