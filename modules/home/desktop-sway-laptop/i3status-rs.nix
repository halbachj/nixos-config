{ inputs, pkgs, lib, ... }: {
  programs.i3status-rust = {
    bars = {
      default = {
        blocks = lib.mkMerge[
	        (lib.mkOrder 500 [{
	          block = "backlight";
	        }
	        {
	          block = "battery";
	          format = "$icon $percentage {$time |}";
	        }])];
      };
    };
  };
}
