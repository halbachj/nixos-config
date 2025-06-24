{ config, lib, pkgs, ... }:

{
  ############################
  ##   Networking stack    ##
  ############################
  networking = {
    # Disable legacy DHCP client; NetworkManager handles DHCP itself.
    dhcpcd.enable = false;
    useDHCP       = false;

    # Stay on NetworkManager (not systemd-networkd).
    useNetworkd   = false;

    # Let systemd-resolved own /etc/resolv.conf instead of openresolv.
    resolvconf.enable = false;

    ## Wi-Fi / iwd ##########################################################
    wireless = {
      enable         = false;  # don’t run wpa_supplicant directly
      dbusControlled = true;   # required for NetworkManager integration

      iwd = {
        enable = true;
        settings = {
          General  = { AddressRandomization = "network"; };
          Network  = {
            EnableIPv6          = true;
            NameResolvingService = "systemd";
          };
          Settings = {
            AutoConnect          = true;
            AlwaysRandomizeAddress = true;
          };
        };
      };
    };

    ## NetworkManager #######################################################
    networkmanager = {
      enable = true;
      dns    = "systemd-resolved";      # tell NM to delegate DNS
      wifi = {
        backend            = "iwd";
        macAddress         = "random";
        scanRandMacAddress = true;
        # powersave = true;  # caused drops, left commented
      };
    };
  };

  ############################
  ##      Services          ##
  ############################
  services = {
    ## DNS resolver ###########################################
    resolved = {
      enable = true;  # starts systemd-resolved & creates stub /etc/resolv.conf

      # Quad-9 (security-filtered, no-log) as fallback servers.
      fallbackDns = [
        "9.9.9.9"
        "149.112.112.112"
        "2620:fe::fe"
        "2620:fe::9"
      ];
    };

    ## Tailscale ##############################################
    tailscale.enable = true;
  };
}
