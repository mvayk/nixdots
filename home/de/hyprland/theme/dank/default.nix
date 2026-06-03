{
  pkgs,
  quickshell,
  lib,
  ...
}:
let
  dir = ../../../../presets/dank;
  fileNames = builtins.attrNames (builtins.readDir dir);
  nixFiles = builtins.filter (n: lib.hasSuffix ".nix" n && n != "default.nix") fileNames;
in
{
  imports = map (n: dir + "/${n}") nixFiles ++ [
    ../../../../features/fastfetch.nix
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "dms"
        "nm-applet"
        "hyprctl setcursor Bibata-Modern-Classic 24"
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
        rounding = 20;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 24;
          render_power = 4;
          color = "rgba(00000055)";
        };
        blur = {
          enabled = true;
          size = 15;
          passes = 4;
          vibrancy = 0.1696;
        };
      };

      layout = "dms/layout.conf";
      source = "dms/colors.conf";

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 5, wind, slidevert"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      bind = [
        "$mainMod, O, exec, dms ipc call lock lock"
        ", PAUSE, exec, dms ipc call audio micmute"
        "$mainMod, semicolon, exec, dms ipc call spotlight toggleQuery !"
        "$mainMod, A, exec, dms ipc call spotlight toggle"
        "$mainMod, page_up,   exec, dms ipc call audio increment 5"
        "$mainMod, page_down, exec, dms ipc call audio decrement 5"
      ];
    };
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  home.packages = [
    quickshell.packages.${pkgs.system}.default
  ];
}
