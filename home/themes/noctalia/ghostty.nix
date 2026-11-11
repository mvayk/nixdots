{config, ...}: {
  imports = [../../features/ghostty.nix];

  programs.ghostty = {
    settings = {
      font-size = 16;
      theme = "noctalia";
      #custom-shader-animation = "always";
      #custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
      background-opacity = 1;
      window-padding-x = 15;
      window-padding-y = 15;
      #font-family = "Mononoki Nerd Font Mono";
      font-family = "JetBrainsMono Nerd Font Mono";
      #font-style = "Medium";
      adjust-cell-height = "+15%";
      cursor-style = "underline";
    };
  };

  xdg.configFile."ghostty/shaders/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
