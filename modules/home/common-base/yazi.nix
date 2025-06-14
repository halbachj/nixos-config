_: {
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      mgr = {
        ratio = [
          0
          1
          1
        ];
        sort_by = "natural";
        sort_dir_first = true;
        show_hidden = true;
        show_symlink = true;
      };
    };
  };
}

