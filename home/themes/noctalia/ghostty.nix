{config, ...}: {
  imports = [../../features/ghostty.nix];

  programs.ghostty = {
    settings = {
      font-size = 16;
      theme = "noctalia";
      #custom-shader-animation = "always";
      #custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
      background-opacity = 0.6;
      window-padding-x = 10;
      window-padding-y = 10;
      cursor-style = "underline";
      font-family = "Mononoki Nerd Font Mono";
      #font-style = "Medium";
      adjust-cell-height = "+15%";
    };
  };

  xdg.configFile."ghostty/shaders/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
