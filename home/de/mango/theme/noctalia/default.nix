{
  pkgs,
  lib,
  noctalia,
  config,
  ...
}: let
  dir = ../../../../presets/noctalia;
  fileNames = builtins.attrNames (builtins.readDir dir);
  nixFiles = builtins.filter (n: lib.hasSuffix ".nix" n && n != "default.nix") fileNames;
in {
  imports = map (n: dir + "/${n}") nixFiles ++ [../../../../features/fastfetch.nix];

  home.pointerCursor = {
    enable = true;
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
  };

  wayland.windowManager.mango = {
    extraConfig = ''
      source=./noctalia.conf
    '';
    settings = {
      env = [
        "XCURSOR_THEME,macOS"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];

      gap_inner_horizontal = 28;
      gap_inner_vertical = 28;
      gap_outer_horizontal = 28;
      gap_outer_vertical = 28;

      border_px = 1;
      focus_color = "0xFFFFFFFF";
      border_color = "0x000000FF";
      root_color = "0x00000000";

      border_radius = 0;

      shadows = 1;
      shadow_only_floating = 0;
      shadows_size = 5;
      shadows_blur = 4;
      shadows_position_x = 3;
      shadows_position_y = 6;
      shadows_color = "0x00000060";
      group_bar_decorate_border_width = 2;
      group_bar_height = 16;
      group_bar_decorate_corner_radius = 0;
      group_bar_decorate_font_desc = "JetBrainsMono Bold 8";

      bind = [
        "SUPER,o,spawn,noctalia msg session lock"
        "NONE,Pause,spawn,noctalia msg mic-mute"
        "SUPER,semicolon,spawn_shell,noctalia msg panel-toggle launcher \"/emo \""
        "SUPER,i,spawn_shell,noctalia msg panel-toggle launcher \"/calc \""
        "SUPER,a,spawn,noctalia msg panel-toggle launcher"
        "SUPER,Page_Up,spawn,noctalia msg volume-up"
        "SUPER,Page_Down,spawn,noctalia msg volume-down"
        "NONE,End,spawn,noctalia msg screenshot-region"
      ];

      exec_once = [
        "noctalia"
        "nm-applet"
      ];
    };
  };

  home.packages = [
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
