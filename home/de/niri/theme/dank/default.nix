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

  programs.niri = {
    settings = {
      environment = {
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "24";
      };

      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 24;
      };

      layout = {
        gaps = 8;
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
            x = 2;
            y = 3;
          };
          softness = 24;
          color = "#00000055";
        };
      };

      animations.slowdown = 1.0;

      spawn-at-startup = [
        {
          command = [
            "dms"
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
          matches = [
            {
              namespace = "^noctalia-wallpaper";
            }
          ];
          place-within-backdrop = false;
        }
      ];

      binds = {
        "Mod+O".action.spawn = [
          "dms"
          "ipc"
          "call"
          "lock"
          "lock"
        ];
        "Pause".action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "micmute"
        ];
        "Mod+Semicolon".action.spawn = [
          "dms"
          "ipc"
          "call"
          "spotlight"
          "toggleQuery"
          "!"
        ];
        "Mod+A".action.spawn = [
          "dms"
          "ipc"
          "call"
          "spotlight"
          "toggle"
        ];
        "Mod+Page_Up".action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "increment"
          "5"
        ];
        "Mod+Page_Down".action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "decrement"
          "5"
        ];
      };
    };
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  home.packages = [
    pkgs.bibata-cursors
    quickshell.packages.${pkgs.system}.default
  ];
}
