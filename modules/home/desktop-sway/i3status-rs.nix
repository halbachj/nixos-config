{ inputs, pkgs, ... }: {
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
        blocks = [
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
	  #{
	  #  block = "backlight";
	  #}
	  {
	    block = "sound";
	    format = "$icon $output_name{ $volume|} ";
	    #[block.mappings]
	    #"alsa_output.pci-0000_04_00.6.analog-stereo" = "Speakers"
            #"bluez_sink.AC_3E_B1_86_B2_35.a2dp_sink"     = "Bluetooth"
            #[[block.click]]
            #button = "left"
            #cmd = "pavucontrol"
	  }
	  {
	    block = "music";
	    format = " $icon {$combo.str(max_w:20) $play $next |}";
	    player = "spotify";
	  }
	  {
	    block = "battery";
	    format = "$icon $percentage {$time |}";
	  }
	  {
	    block = "net";
	    format = " $icon {$signal_strength $ssid $frequency|Wired connection} via $device ";
	  }
	  #[[block]]
	  #block = "custom"
	  #cycle = ["toggle_inputs --enable > /dev/null && echo Tablet OFF", "toggle_inputs --disable > /dev/null && echo Tablet ON"]
	  #interval = 1
	  #json = false
	  #[[block.click]]
	  #button = "left"
	  #action = "cycle"
	  {
	    block = "time";
	    interval = 6;
	    format = " $timestamp.datetime(f:'%a %d/%m %R') ";
	  }
        ];
      };
    };
  };
}
