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
            top-left = 4.0;
            top-right = 4.0;
            bottom-left = 4.0;
            bottom-right = 4.0;
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

      animations.slowdown = 1.0;
      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
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

  xdg.configFile.niri-config.enable = lib.mkForce false;

  xdg.configFile."niri/config.kdl".text =
    config.programs.niri.finalConfig + "\n" + ''include "~/.config/niri/noctalia.kdl"'';

  home.packages = [
    quickshell.packages.${pkgs.system}.default
    noctalia.packages.${pkgs.system}.default
  ];
}
