
{ de, lib, ... }:
let
  deSettings = {
    hyprland = {
      window-decoration = "false";
      background-opacity = "0.7";
      theme = "noctalia";
    };
    gnome = {
      window-decoration = "true";
      background-opacity = "1.0";
      theme = "Vercel";
      font-size = "14";
    };
    kde = {
      window-decoration = "true";
      background-opacity = "1.0";
    };
    xfce = {
      window-decoration = "true";
      background-opacity = "1.0";
    };
  };
  settings = {
    font-family = "VictorMono Nerd Font Mono";
    font-size = "16";
    window-decoration = "false";
    background-opacity = "0.7";
    adjust-cell-height = "+20%";
    window-padding-x = "12";
    window-padding-y = "16";
    cursor-style = "bar";
    cursor-style-blink = "true";
    shell-integration = "zsh";
    keybind = "ctrl+backspace=text:\\x1b\\x7f";
    window-padding-balance = "true";
    confirm-close-surface = "false";
    custom-shader-animation = "always";
    custom-shader = "cursor_tail.glsl";
  }
  // (deSettings.${de} or { });
in
{
  xdg.configFile."ghostty/config".text = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (k: v: "${k} = ${v}") settings
  );
  xdg.configFile."ghostty/cursor_tail.glsl".source = ./shaders/cursor_tail.glsl;
}
