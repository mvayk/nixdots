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
    };
in
{
    xsession.windowManager.i3 = {
        enable = true;
        # package = pkgs.i3;
        config = {
            modifier = "Mod4";
            terminal = "kitty";
            menu = "dmenu_run -fn 'Iosevka Nerd Font-14' -nb '${catppuccinMocha.bg}' -nf '${catppuccinMocha.fg}' -sb '${catppuccinMocha.blue}' -sf '${catppuccinMocha.bg}'";

            fonts = {
                names = [ "Iosevka Nerd Font" ];
                size = 14.0;
            };

            gaps = {
                inner = 2;
                outer = 2;
                smartGaps = false;
                smartBorders = "off";
            };

            colors = {
                focused = {
                    border = catppuccinMocha.magenta;
                    background = catppuccinMocha.bg;
                    text = catppuccinMocha.fg;
                    indicator = catppuccinMocha.cyan;
                    childBorder = catppuccinMocha.blue;
                };
                focusedInactive = {
                    border = catppuccinMocha.bg_alt;
                    background = catppuccinMocha.bg_alt;
                    text = catppuccinMocha.fg;
                    indicator = catppuccinMocha.bg_alt;
                    childBorder = catppuccinMocha.bg_alt;
                };
                unfocused = {
                    border = catppuccinMocha.bg_alt;
                    background = catppuccinMocha.bg_alt;
                    text = catppuccinMocha.fg;
                    indicator = catppuccinMocha.bg_alt;
                    childBorder = catppuccinMocha.bg_alt;
                };
                urgent = {
                    border = catppuccinMocha.red;
                    background = catppuccinMocha.red;
                    text = catppuccinMocha.fg;
                    indicator = catppuccinMocha.red;
                    childBorder = catppuccinMocha.red;
                };
            };

            bars = [{
                position = "top";
                statusCommand = "${pkgs.i3blocks}/bin/i3blocks";
                fonts = {
                    names = [ "Iosevka Nerd Font" ];
                    size = 12.0;
                };
                colors = {
                    background = catppuccinMocha.bg;
                    statusline = catppuccinMocha.fg;
                    separator = catppuccinMocha.bg_alt;

                    focusedWorkspace = {
                        border = catppuccinMocha.blue;
                        background = catppuccinMocha.blue;
                        text = catppuccinMocha.bg;
                    };
                    activeWorkspace = {
                        border = catppuccinMocha.bg_alt;
                        background = catppuccinMocha.bg_alt;
                        text = catppuccinMocha.fg;
                    };
                    inactiveWorkspace = {
                        border = catppuccinMocha.bg;
                        background = catppuccinMocha.bg;
                        text = catppuccinMocha.fg;
                    };
                    urgentWorkspace = {
                        border = catppuccinMocha.red;
                        background = catppuccinMocha.red;
                        text = catppuccinMocha.bg;
                    };
                };
            }];

            keybindings = let
                mod = config.xsession.windowManager.i3.config.modifier;
            in {
                "${mod}+t" = "exec ${config.xsession.windowManager.i3.config.terminal}";
                "${mod}+q" = "kill";
                "${mod}+m" = "exit";
                "${mod}+v" = "floating toggle";
                "${mod}+a" = "exec ${config.xsession.windowManager.i3.config.menu}";
                "${mod}+b" = "split toggle";
                "${mod}+f" = "fullscreen toggle";
                "${mod}+h" = "focus left";
                "${mod}+l" = "focus right";
                "Home" = "exec flameshot gui";
                "${mod}+k" = "focus up";
                "${mod}+j" = "focus down";
                "${mod}+Shift+h" = "move left";
                "${mod}+Shift+l" = "move right";
                "${mod}+Shift+k" = "move up";
                "${mod}+Shift+j" = "move down";
                "${mod}+Alt+l" = "resize grow width 10 px or 10 ppt";
                "${mod}+Alt+h" = "resize shrink width 10 px or 10 ppt";
                "${mod}+Alt+k" = "resize shrink height 10 px or 10 ppt";
                "${mod}+Alt+j" = "resize grow height 10 px or 10 ppt";
                "${mod}+1" = "workspace 1";
                "${mod}+Shift+1" = "move container to workspace 1";
                "${mod}+2" = "workspace 2";
                "${mod}+Shift+2" = "move container to workspace 2";
                "${mod}+3" = "workspace 3";
                "${mod}+Shift+3" = "move container to workspace 3";
                "${mod}+4" = "workspace 4";
                "${mod}+Shift+4" = "move container to workspace 4";
                "${mod}+5" = "workspace 5";
                "${mod}+Shift+5" = "move container to workspace 5";
                "${mod}+6" = "workspace 6";
                "${mod}+Shift+6" = "move container to workspace 6";
                "${mod}+7" = "workspace 7";
                "${mod}+Shift+7" = "move container to workspace 7";
                "${mod}+8" = "workspace 8";
                "${mod}+Shift+8" = "move container to workspace 8";
                "${mod}+9" = "workspace 9";
                "${mod}+Shift+9" = "move container to workspace 9";
                "${mod}+0" = "workspace 10";
                "${mod}+Shift+0" = "move container to workspace 10";
                "XF86AudioRaiseVolume" = "exec pamixer -i 5";
                "XF86AudioLowerVolume" = "exec pamixer -d 5";
                "XF86AudioMute" = "exec pamixer -t";
                "XF86MonBrightnessUp" = "exec brightnessctl set +10%";
                "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
                "${mod}+Shift+r" = "reload";
            };

            startup = [
                { command = "sleep 1 && feh --bg-fill ~/.wallpapers/digital.jpg"; }
                { command = "feh --bg-fill ~/.wallpapers/first.png"; }
                { command = "nm-applet"; notification = false; }
                { command = "xinput --set-prop 'libinput Accel Speed' -1.0"; notification = false; }
                { command = "xinput --set-prop 8 'libinput Accel Profile Enabled' 0, 1, 0"; }
                { command = "xinput --set-prop 8 'libinput Accel Speed' 0"; }
            ];
        };

        extraConfig = ''
            new_window none
            new_float none
            for_window [class="^.*"] border pixel 1
            for_window [class=".*"] fullscreen disable
        '';
    };

    # i3blocks configuration
    home.file.".config/i3blocks/config".text = ''
        # i3blocks config with Catppuccin Mocha theme

        separator=true
        separator_block_width=15
        font=pango:Iosevka Nerd Font Bold 11

        [cpu]
        command=echo "CPU $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f%%", usage}')"
        interval=2
        color=${catppuccinMocha.cyan}

        [memory]
        command=echo "MEM $(free -h | awk '/^Mem:/ {print $3}')"
        interval=5
        color=${catppuccinMocha.green}

        [disk]
        command=echo "DISK $(df -h / | awk 'NR==2 {print $4}')"
        interval=30
        color=${catppuccinMocha.magenta}

        [wifi]
        command=ssid=$(iw dev | grep ssid | awk '{print $2}'); if [ -z "$ssid" ]; then echo "DISCONNECTED"; else echo "$ssid"; fi
        interval=5
        color=${catppuccinMocha.blue}

        [brightness]
        command=max=$(brightnessctl max); cur=$(brightnessctl g); echo "BRI $(( cur * 100 / max ))%"
        interval=1
        color=${catppuccinMocha.yellow}

        [volume]
        command=if pamixer --get-mute | grep -q true; then echo "VOL MUTE"; else echo "VOL $(pamixer --get-volume)%"; fi
        interval=1
        color=${catppuccinMocha.orange}

        [battery]
        command=echo "BAT $(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo 'N/A')%"
        interval=10
        color=${catppuccinMocha.green}

        [date]
        command=date '+%a %b %d'
        interval=60
        color=${catppuccinMocha.magenta}

        [time]
        command=date '+%H:%M'
        interval=1
        color=${catppuccinMocha.blue}
    '';

    home.packages = with pkgs; [
    ];
}
