{ pkgs, config, ... }:
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
      window-decoration = false;
      background-opacity = 1.0;
      cursor-style = "block";
      theme = "dankcolors";
      adjust-cell-height = "0%";
      window-padding-x = 10;
      window-padding-y = 10;
      custom-shader-animation = "always";
      custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
    };
  };

  xdg.configFile."ghostty/shaders/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
