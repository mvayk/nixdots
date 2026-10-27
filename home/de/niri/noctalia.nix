{...}: {
  imports = [../../themes/noctalia/default.nix];

  programs.niri = {
    settings = {
      environment = {
        XCURSOR_THEME = "macOS";
        XCURSOR_SIZE = "24";
        QT_QPA_PLATFORMTHEME = "qt6ct";
      };
      cursor = {
        theme = "macOS";
        size = 24;
      };
      layout = {
        gaps = 32;
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
            top-left = 20.0;
            top-right = 20.0;
            bottom-left = 20.0;
            bottom-right = 20.0;
          };
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
        {
          matches = [
            {
              app-id = "^com\\.mitchellh\\.ghostty$";
            }
          ];
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
        "End".action.spawn = [
          "noctalia"
          "msg"
          "screenshot-region"
        ];
      };
      # "sh"
      # "-c"
      # "grim -g \"$(slurp)\" - | tee ~/Documents/sync/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"

      animations.slowdown = 1.0;
      spawn-at-startup = [
        {
          command = [
            "noctalia"
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
}
