{ pkgs, ... } : {
  programs = {
    keepassxc = {
      enable = true;
      autostart = true;
      settings = {
        Browser = {
          Enabled = true;
          UpdateBinaryPath = false;
        };
        GUI = {
          ApplicationTheme = "dark";
          ShowTrayIcon = true;
        };
        SSHAgent.Enabled = true;
        PasswordGenerator.WordSeparator = "-";
        Security = {
          LockDatabaseIdle = true;
          LockDatabaseScreenLock = true;
        };
        SecretService.Enabled = true;
      };
    };
  };

  home.packages = with pkgs; [
    libsecret
  ];
}
