{ config, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "VictorMono Nerd Font Mono";
      font-size = 16;
      cursor-style-blink = true;
      shell-integration = "zsh";
      keybind = "ctrl+backspace=text:\\x1b\\x7f";
      window-padding-balance = true;
      confirm-close-surface = false;
      custom-shader-animation = "always";
      theme = "IR Black";
      custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
      window-decoration = false;
      background-opacity = 0.8;
      cursor-style = "block";
      adjust-cell-height = "+0%";
      window-padding-x = 5;
      window-padding-y = 5;
    };
  };

  xdg.configFile."ghostty/shaders/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
