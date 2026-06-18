{ config, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      #font-family = "VictorMono Nerd Font Mono";
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = 16;
      cursor-style-blink = true;
      shell-integration = "zsh";
      shell-integration-features = "no-cursor";
      keybind = "ctrl+backspace=text:\\x1b\\x7f";
      window-padding-balance = true;
      confirm-close-surface = false;
      custom-shader-animation = "always";
      theme = "noctalia";
      #custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
      window-decoration = false;
      background-opacity = 1;
      adjust-cell-height = "+0%";
      window-padding-x = 15;
      window-padding-y = 15;
      cursor-style = "underline";
    };
  };

  xdg.configFile."ghostty/shaders/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
