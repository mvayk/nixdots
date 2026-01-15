{ config, lib, machine, ... }:
{
    global_bind = {
        mainMod = "ALT";
    };
    home.file = {
        ".config/hypr/scripts/decrease_brightness.sh" = {
            source = ../../modules/hyprland/scripts/decrease_brightness.sh;
            executable = true;
        };
        ".config/hypr/scripts/increase_brightness.sh" = {
            source = ../../modules/hyprland/scripts/increase_brightness.sh;
            executable = true;
        };
        ".config/hypr/scripts/decrease_volume.sh" = {
            source = ../../modules/hyprland/scripts/decrease_volume.sh;
            executable = true;
        };
        ".config/hypr/scripts/increase_volume.sh" = {
            source = ../../modules/hyprland/scripts/increase_volume.sh;
            executable = true;
        };
        ".config/hypr/scripts/night_light.sh" = {
            source = ../../modules/hyprland/scripts/night_light.sh;
            executable = true;
        };
        ".config/hypr/scripts/stop_night_light.sh" = {
            source = ../../modules/hyprland/scripts/stop_night_light.sh;
            executable = true;
        };
    };

    wayland.windowManager.hyprland.settings = {
        "$mainMod" = "ALT";
        "monitor" = "eDP-1, 1920x1080@60, 0x0, 1";

        bind = [
            ",XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/increase_volume.sh"
            ",XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/decrease_volume.sh"
            ",XF86MonBrightnessUp, exec, ~/.config/hypr/scripts/increase_brightness.sh"
            ",XF86MonBrightnessDown, exec, ~/.config/hypr/scripts/decrease_brightness.sh"
            "$mainMod, O, exec, noctalia-shell ipc call lockScreen lock"
            ", PAUSE, exec, noctalia-shell ipc call volume muteInput"
            "$mainMod, semicolon, exec, noctalia-shell ipc call launcher emoji"
            "$mainMod, I, exec, noctalia-shell ipc call launcher calculator"
            "$mainMod, T, exec, $terminal"
            "$mainMod, W, exec, zen-beta"
            "$mainMod, Q, killactive,"
            "$mainMod, M, exit,"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, V, togglefloating,"
            "$mainMod, A, exec, noctalia-shell ipc call launcher toggle"
            "$mainMod, page_up, exec, noctalia-shell ipc call volume increase"
            "$mainMod, page_down, exec, noctalia-shell ipc call volume decrease"
            "$mainMod, P, pseudo,"
            "$mainMod, N, togglesplit,"
            "$mainMod, F, fullscreen"

            ", End, exec, grim -g \"$(slurp)\" - | wl-copy"

            "$mainMod, H, movefocus, l"
            "$mainMod, L, movefocus, r"
            "$mainMod, K, movefocus, u"
            "$mainMod, J, movefocus, d"

            "$mainMod SHIFT, H, movewindow, l"
            "$mainMod SHIFT, L, movewindow, r"
            "$mainMod SHIFT, K, movewindow, u"
            "$mainMod SHIFT, J, movewindow, d"

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
            "$mainMod, mouse_up, workspace, e-1"
        ];

        bindl = [
            ", switch::Lid Switch, exec, hyprlock && systemctl suspend"
        ];

        bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
        ];
    };
}
