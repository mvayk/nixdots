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
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "dmenu_run -fn 'Iosevka Nerd Font-14' -nb '${tokyoNight.bg}' -nf '${tokyoNight.fg}' -sb '${tokyoNight.blue}' -sf '${tokyoNight.bg}'";
      
      fonts = {
        names = [ "Iosevka Nerd Font" ];
        size = 12.0;
      };
      
      gaps = {
        inner = 2;
        outer = 2;
        smartGaps = false;
        smartBorders = "on";
      };
      
      colors = {
        focused = {
          border = tokyoNight.blue;
          background = tokyoNight.bg;
          text = tokyoNight.fg;
          indicator = tokyoNight.cyan;
          childBorder = tokyoNight.blue;
        };
        focusedInactive = {
          border = tokyoNight.bg_alt;
          background = tokyoNight.bg_alt;
          text = tokyoNight.fg;
          indicator = tokyoNight.bg_alt;
          childBorder = tokyoNight.bg_alt;
        };
        unfocused = {
          border = tokyoNight.bg_alt;
          background = tokyoNight.bg_alt;
          text = tokyoNight.fg;
          indicator = tokyoNight.bg_alt;
          childBorder = tokyoNight.bg_alt;
        };
        urgent = {
          border = tokyoNight.red;
          background = tokyoNight.red;
          text = tokyoNight.fg;
          indicator = tokyoNight.red;
          childBorder = tokyoNight.red;
        };
      };
      
      bars = [{
        position = "top";
        statusCommand = "${pkgs.i3blocks}/bin/i3blocks";
        fonts = {
          names = [ "Iosevka Nerd Font" ];
          size = 11.0;
        };
        colors = {
          background = tokyoNight.bg;
          statusline = tokyoNight.fg;
          separator = tokyoNight.bg_alt;
          
          focusedWorkspace = {
            border = tokyoNight.blue;
            background = tokyoNight.blue;
            text = tokyoNight.bg;
          };
          activeWorkspace = {
            border = tokyoNight.bg_alt;
            background = tokyoNight.bg_alt;
            text = tokyoNight.fg;
          };
          inactiveWorkspace = {
            border = tokyoNight.bg;
            background = tokyoNight.bg;
            text = tokyoNight.fg;
          };
          urgentWorkspace = {
            border = tokyoNight.red;
            background = tokyoNight.red;
            text = tokyoNight.bg;
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
        "Ctrl+e" = "exec i3-msg nop";
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
    # i3blocks config with Tokyo Night theme
    
    separator=true
    separator_block_width=15
    markup=pango
    font=Iosevka Nerd Font 11
    
    [cpu]
    command=echo "CPU $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f%%", usage}')"
    interval=2
    color=${tokyoNight.cyan}
    
    [memory]
    command=echo "MEM $(free -h | awk '/^Mem:/ {print $3}')"
    interval=5
    color=${tokyoNight.green}
    
    [disk]
    command=echo "DISK $(df -h / | awk 'NR==2 {print $4}')"
    interval=30
    color=${tokyoNight.magenta}
    
    [wifi]
    command=ssid=$(iw dev | grep ssid | awk '{print $2}'); if [ -z "$ssid" ]; then echo "DISCONNECTED"; else echo "$ssid"; fi
    interval=5
    color=${tokyoNight.blue}
    
    [brightness]
    command=max=$(brightnessctl max); cur=$(brightnessctl g); echo "BRI $(( cur * 100 / max ))%"
    interval=1
    color=${tokyoNight.yellow}
    
    [volume]
    command=if pamixer --get-mute | grep -q true; then echo "VOL MUTE"; else echo "VOL $(pamixer --get-volume)%"; fi
    interval=1
    color=${tokyoNight.orange}
    
    [battery]
    command=echo "BAT $(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo 'N/A')%"
    interval=10
    color=${tokyoNight.green}
    
    [date]
    command=date '+%a %b %d'
    interval=60
    color=${tokyoNight.magenta}
    
    [time]
    command=date '+%H:%M'
    interval=1
    color=${tokyoNight.blue}
  '';
  
  home.packages = with pkgs; [
  ];
}
