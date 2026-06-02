{
  ...
}:
let
  _settings = {
    font-family = "VictorMono Nerd Font Mono";
    font-size = "16";
    cursor-style-blink = "true";
    shell-integration = "zsh";
    keybind = "ctrl+backspace=text:\\x1b\\x7f";
    window-padding-balance = "true";
    confirm-close-surface = "false";
    window-decoration = "false";
    background-opacity = "0.5";
    theme = "noctalia";
    cursor-style = "block";
    adjust-cell-height = "0%";
    window-padding-x = "10";
    window-padding-y = "10";
    custom-shader-animation = "always";
    custom-shader = "cursor_tail.glsl";
  };
in
{
  xdg.configFile."ghostty/cursor_tail.glsl".source = ../../features/ghostty/cursor_tail.glsl;
}
