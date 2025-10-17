{ config, pkgs, ... }:
let
    catppuccinMocha = {
        bg = "#1e1e2e";
        bg_alt = "#313244";
        fg = "#cdd6f4";
        blue = "#89b4fa";
        cyan = "#89dceb";
        green = "#a6e3a1";
        magenta = "#cba6f7";
        orange = "#fab387";
        red = "#f38ba8";
        yellow = "#f9e2af";
        surface0 = "#313244";
        surface1 = "#45475a";
        surface2 = "#585b70";
    };
in
{
    services.dunst = {
        enable = true;
        settings = {
            global = {
                monitor = 0;
                follow = "mouse";
                width = 300;
                height = 300;
                origin = "top-right";
                offset = "10x50";
                scale = 0;
                notification_limit = 5;
                
                progress_bar = true;
                progress_bar_height = 10;
                progress_bar_frame_width = 1;
                progress_bar_min_width = 150;
                progress_bar_max_width = 300;
                
                indicate_hidden = true;
                transparency = 0;
                separator_height = 2;
                padding = 12;
                horizontal_padding = 12;
                text_icon_padding = 0;
                frame_width = 2;
                frame_color = catppuccinMocha.blue;
                gap_size = 5;
                separator_color = "frame";
                sort = true;
                
                font = "Iosevka Nerd Font 14";
                line_height = 0;
                markup = "full";
                format = "<b>%s</b>\\n%b";
                alignment = "left";
                vertical_alignment = "center";
                show_age_threshold = 60;
                ellipsize = "middle";
                ignore_newline = false;
                stack_duplicates = true;
                hide_duplicate_count = false;
                show_indicators = true;
                
                icon_position = "left";
                min_icon_size = 32;
                max_icon_size = 48;
                icon_path = "/usr/share/icons/Papirus-Dark/16x16/status/:/usr/share/icons/Papirus-Dark/16x16/devices/:/usr/share/icons/Papirus-Dark/16x16/actions/";
                
                sticky_history = true;
                history_length = 20;
                
                dmenu = "${pkgs.dmenu}/bin/dmenu -p dunst:";
                browser = "${pkgs.firefox}/bin/firefox --new-tab";
                
                always_run_script = true;
                title = "Dunst";
                class = "Dunst";
                corner_radius = 8;
                ignore_dbusclose = false;
                
                force_xwayland = false;
                force_xinerama = false;
                
                mouse_left_click = "close_current";
                mouse_middle_click = "do_action, close_current";
                mouse_right_click = "close_all";
            };
            
            experimental = {
                per_monitor_dpi = false;
            };
            
            urgency_low = {
                background = catppuccinMocha.bg;
                foreground = catppuccinMocha.fg;
                frame_color = catppuccinMocha.blue;
                timeout = 5;
            };
            
            urgency_normal = {
                background = catppuccinMocha.bg;
                foreground = catppuccinMocha.fg;
                frame_color = catppuccinMocha.blue;
                timeout = 10;
            };
            
            urgency_critical = {
                background = catppuccinMocha.bg;
                foreground = catppuccinMocha.fg;
                frame_color = catppuccinMocha.red;
                timeout = 0;
            };
        };
    };
}
