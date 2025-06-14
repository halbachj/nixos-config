{ inputs, pkgs, lib, ... }: {
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        theme = "semi-native";
	      icons = "awesome4";
	      settings = {
	        icons = {
	          overrides = {
	            music = "";
	          };
	        };
	      };
        blocks = lib.mkMerge [
          ( lib.mkOrder 200 [
            {
	            block = "cpu";
	          }
	          {
	            block = "disk_space";
	            path = "/";
	            info_type = "available";
	            alert_unit = "GB";
	            interval = 20;
	            warning = 20.0;
	            alert = 10.0;
	            format = " $icon root: $available.eng(w:2) ";
	          }
	          {
              block = "memory";
	            format = " $icon  $mem_total_used_percents.eng(w:2) ";
	            format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
	          }
	          {
	            block = "sound";
	            format = "$icon $output_name{ $volume|} ";
	          }
	          {
	            block = "music";
	            format = " $icon {$combo.str(max_w:20) $play $next |}";
	            player = "spotify";
	          }
          ])
          ( lib.mkOrder 700 [
	          {
	            block = "net";
	            format = " $icon {$signal_strength $ssid $frequency|Wired connection} via $device ";
	          }
	          {
	            block = "time";
	            interval = 6;
	            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
	          }
          ])];
      };
    };
  };
}
