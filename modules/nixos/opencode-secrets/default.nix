{ config, ... }:
{
  sops = {
    secrets = {
      opencode_zotero_api_key = {
        sopsFile = ../../home/desktop-base-extra/secrets.yaml;
        key = "opencode_zotero_api_key";
      };
      opencode_zotero_library_id = {
        sopsFile = ../../home/desktop-base-extra/secrets.yaml;
        key = "opencode_zotero_library_id";
      };
      opencode_zotero_library_type = {
        sopsFile = ../../home/desktop-base-extra/secrets.yaml;
        key = "opencode_zotero_library_type";
      };
    };

    templates."opencode-config" = {
      content = builtins.toJSON {
        "$schema" = "https://opencode.ai/config.json";
        mcp = {
          ngspice = {
            type = "local";
            command = [ "/home/twostone/.local/state/nix/profile/bin/ngspice-mcp" "--working-dir" "." ];
            enabled = true;
            timeout = 60000;
          };
          octave = {
            type = "local";
            command = [ "/home/twostone/Projects/mcps/octave/octave-server" ];
            enabled = true;
            timeout = 60000;
          };
          socraticode = {
            type = "local";
            command = [ "npx" "-y" "socraticode" ];
            environment = {
              DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
              NPM_CONFIG_PREFIX = "/home/twostone/.npm-global";
              npm_config_prefix = "/home/twostone/.npm-global";
            };
            enabled = true;
          };
          zotero = {
            type = "local";
            command = [ "nix" "run" "/home/twostone/Projects/zotero-mcp-flake" "--" ];
            environment = {
              ZOTERO_API_KEY = config.sops.placeholder.opencode_zotero_api_key;
              ZOTERO_LIBRARY_ID = config.sops.placeholder.opencode_zotero_library_id;
              ZOTERO_LIBRARY_TYPE = config.sops.placeholder.opencode_zotero_library_type;
            };
            enabled = true;
            timeout = 60000;
          };
        };
      };
      owner = "twostone";
      group = "users";
      mode = "0644";
    };
  };
}
