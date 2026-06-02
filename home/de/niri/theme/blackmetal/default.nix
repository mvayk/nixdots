{
  pkgs,
  lib,
  ...
}:
let
  dir = ../../../../presets/noctalia-glass;
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

  programs.niri = {
    settings = {
      environment = {
        XCURSOR_THEME = "OpenZone_Black_Slim";
        XCURSOR_SIZE = "24";
      };

      cursor = {
        theme = "OpenZone_Black_Slim";
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

      animations.slowdown = 0.5;

      spawn-at-startup = [
        {
          command = [
            "dunst"
          ];
        }
        {
          command = [
            "swww-daemon"
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

      binds = {
        "Mod+A".action.spawn = [
          "rofi"
          "-show"
          "drun"
        ];
        "Mod+Semicolon".action.spawn = [
          "rofi"
          "-dmenu"
          "p"
          "dunst"
        ];
        "Pause".action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];

        "Mod+Page_Up".action.spawn = [
          "pamixer"
          "--increase"
          "5"
        ];
        "Mod+Page_Down".action.spawn = [
          "pamixer"
          "--decrease"
          "5"
        ];
      };

      prefer-no-csd = true;
      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 0.0;
            top-right = 0.0;
            bottom-left = 0.0;
            bottom-right = 0.0;
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
