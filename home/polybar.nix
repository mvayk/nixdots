{ config, pkgs, ... }:
let
tokyoNight = {
    bg = "#1a1b26";
    bg_alt = "#24283b";
    fg = "#c0caf5";
    blue = "#7aa2f7";
    cyan = "#7dcfff";
    green = "#9ece6a";
    magenta = "#bb9af7";
    orange = "#ff9e64";
    red = "#f7768e";
    yellow = "#e0af68";
};
in
{
    services.polybar = {
        enable = true;
        script = ''
            pkill polybar
            sleep 1
            ${pkgs.polybar}/bin/polybar main &
            '';
        config = {
            "colors" = {
                background = tokyoNight.bg;
                background-alt = tokyoNight.bg_alt;
                foreground = tokyoNight.fg;
                primary = tokyoNight.blue;
                secondary = tokyoNight.cyan;
                alert = tokyoNight.red;
                disabled = "#565f89";
            };
            "bar/main" = {
                width = "100%";
                height = "20pt";
                radius = 0;
                background = "\${colors.background}";
                foreground = "\${colors.foreground}";
                line-size = "2pt";
                border-size = "0pt";
                border-color = "#00000000";
                padding-left = 0;
                padding-right = 1;
                module-margin = 1;
                separator = "|";
                separator-foreground = "\${colors.disabled}";
                font-0 = "Iosevka Nerd Font:size=12;2";
                modules-left = "xworkspaces xwindow";
                modules-right = "filesystem cpu memory brightness battery volume date";
                cursor-click = "pointer";
                enable-ipc = true;
                monitor = "\${env:MONITOR:}";
                override-redirect = false;
                wm-restack = "bspwm";
            };
            "module/xworkspaces" = {
                type = "internal/xworkspaces";
                label-active = "%name%";
                label-active-background = "\${colors.background-alt}";
                label-active-underline = "\${colors.primary}";
                label-active-padding = 2;
                label-active-margin = 0;
                label-occupied = "%name%";
                label-occupied-padding = 1;
                label-urgent = "%name%";
                label-urgent-background = "\${colors.alert}";
                label-urgent-padding = 2;
                label-empty = "%name%";
                label-empty-foreground = "\${colors.disabled}";
                label-empty-padding = 1;
                pin-workspaces = true;
                strip-wsnumbers = true;
                format = "<label-state>";
                format-padding = 1;
            };
            "module/xwindow" = {
                type = "internal/xwindow";
                label = "%title:0:60:...%";
            };
            "module/filesystem" = {
                type = "internal/fs";
                interval = 25;
                mount-0 = "/";
                label-mounted = "%{F#7aa2f7}/ %{F-}%percentage_used%%";
                label-unmounted = "%mountpoint% not mounted";
                label-unmounted-foreground = "\${colors.disabled}";
            };
            "module/volume" = {
                type = "internal/pulseaudio";
                use-ui-max = true;
                interval = 5;
                reverse-scroll = false;
                format-volume = "<ramp-volume> <label-volume> ";
                format-volume-foreground = "\${colors.primary}";
                label-volume = "%percentage%%";
                label-volume-foreground = "\${colors.foreground}";
                ramp-volume-0 = "憎";
                ramp-volume-1 = "愈";
                ramp-volume-2 = "慎";
                ramp-volume-3 = "惘";
                ramp-volume-4 = "徭";
                format-muted = "<label-muted>";
                label-muted = "婢 Muted";
                label-muted-foreground = "\${colors.disabled}";
                click-left = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                click-right = "pavucontrol";
                scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
                scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
            };
            "module/brightness" = {
                type = "internal/backlight";
                format = "BRG <label>";
                format-foreground = "\${colors.primary}";
                label = "%percentage%%";
                label-foreground = "\${colors.foreground}";
                click-right = "brightnessctl set 50%";
                scroll-up = "brightnessctl set +5%";
                scroll-down = "brightnessctl set 5%-";
            };
            "module/memory" = {
                type = "internal/memory";
                interval = 2;
                format-prefix = "RAM ";
                format-prefix-foreground = "\${colors.primary}";
                label = "%percentage_used:2%%";
                label-foreground = "\${colors.foreground}";
            };
            "module/cpu" = {
                type = "internal/cpu";
                interval = 2;
                format-prefix = "CPU ";
                format-prefix-foreground = "\${colors.primary}";
                label = "%percentage:2%%";
                label-foreground = "\${colors.foreground}";
            };

            "module/battery" = {
                type = "internal/battery";
                battery = "BAT0";
                adapter = "AC";
                full-at = 98;
                time-format = "%H:%M";
                format-charging = "BAT <label-charging>";
                format-charging-foreground = "\${colors.primary}";
                format-discharging = "BAT <label-discharging>";
                format-discharging-foreground = "\${colors.foreground}";
                format-full = "BAT <label-full>";
                format-full-foreground = "\${colors.secondary}";
                label-charging = "%percentage%% %time%";
                label-discharging = "%percentage%% %time%";
                label-full = "%percentage%%";
                poll-interval = 5;
            };

            "module/date" = {
                type = "internal/date";
                interval = 1;
                time = "%H:%M";
                time-alt = "%Y-%m-%d %H:%M:%S";
                date = "%a %d %b";
                date-alt = "%Y-%m-%d";
                label = "%date% %{F#7aa2f7}%time%%{F-}";
                label-foreground = "\${colors.primary}";
                click-left = "alacritty -e calcurse";
            };
            "settings" = {
                screenchange-reload = true;
                pseudo-transparency = false;
            };
        };
    };
    home.packages = with pkgs; [
        brightnessctl
        pavucontrol
        # Added for better battery monitoring (optional)
        acpi
    ];
}
