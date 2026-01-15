{ config, lib, machine, ... }:
{
    global_bind = {
        mainMod = "SUPER";
    };
    wayland.windowManager.hyprland.settings = {
        "monitor" = ["HDMI-A-1, 1920x1080@60, 0x0, 1"
        "DP-3, 2560x1440@240, 1920x0, 1"
        "DP-1, 2560x1440@240, 4480x0, 1"];

        bind = [

            ", End, exec, grim -g \"$(slurp)\" - | wl-copy"

            "$mainMod, P, pseudo,"
            "$mainMod, N, togglesplit,"
            "$mainMod, F, fullscreen"
            "$mainMod, V, togglefloating,"

            "$mainMod, Q, killactive,"
            "$mainMod, M, exit,"

            "$mainMod, H, movefocus, l"
            "$mainMod, L, movefocus, r"
            "$mainMod, K, movefocus, u"
            "$mainMod, J, movefocus, d"

            "$mainMod SHIFT, H, movewindow, l"
            "$mainMod SHIFT, L, movewindow, r"
            "$mainMod SHIFT, K, movewindow, u"
            "$mainMod SHIFT, J, movewindow, d"

            "$mainMod ALT, L, resizeactive, 10 0"
            "$mainMod ALT, H, resizeactive, -10 0"
            "$mainMod ALT, K, resizeactive, 0 -10"
            "$mainMod ALT, J, resizeactive, 0 10"

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

        bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
        ];
    };
}
