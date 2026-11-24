{config, ...}: {
  imports = [../../features/ghostty.nix];

  programs.ghostty = {
    settings = {
      window-decoration = false;
      font-size = 14;
      #theme = "noctalia";
      #custom-shader-animation = "always";
      #custom-shader = "${config.xdg.configHome}/ghostty/shaders/cursor_tail.glsl";
      background-opacity = 1.0;
      #shell-integration-features = ["no-cursor"];
      shell-integration = ["zsh"];
      window-padding-x = 15;
      #window-padding-y = 15;

      #background-opacity-cells = true;
      #font-family = "Mononoki Nerd Font Mono";
      font-family = "JetBrainsMono Nerd Font Mono";
      #font-style = "Medium";
      adjust-cell-height = "+20%";
      #cursor-style = "underline";
      shell-integration-features = ["no-cursor"];
      cursor-style = "block";
      theme = "Oxocarbon";
    };
  };

  xdg.configFile."ghostty/shaders/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
