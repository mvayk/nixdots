{ config, pkgs, machine, ... }:
{
    imports = [
        ./${machine}-override.nix
    ];
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            env = [
                "XDG_CURRENT_DESKTOP,Hyprland"
                "XCURSOR_SIZE,24"
                "HYPRCURSOR_SIZE,24"
            ];

            input = {
                kb_layout = "us";
                kb_variant = "";
                kb_model = "";
                kb_options = "";
                kb_rules = "";
                accel_profile = "flat";
                force_no_accel = 1;
                follow_mouse = 1;
                sensitivity = 3;

                touchpad = {
                    natural_scroll = false;
                };
            };

            device = {
                name = "epic-mouse-v1";
                sensitivity = 5;
            };

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            master = {
                new_status = "master";
            };

            misc = {
                force_default_wallpaper = 0;
                disable_hyprland_logo = true;
            };
        };
    };
}
