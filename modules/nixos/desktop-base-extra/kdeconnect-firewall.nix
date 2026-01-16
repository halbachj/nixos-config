{ ... }:
{
  networking.firewall = rec {
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges ++ [
      { from = 49000; to = 49010; }
    ];
  };
}
