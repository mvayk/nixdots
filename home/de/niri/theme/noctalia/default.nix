{
  pkgs,
  lib,
  quickshell,
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
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  programs.niri = {
    settings = {
      environment = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "24";
      };

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };
      layout = {
        gaps = 24;
        center-focused-column = "never";
        background-color = "transparent";

        focus-ring = {
          enable = false;
          width = 2;
          active.color = "#FFFFFFFF";
          inactive.color = "#000000FF";
        };

        border = {
          enable = true;
          active.color = "#FFFFFFFF";
          inactive.color = "#000000FF";
          width = 2;
        };

        shadow = {
          enable = true;
          offset = {
            x = 4;
            y = 8;
          };
          softness = 8;
          spread = 2;
          draw-behind-window = true;
          color = "#00000080";
        };
      };

      prefer-no-csd = true;
      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            {
              app-id = "^com\\.mitchellh\\.ghostty$";
            }
          ];
          draw-border-with-background = false;
        }
      ];

      layer-rules = [
        {
          place-within-backdrop = true;
        }
      ];

      binds = {
        "Mod+O".action.spawn = [
          "noctalia"
          "msg"
          "session"
          "lock"
        ];
        "Pause".action.spawn = [
          "noctalia"
          "msg"
          "mic-mute"
        ];
        "Mod+Semicolon".action.spawn = [
          "noctalia"
          "msg"
          "panel-toggle"
          "launcher"
          "/emo "
        ];
        "Mod+I".action.spawn = [
          "noctalia"
          "msg"
          "panel-toggle"
          "launcher"
          "/calc "
        ];
        "Mod+A".action.spawn = [
          "noctalia"
          "msg"
          "panel-toggle"
          "launcher"
        ];
        "Mod+Page_Up".action.spawn = [
          "noctalia"
          "msg"
          "volume-up"
        ];
        "Mod+Page_Down".action.spawn = [
          "noctalia"
          "msg"
          "volume-down"
        ];
      };

      animations.slowdown = 1.0;
      spawn-at-startup = [
        {
          command = [
            "noctalia"
          ];
        }
        {
          command = [
            "nm-applet"
          ];
        }
        {
          command = [
            "xwayland-satellite"
          ];
        }
      ];
    };
  };

  xdg.configFile.niri-config.enable = lib.mkForce false;

  xdg.configFile."niri/config.kdl".text =
    config.programs.niri.finalConfig + "\n" + ''include "~/.config/niri/noctalia.kdl"'';

  home.packages = [
    noctalia.packages.${pkgs.system}.default
  ];
}
