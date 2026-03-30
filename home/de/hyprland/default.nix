{
  config,
  pkgs,
  lib,
  machine,
  theme,
  de,
  ...
}:

let
  toggleGaps = pkgs.writeShellScriptBin "toggle-gaps" ''
    ROUNDING=$(hyprctl getoption decoration:rounding | grep "int:" | awk '{print $2}')
    if [ "$ROUNDING" -eq 0 ]; then
      hyprctl keyword general:gaps_out 8
      hyprctl keyword general:gaps_in 2
      hyprctl keyword decoration:rounding 10
      hyprctl keyword decoration:rounding_power 2
    else
      hyprctl keyword general:gaps_out 0
      hyprctl keyword general:gaps_in 0
      hyprctl keyword decoration:rounding 0
      hyprctl keyword decoration:rounding_power 1
    fi
  '';
in
{
  imports = [
    ./theme/${theme}/default.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
      ];

      exec-once = [
      ];

      input = {
        kb_layout = "us";
        kb_options = "caps:escape_shifted_capslock";
        accel_profile = "flat";
        force_no_accel = 1;
        follow_mouse = 1;
        sensitivity = 3;
        touchpad.natural_scroll = false;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      windowrule = [
        "immediate on, match:class ^(osu!)$"
      ];

      bind = [
        "$mainMod, M, exit,"
        "$mainMod, E, exec, dolphin"
        "$mainMod, T, exec, ghostty"
        "$mainMod, W, exec, firefox"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, N, togglesplit,"
        "$mainMod, F, fullscreen"
        "$mainMod, G, exec, ${toggleGaps}/bin/toggle-gaps"
        "$mainMod, Q, killactive,"
        ", End, exec, grim -g \"$(slurp)\" - | tee ~/Documents/sync/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"

        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        "$mainMod ALT, L, resizeactive,  10 0"
        "$mainMod ALT, H, resizeactive, -10 0"
        "$mainMod ALT, K, resizeactive, 0 -10"
        "$mainMod ALT, J, resizeactive, 0  10"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up,   workspace, e-1"
      ]
      ++ lib.optionals (machine == "laptop") [
        ",XF86AudioRaiseVolume,  exec, pamixer --increase 5"
        ",XF86AudioLowerVolume,  exec, pamixer --decrease 5"
        ",XF86MonBrightnessUp,   exec, brightnessctl set 1%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 1%-"
      ];

      bindl = lib.optionals (machine == "laptop") [
        ", switch::Lid Switch, exec, hyprlock && systemctl suspend"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      monitor =
        if machine == "flandre" then
          [
            "HDMI-A-1, 1920x1080@60,  0x0,    1"
            "DP-3,     2560x1440@240, 1920x0, 1"
            "DP-1,     2560x1440@240, 4480x0, 1"
          ]
        else
          [
            "eDP-1, 1920x1080@60, 0x0, 1"
          ];

      workspace = lib.optionals (machine == "flandre") [
        "1, monitor:HDMI-A-1, gapsin:0, gapsout:0, bordersize:0, rounding:false, decorate:false"
      ];
    };
  };

  home.packages = with pkgs; [
  ];
}
