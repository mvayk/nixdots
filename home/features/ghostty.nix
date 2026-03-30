{
  de,
  theme,
  lib,
  ...
}:
let
  themeSettings = {
    hyprland = {
      default = {
        window-decoration = "false";
        background-opacity = "0.7";
        theme = "noctalia";
        cursor-style = "bar";
        custom-shader-animation = "always";
        custom-shader = "cursor_tail.glsl";
      };
    };
    niri = {
      dms = {
        window-decoration = "false";
        background-opacity = "0.7";
        cursor-style = "bar";
        custom-shader-animation = "always";
        custom-shader = "cursor_tail.glsl";
        theme = "dankcolors";
      };
      blackmetal = {
        window-decoration = "false";
        background-opacity = "0.8";
        cursor-style = "block";
        theme = "Black Metal";
        adjust-cell-height = "+0%";
        window-padding-x = "5";
        window-padding-y = "5";
      };
      noctalia = {
        window-decoration = "false";
        background-opacity = "0.7";
        theme = "noctalia";
        cursor-style = "block";
        custom-shader-animation = "always";
        custom-shader = "cursor_tail.glsl";
      };
      noctalia-glass = {
        window-decoration = "false";
        background-opacity = "0.7";
        theme = "noctalia";
        cursor-style = "block";
        custom-shader-animation = "always";
        custom-shader = "cursor_tail.glsl";
      };
    };
    gnome = {
      default = {
        window-decoration = "true";
        background-opacity = "1.0";
        theme = "Vercel";
        font-size = "14";
        window-padding-x = "6";
        window-padding-y = "8";
      };
    };
    kde = {
      default = {
        window-decoration = "true";
        background-opacity = "1.0";
        theme = "Vercel";
        font-size = "14";
      };
    };
    xfce = {
      default = {
        window-decoration = "true";
        background-opacity = "1.0";
      };
    };
  };
  settings = {
    font-family = "VictorMono Nerd Font Mono";
    font-size = "16";
    window-decoration = "false";
    background-opacity = "0.7";
    adjust-cell-height = "+30%";
    window-padding-x = "12";
    window-padding-y = "16";
    cursor-style-blink = "true";
    shell-integration = "zsh";
    keybind = "ctrl+backspace=text:\\x1b\\x7f";
    window-padding-balance = "true";
    confirm-close-surface = "false";
  }
  // ((themeSettings.${de} or { }).${theme} or { theme = theme; });
in
{
  xdg.configFile."ghostty/config".text = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (k: v: "${k} = ${v}") settings
  );
  xdg.configFile."ghostty/cursor_tail.glsl".source = ./ghostty/cursor_tail.glsl;
}
