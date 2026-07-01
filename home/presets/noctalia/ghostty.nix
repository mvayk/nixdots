{config, ...}: {
  imports = [../../features/ghostty.nix];
  programs.ghostty = {
    enable = true;
    settings = {
      #font-family = "VictorMono Nerd Font Mono";
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = 14;
      custom-shader-animation = "always";
      theme = "noctalia";
      custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
      window-decoration = false;
      background-opacity = 1;
      adjust-cell-height = "+4%";
      window-padding-x = 15;
      window-padding-y = 15;
      cursor-style = "underline";
    };
  };

  xdg.configFile."ghostty/shaders/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
