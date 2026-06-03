{
  pkgs,
  lib,
  ...
}:
let
  dir = ../../../../presets/blackmetal;
  fileNames = builtins.attrNames (builtins.readDir dir);
  nixFiles = builtins.filter (n: lib.hasSuffix ".nix" n && n != "default.nix") fileNames;
in
{
  imports = map (n: dir + "/${n}") nixFiles ++ [
    ../../../../features/fastfetch.nix
  ];
  home.pointerCursor = {
    package = pkgs.openzone-cursors;
    name = "OpenZone_Black_Slim";
    size = 24;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,OpenZone_Black_Slim"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "swww-daemon"
        "dunst"
        "nm-applet"
        "xwayland-satellite"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 12;
        border_size = 1;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 1;
        rounding_power = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 24;
          render_power = 4;
          color = "rgba(00000055)";
        };
        blur = {
          enabled = false;
        };
      };
      animations = {
        enabled = false;
      };

      bind = [
        "$mainMod, semicolon, exec, rofi dmenu p dunst"
        ", PAUSE, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE toggle"
        "$mainMod, A, exec, rofi -show drun"
        "$mainMod, page_up,   exec, pamixer --increase 5"
        "$mainMod, page_down, exec, pamixer --decrease 5"
      ];
    };
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  home.packages = with pkgs; [
    tela-icon-theme
    openzone-cursors
    waybar
    rofi
    swww
    dunst
    pamixer
    wireplumber
  ];
}
