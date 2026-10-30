{config, ...}: {
  programs.kitty = {
    font.name = "Terminess Nerd Font Mono";
    font.size = 14;
    shellIntegration.mode = "no-cursor";
    keybindings = {
      "ctrl+backspace" = "send_text all \\x1b\\x7f";
    };
    settings = {
      cursor_shape = "beam";
      background_opacity = "1";
      cursor_blink_interval = "1";
      confirm_os_window_close = 0;
      placement_strategy = "center";
    };
  };
}
