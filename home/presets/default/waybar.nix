{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 12;

        modules-left = ["niri/workspaces"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "battery" "tray"];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };

        clock = {
          format = "{:%H:%M   %a %d %b}";
          tooltip-format = "{:%Y-%m-%d}";
        };

        cpu = {
          format = " {usage}%";
          interval = 5;
        };

        memory = {
          format = " {}%";
          interval = 5;
        };

        battery = {
          format = "{icon} {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "⚠ Disconnected";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        background-color: transparent;
        color: #ffffff;
      }

      #workspaces,
      #clock,
      #cpu,
      #memory,
      #battery,
      #network,
      #pulseaudio,
      #tray {
        background: transparent;
        background-color: transparent;
        padding: 0 8px;
        border: none;
        box-shadow: none;
      }

      #workspaces button {
        background: transparent;
        color: #aaaaaa;
        padding: 0 5px;
        border: none;
        box-shadow: none;
      }

      #workspaces button.active {
        color: #ffffff;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
    '';
  };
}
