{...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
      rounded_corners = false;
      vim_keys = true;
      truecolor = true;
      proc_tree = false;
      proc_left = true;
      #presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
    };
  };
}
