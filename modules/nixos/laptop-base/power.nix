# SPDX-FileCopyrightText: 2025 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS
# https://codeberg.org/delliott/nixos-config

_: {
  powerManagement = {
    enable = true;
  };
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      # Long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      NMI_WATCHDOG = 0; # Disable NMI (Non maskable interrupt) watchdog timer
    };
  };
}

