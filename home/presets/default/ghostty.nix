{config, ...}: {
  imports = [../../features/ghostty.nix];

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = 16;
      custom-shader-animation = "always";
      theme = "IR Black";
      custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
      window-decoration = false;
      background-opacity = 0.8;
      adjust-cell-height = "+0%";
      window-padding-x = 15;
      window-padding-y = 15;
      cursor-style = "underline";
    };
  };

  xdg.configFile."ghostty/shaders/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
