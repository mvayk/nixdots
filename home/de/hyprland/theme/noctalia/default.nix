{
  pkgs,
  lib,
  noctalia,
  ...
}: let
  dir = ../../../../presets/noctalia;
  fileNames = builtins.attrNames (builtins.readDir dir);
  nixFiles = builtins.filter (n: lib.hasSuffix ".nix" n && n != "default.nix") fileNames;
in {
  imports = map (n: dir + "/${n}") nixFiles ++ [../../../../features/fastfetch.nix];

  # vibed from niri to hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";

      # niri: include "~/.config/niri/noctalia.kdl"
      # hyprland: source the noctalia-generated colors (path relative to ~/.config/hypr)
      # NOTE: your old config also had `layerrules = "layerrules.conf"`, which isn't a real
      # hyprland key. Sourcing it here instead (see xdg.configFile below).

      exec-once = [
        "noctalia"
        "nm-applet"
        # xwayland-satellite: not needed, Hyprland has built-in XWayland.
      ];

      general = {
        # niri: gaps = 32
        # niri's gap is the space *between* windows, while hyprland's gaps_in is per-window
        # (so between windows = 2 * gaps_in). gaps_out is the distance from the screen edge.
        gaps_in = 16;
        gaps_out = 32;

        # niri: border { enable = true; width = 2; }
        border_size = 2;
        "col.active_border" = "rgba(ffffffff)";
        "col.inactive_border" = "rgba(000000ff)";

        # niri: layout.center-focused-column = "never"
        # Closest hyprland equivalent to niri's scrolling columns is the "scrolling"
        # layout (Hyprland >= 0.48). It has no direct center-focused-column "never"
        # option, so check the `scrolling { ... }` section (focus_fit_method,
        # follow_focus) if columns don't behave how you want. Use "dwindle" for the old behavior.
        layout = "dwindle";
      };

      # niri: layout.focus-ring (enable = false)
      # Hyprland has no separate focus ring, only the border above, so nothing to set.

      # niri: layout.background-color = "transparent"
      # Not directly replicable. Hyprland draws the wallpaper/background via
      # layer-shell (noctalia handles that), and there's no per-layout background color.

      # niri: prefer-no-csd = true
      # Hyprland has no server-side-decoration toggle. It never draws titlebars, and
      # whether a client draws CSD is up to the client itself.

      decoration = {
        # niri window-rule: geometry-corner-radius = 10, clip-to-geometry = true
        # Hyprland rounding clips window content to the rounded corners by default.
        rounding = 10;

        # niri window-rule: draw-border-with-background = false
        # No equivalent in hyprland.

        # niri: layout.shadow
        shadow = {
          enabled = true;
          # niri softness = 8, spread = 2 -> hyprland only has `range` (roughly
          # softness + spread). Tweak by eye.
          range = 10;
          render_power = 3;
          # offset x = 4, y = 8
          offset = "4 8";
          # draw-behind-window = true: hyprland shadows always render behind the window.
          color = "rgba(00000045)";
        };
      };

      # niri window-rule matching ^com\.mitchellh\.ghostty$ (empty rule, no properties set)
      # Nothing to port. If you add properties later, hyprland syntax depends on your
      # version (0.53+ uses `windowrule = <effect>, match:class ^com\.mitchellh\.ghostty$`,
      # older uses `windowrulev2 = <effect>, class:^(com\.mitchellh\.ghostty)$`).

      # niri layer-rule: place-within-backdrop = true
      # No equivalent. Hyprland doesn't have a separate backdrop layer, and
      # wallpaper layers already render below windows. Any layer-specific tweaks
      # (blur, ignorezero, etc.) belong in layerrules.conf, sourced above.

      # niri: animations.slowdown = 1.0
      # No global slowdown in hyprland. Speeds are set per animation, and
      # defaults are left untouched here.
      animations.enabled = true;

      source = [
        "noctalia.conf"
        "layerrules.conf"
      ];

      bind = [
        "$mainMod, O, exec, noctalia msg session lock"
        ", Pause, exec, noctalia msg mic-mute"
        "$mainMod, Semicolon, exec, noctalia msg panel-toggle launcher '/emo '"
        "$mainMod, I, exec, noctalia msg panel-toggle launcher '/calc '"
        "$mainMod, A, exec, noctalia msg panel-toggle launcher"
        "$mainMod, Page_Up, exec, noctalia msg volume-up"
        "$mainMod, Page_Down, exec, noctalia msg volume-down"
      ];
    };
  };

  xdg.configFile."hypr/layerrules.conf".source = ../../../../features/hyprland/layerrules.conf;

  home.packages = [
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
