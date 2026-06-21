{
  pkgs,
  lib,
  noctalia,
  quickshell,
  future-hyprcursor,
  ...
}: let
  dir = ../../../../presets/noctalia;
  fileNames = builtins.attrNames (builtins.readDir dir);
  nixFiles = builtins.filter (n: lib.hasSuffix ".nix" n && n != "default.nix") fileNames;
in {
  imports =
    map (n: dir + "/${n}") nixFiles
    ++ [
      ../../../../features/fastfetch.nix
    ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  xdg.configFile."hyprland/layerrules.conf".source = ../../../../features/hyprland/layerrules.conf;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Bibata-Modern-Ice"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "noctalia-shell"
        "nm-applet"
        "hyprctl setcursor Bibata-Modern-Ice 24"
      ];

      source = "noctalia/noctalia-colors.conf";
      layerrules = "layerrules.conf";

      general = {
        gaps_in = 4;
        gaps_out = 12;
        border_size = 1;
        "col.active_border" = "$primary $secondary $tertiary 45deg";
        "col.inactive_border" = "$surface";
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
          color = "rgba(00000080)";
        };
        blur = {
          enabled = true;
          size = 15;
          passes = 4;
          vibrancy = 0.1696;
        };
      };
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

      # layerrule = [
      #   "ignorealpha 0.5,noctalia-background-.*"
      #   "blur,noctalia-background-.*"
      #   "blurpopups,noctalia-background-.*"
      # ];

      bind = [
        "$mainMod, O, exec, noctalia-shell ipc call lockScreen lock"
        ", PAUSE, exec, noctalia-shell ipc call volume muteInput"
        "$mainMod, semicolon, exec, noctalia-shell ipc call launcher emoji"
        "$mainMod, I, exec, noctalia-shell ipc call launcher calculator"
        "$mainMod, A, exec, noctalia-shell ipc call launcher toggle"
        "$mainMod, page_up,   exec, noctalia-shell ipc call volume increase"
        "$mainMod, page_down, exec, noctalia-shell ipc call volume decrease"
      ];
    };
    # extraConfig = ''
    #   layerrule {
    #     name = noctalia
    #     match:namespace = noctalia-background-.*$
    #     ignore_alpha = 0.5
    #     blur = true
    #     blur_popups = true
    #   }
    # '';
  };

  home.packages = [
    quickshell.packages.${pkgs.system}.default
    noctalia.packages.${pkgs.system}.default
    future-hyprcursor.packages.${pkgs.system}.default
  ];
}
