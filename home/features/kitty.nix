{config, ...}: {
  programs.kitty = {
    enable = true;
    font.name = "ComicShannsMono Nerd Font";
    font.size = 16;
    shellIntegration.mode = "no-cursor";
    keybindings = {
      "ctrl+backspace" = "send_text all \\x1b\\x7f";
    };
    settings = {
      cursor_shape = "beam";
      background_opacity = "0.9";
      cursor_blink_interval = "-1";
      confirm_os_window_close = 0;
      placement_strategy = "center";
      # modify_font = "cell_height 110%";
    };
  };
}
