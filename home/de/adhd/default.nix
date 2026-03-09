{
  config,
  pkgs,
  lib,
  quickshell,
  machine,
  de,
  ...
}:
{
  imports = [
    ../../features/ghostty.nix
    ../../features/fastfetch.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      environment = {
        XDG_CURRENT_DESKTOP = "niri";
      };

      input = {
        focus-follows-mouse.enable = true;
        keyboard = {
          xkb = {
            layout = "us";
            options = "caps:escape_shifted_capslock";
          };
        };
        mouse = {
          accel-profile = "flat";
          accel-speed = 0.0;
        };
        touchpad = {
          natural-scroll = false;
          tap = true;
        };
      };

      outputs =
        if machine == "flandre" then
          {
            "HDMI-A-1" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 60.0;
              };
              position = {
                x = 0;
                y = 0;
              };
            };
            "DP-3" = {
              mode = {
                width = 2560;
                height = 1440;
                refresh = 240.001;
              };
              position = {
                x = 1920;
                y = 0;
              };
            };
            "DP-1" = {
              mode = {
                width = 2560;
                height = 1440;
                refresh = 240.001;
              };
              position = {
                x = 4480;
                y = 0;
              };
            };
          }
        else
          {
            "eDP-1" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 60.0;
              };
              position = {
                x = 0;
                y = 0;
              };
            };
          };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        background-color = "transparent";

        preset-column-widths = [
          { proportion = 0.333333; }
          { proportion = 0.5; }
          { proportion = 0.666667; }
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
          enable = false;
          offset = {
            x = 2;
            y = 3;
          };
          softness = 24;
          color = "#00000055";
        };
      };

      animations.slowdown = 0;

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      spawn-at-startup = [
        { command = [ "nm-applet" ]; }
        { command = [ "xwayland-satellite" ]; }
      ];

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
          matches = [ { app-id = "^com\\.mitchellh\\.ghostty$"; } ];
          draw-border-with-background = false;
        }
      ];

      layer-rules = [
        {
          matches = [ { namespace = "^noctalia-wallpaper"; } ];
          place-within-backdrop = false;
        }
      ];

      binds = {
        "Mod+T".action.spawn = [ "ghostty" ];
        "Mod+W".action.spawn = [ "chromium" ];
        "Mod+E".action.spawn = [ "dolphin" ];

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

        "End".action.spawn = [
          "sh"
          "-c"
          "grim -g \"$(slurp)\" - | tee ~/Documents/sync/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"
        ];
        "Mod+Shift+S".action.screenshot = { };
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };

        "Mod+Q".action.close-window = { };
        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };
        "Mod+V".action.toggle-window-floating = { };
        "Mod+R".action.switch-preset-column-width = { };

        "Mod+M".action.quit = { };

        "Mod+H".action.focus-column-left = { };
        "Mod+L".action.focus-column-right = { };
        "Mod+K".action.focus-window-up = { };
        "Mod+J".action.focus-window-down = { };

        "Mod+Shift+H".action.move-column-left = { };
        "Mod+Shift+L".action.move-column-right = { };
        "Mod+Shift+K".action.move-window-up = { };
        "Mod+Shift+J".action.move-window-down = { };

        "Mod+Ctrl+H".action.focus-monitor-left = { };
        "Mod+Ctrl+L".action.focus-monitor-right = { };
        "Mod+Ctrl+K".action.focus-monitor-up = { };
        "Mod+Ctrl+J".action.focus-monitor-down = { };
        "Mod+Shift+Ctrl+H".action.move-window-to-monitor-left = { };
        "Mod+Shift+Ctrl+L".action.move-window-to-monitor-right = { };

        "Mod+WheelScrollUp" = {
          cooldown-ms = 10;
          action.focus-column-left = { };
        };
        "Mod+WheelScrollDown" = {
          cooldown-ms = 10;
          action.focus-column-right = { };
        };
        "Mod+Shift+WheelScrollDown" = {
          cooldown-ms = 10;
          action.focus-workspace-down = { };
        };
        "Mod+Shift+WheelScrollUp" = {
          cooldown-ms = 10;
          action.focus-workspace-up = { };
        };

        "Mod+Alt+L".action.set-column-width = "+10%";
        "Mod+Alt+H".action.set-column-width = "-10%";
        "Mod+Alt+K".action.set-window-height = "-10%";
        "Mod+Alt+J".action.set-window-height = "+10%";

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        "Mod+S".action.toggle-overview = { };
      }
      // lib.optionalAttrs (machine == "laptop") {
        "XF86AudioRaiseVolume".action.spawn = [
          "pamixer"
          "--increase"
          "5"
        ];
        "XF86AudioLowerVolume".action.spawn = [
          "pamixer"
          "--decrease"
          "5"
        ];
        "XF86MonBrightnessUp".action.spawn = [
          "brightnessctl"
          "set"
          "1%+"
        ];
        "XF86MonBrightnessDown".action.spawn = [
          "brightnessctl"
          "set"
          "1%-"
        ];
      };
    };
    # dsjlfk asdjfl kdas
    # include = [ "${config.home.homeDirectory}/.config/niri/noctalia.kdl" ];
  };

  home.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 24;
  };
}
