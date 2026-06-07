{
  pkgs,
  lib,
  mshell,
  ...
}:
let
  dir = ../../../../presets/default;
  fileNames = builtins.attrNames (builtins.readDir dir);
  nixFiles = builtins.filter (n: lib.hasSuffix ".nix" n && n != "default.nix") fileNames;
in
{
  imports = map (n: dir + "/${n}") nixFiles ++ [ ];

  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 48;
  };

  programs.niri = {
    package = pkgs.niri;
    settings = {
      environment = {
        XCURSOR_THEME = "macOS";
        XCURSOR_SIZE = "48";
      };

      cursor = {
        theme = "macOS";
        size = 48;
      };
      layout = {
        gaps = 18;
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
          width = 1;
        };

        shadow = {
          enable = true;
          offset = {
            x = 0;
            y = 0;
          };
          softness = 18;
          color = "#FFFFFF33";
        };
      };

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

      animations.slowdown = 1.0;
      spawn-at-startup = [
        {
          command = [
            "awww-daemon"
          ];
        }
        {
          command = [
            "qs"
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

  home.packages = [
    pkgs.awww
    pkgs.wallust
    mshell.packages.${pkgs.system}.default
  ];
}
