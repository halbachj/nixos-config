{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    obsidian
    glow
    basalt
    p3x-onenote
    todoist
    todoist-electron
    #nb
    #w3m # nb browse requirement
    xournalpp
  ];

  systemd.user.services.obsidian-daemon = {
    Unit = {
      Description = "Obsidian background service";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.obsidian}/bin/obsidian --hidden";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

}
