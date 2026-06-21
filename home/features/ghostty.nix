{config, ...}: {
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
      #custom-shader-animation = "always";
      theme = "Gruvbox";
      #custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
      #background-opacity = 0.6;
      adjust-cell-height = "+0%";
      cursor-style = "underline";
    };
  };
}
