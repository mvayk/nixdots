{
  lib,
  ...
}:
let
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
  };
in
{
  xdg.configFile."ghostty/config".text = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (k: v: "${k} = ${v}") settings
  );
  xdg.configFile."ghostty/cursor_tail.glsl".source = ./ghostty/cursor_tail.glsl;
}
