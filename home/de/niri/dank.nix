{pkgs, ...}: {
  imports = [../../themes/dank/default.nix];

  programs.niri = {
    settings = {
      layout = {
        gaps = 8;
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
}
