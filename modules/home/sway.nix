{ pkgs, host, ... }:
let
    modifier = "Mod4";
    left  = "h";
    down  = "j";
    up    = "k";
    right = "l";
    resizeAmount = "30px";
    menu = "rofi -show drun";
    filebrowser = "nemo";
    webbrowser = "zen";
    webbrowserPersistent = "firefox";
    musicplayer = "spotify";
  in {
    home = {
      file = {
        #".config/sway/background.png".source = background;
        #".config/sway/idle.sh".source = ./idle.sh;
        #".config/sway/drive-mount.sh".source = ./drive-mount.sh;
        #".config/sway/drive-unmount.sh".source = ./drive-unmount.sh;
        #".config/sway/scan-barcode.sh".source = ./scan-barcode.sh;
        #".config/sway/color-picker.sh".source = builtins.fetchurl {
        #  url = https://raw.githubusercontent.com/jgmdev/wl-color-picker/main/wl-color-picker.sh;
        #  sha256 = "0f3i86q9vx0665h2wvmmnfccd85kav4d9kinfzdnqpnh96iqsjkg";
        #};
        #".config/sway/screenshot.sh".source = ./screenshot.sh;
        #".config/sway/ocr.sh".source = ./ocr.sh;
        #".config/sway/copy-date.sh".source = ./copy-date.sh;
        #".config/sway/lock.sh".source = ./lock.sh;
      };
    };
    wayland.windowManager.sway = {
      enable = true;
      config = {
        gaps = {
          smartBorders = "on";
          smartGaps = true;
        };
        floating.border = 1;
        window.border = 1;
        bars = [
	  {
	    position = "top";
	    statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs /home/twostone/.config/i3status-rust/config-default.toml";
	  }
	];
        #colors = {
        #};
        fonts = {
          names = [ "Jetbrains Mono Nerd Font" ];
          style = "Regular Bold";
          size = 8.0;
        };
        input = {
          "*" = {
            xkb_layout = "de";
            #xkb_variant = "nodeadkeys";
            xkb_options = "grp:alt_shift_toggle";
            xkb_numlock = "enable";
          };
	  "1452:591:Keychron_K4_Keychron_K4" = {
            xkb_layout = "us";
            xkb_options = "caps:none";
	  };
        };
        menu = menu;
        modifier = modifier;
        left = left;
        down = down;
        up = up;
        right = right;
	keycodebindings = {
	  "--release 133" = "exec ${menu}"; 
	};
        keybindings = {
          "${modifier}+Shift+c" = "reload";
          # Kill focused window
	  "${modifier}+c" = "kill";
          "${modifier}+Return" = "exec ghostty";
          "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | xclip -i -selection clipboard -t image/png";
          "${modifier}+Shift+p" = "exec grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png";
          "${modifier}+k+d" = "input * xkb_layout \"de\"";
          "${modifier}+k+u" = "input * xkb_layout \"us\"";
          "${modifier}+k+i" = "input * xkb_layout \"ie\"";

	  ## Switch focus using hjkl
          "${modifier}+${left}" = "focus left";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${right}" = "focus right";

          ### With arrow keys
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          ## Move the focused window with the same, but add Shift
          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${down}" = "move down";
          "${modifier}+Shift+${up}" = "move up";
	  "${modifier}+Shift+${right}" = "move right";

          ### With arrow keys
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          # Workspaces
          ## Switch to workspace
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          ## Move focused container to workspace
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          ## Workspaces can have any name you want, not just numbers.
          ## We just use 1-10 as the default.
          # Layout stuff
          ## You can "split" the current object of your focus with ${modifier}+b, ${modifier}+v for horizontal and vertical splits respectively.
          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";

          ## Switch the current container between different layout styles
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          ## Make the current focus fullscreen
          "${modifier}+f" = "fullscreen";

          ## Toggle the current focus between tiling and floating mode
          "${modifier}+Shift+space" = "floating toggle";

          ## Swap focus between the tiling area and the floating area
          "${modifier}+space" = "focus mode_toggle";

          ## Move focus to the parent container
          "${modifier}+a" = "focus parent";

          # Scratchpad
          ## Sway has a "scratchpad", which is a bag of holding for windows. You can send windows there and get them back later.
          ## Move the currently focused window to the scratchpad
          "${modifier}+Shift+minus" = "move scratchpad";
          ## Show the next scratchpad window or hide the focused scratchpad window. If there are multiple scratchpad windows, this command cycles through them.
          "${modifier}+minus" = "scratchpad show";
          # Resizing containers
          # Mode "resize"
          "${modifier}+r" = "mode 'resize'";
        };
        modes = {
          resize = {
            # left will shrink the containers width
            # right will grow the containers width
            # up will shrink the containers height
            # down will grow the containers height
            "${left}" = "resize shrink width ${resizeAmount}";
            "${down}" = "resize grow height ${resizeAmount}";
            "${up}" = "resize shrink height ${resizeAmount}";
            "${right}" = "resize grow width ${resizeAmount}";
            ## With arrow keys
            "Left" = "resize shrink width ${resizeAmount}";
            "Down" = "resize grow height ${resizeAmount}";
            "Up" = "resize shrink height ${resizeAmount}";
            "Right" = "resize grow width ${resizeAmount}";
            # Return to default mode
            "Return" = "mode 'default'";
            "Escape" = "mode 'default'";
          };
        };
        startup = [
          # Notification daemon
          { command = "mako"; }
          # Polkit
          { command = "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"; }#
	  # wm name
	  { command = "wmname LG3D"; }
          # Idle
          #{ command = "$HOME/.config/sway/idle.sh"; }
          { command = "export _JAVA_AWT_WM_NONREPARENTING=1"; }
        ];
        terminal = pkgs.alacritty;
        window.titlebar = false;
        workspaceAutoBackAndForth = true;
        output = {
          "*" = { 
	    #bg = "${background} fit #1d2021";
	  };
          # You can get the names of your outputs by running: swaymsg -t get_outputs
  	  DVI-D-1 = {
            resolution = "1920x1080";
            position = "2970,0";
          };
          DP-1 = {
            resolution = "1920x1080";
            position = "1050,0";
          };
          HDMI-A-2 = {
            resolution = "1680x1050";
            position = "0,0";
            transform = "90";
          };        };
          #focus = "DP-1";
      };
    };
    home.packages = with pkgs; [
      tesseract4 waybar i3status-rust wmname ulauncher wofi wofi-emoji slurp grim swappy swaylock-effects notify-desktop mako libappindicator 
    ];
}
