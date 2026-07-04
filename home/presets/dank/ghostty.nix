{
  pkgs,
  config,
  ...
}: {
  imports = [../../features/ghostty.nix];

  programs.ghostty = {
    enable = true;

    settings = {
      font-family = "VictorMono Nerd Font Mono";
      font-size = 16;
      window-decoration = false;
      background-opacity = 0.6;
      cursor-style = "underline";
      theme = "dankcolors";
      adjust-cell-height = "5%";
      window-padding-x = 10;
      window-padding-y = 10;
      custom-shader-animation = "always";
      custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
    };
  };

  xdg.configFile."ghostty/shaders/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
