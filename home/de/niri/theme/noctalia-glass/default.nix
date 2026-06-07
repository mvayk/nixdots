{
  pkgs,
  noctalia,
  quickshell,
  lib,
  ...
}:
let
  dir = ../../../../presets/noctalia-glass;
  fileNames = builtins.attrNames (builtins.readDir dir);
  nixFiles = builtins.filter (n: lib.hasSuffix ".nix" n && n != "default.nix") fileNames;
in
{
  imports = map (n: dir + "/${n}") nixFiles ++ [ ];

  home.pointerCursor = {
    package = pkgs.google-cursor;
    name = "GoogleDot-White";
    size = 24;
  };

  programs.niri = {
    package = pkgs.niri;
    settings = {
      environment = {
        XCURSOR_THEME = "GoogleDot-White";
        XCURSOR_SIZE = "24";
      };

      cursor = {
        theme = "GoogleDot-White";
        size = 24;
      };

      layout = {
        gaps = 14;
        center-focused-column = "never";
        background-color = "transparent";

        preset-column-widths = [
          {
            proportion = 0.333333;
          }
          {
            proportion = 0.5;
          }
          {
            proportion = 0.666667;
          }
        ];

        default-column-width = {
          proportion = 0.5;
        };

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
          width = 1;
        };

        shadow = {
          enable = true;
          offset = {
            x = 3;
            y = 4;
          };
          softness = 24;
          color = "#00000055";
        };
      };

      animations.slowdown = 1.0;

      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
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

      prefer-no-csd = true;
      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 20.0;
            top-right = 20.0;
            bottom-left = 20.0;
            bottom-right = 20.0;
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
          "noctalia-shell"
          "ipc"
          "call"
          "lockScreen"
          "lock"
        ];
        "Pause".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "muteInput"
        ];
        "Mod+Semicolon".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "emoji"
        ];
        "Mod+I".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "calculator"
        ];
        "Mod+A".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "toggle"
        ];
        "Mod+Page_Up".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "increase"
        ];
        "Mod+Page_Down".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "decrease"
        ];
      };
    };
  };
  home.packages = [
    quickshell.packages.${pkgs.system}.default
    noctalia.packages.${pkgs.system}.default
  ];
}
