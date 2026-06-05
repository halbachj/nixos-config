{
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  home.packages = [
    inputs.cursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.opencode
  ];

  home.activation.opencodeConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [[ -f /run/secrets/rendered/opencode-config ]]; then
      $DRY_RUN_CMD mkdir -p "$HOME/.config/opencode"
      $DRY_RUN_CMD ln -sf /run/secrets/rendered/opencode-config "$HOME/.config/opencode/config.json"
    fi
  '';
}
