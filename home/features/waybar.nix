{
  pkgs,
  ...
}:

let
  bg = "rgba(0,0,0,0.8)";
  fg = "#c1c1c1";
  dim = "#888888";
  accent = "#FFFFFF";
  urgent = "#a06666";
  border = "rgba(255,255,255,0.4)";
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 28;
      spacing = 4;
      margin-top = 0;
      margin-left = 0;
      margin-right = 0;

      modules-left = [
        "niri/workspaces"
        "niri/window"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "battery"
        "tray"
      ];

      "niri/workspaces" = {
        format = "{index}";
      };

      "niri/window" = {
        max-length = 40;
        separate-outputs = true;
      };

      "clock" = {
        format = "{:%H:%M}";
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      "cpu" = {
        format = "cpu {usage}%";
        interval = 5;
      };

      "memory" = {
        format = "mem {}%";
        interval = 10;
      };

      "network" = {
        format-wifi = "{essid}";
        format-ethernet = "eth";
        format-disconnected = "off";
        tooltip-format = "{ipaddr}";
      };

      "pulseaudio" = {
        format = "vol {volume}%";
        format-muted = "muted";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };

      "battery" = {
        format = "bat {capacity}%";
        format-charging = "chr {capacity}%";
        format-full = "full";
        states = {
          warning = 30;
          critical = 15;
        };
      };

      "tray" = {
        spacing = 8;
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 12px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background: ${bg};
        color: ${fg};
        border-bottom: 1px solid ${border};
      }

      #workspaces button {
        padding: 0 8px;
        color: ${dim};
        background: transparent;
        border-bottom: 1px solid transparent;
      }

      #workspaces button.active {
        color: ${fg};
        border-bottom: 1px solid ${accent};
      }

      #workspaces button.urgent {
        color: ${urgent};
      }

      #window {
        color: ${dim};
        padding: 0 8px;
      }

      #clock {
        color: ${fg};
        padding: 0 12px;
      }

      #cpu, #memory, #network, #pulseaudio, #battery, #tray {
        color: ${dim};
        padding: 0 8px;
      }

      #battery.warning  { color: ${urgent}; }
      #battery.critical { color: #dd9999;   }

      #pulseaudio.muted { color: ${dim}; }

      tooltip {
        background: rgba(0,0,0,0.9);
        border: 1px solid ${border};
        color: ${fg};
      }
    '';
  };
}
