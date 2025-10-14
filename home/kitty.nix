{ config, pkgs, ... }:

{
    programs.kitty = {
        enable = true;

        shellIntegration = {
            enableFishIntegration = false;
            enableZshIntegration = true;
        };

        font = {
            name = "Iosevka Nerd Font";
            size = 14;
        };

        settings = {
            bold_font = "auto";
            italic_font = "auto";
            bold_italic_font = "auto";

            background_opacity = "1";
            dynamic_background_opacity = true;
            window_padding_width = 0;
            enable_audio_bell = false;
            confirm_os_window_close = 0;
            cursor_shape = "block";
            cursor_blink_interval = "1";

            foreground = "#a9b1d6";
            background = "#1a1b26";

            color0 = "#414868";
            color8 = "#414868";

            color1 = "#f7768e";
            color9 = "#f7768e";

            color2 = "#73daca";
            color10 = "#73daca";

            color3 = "#e0af68";
            color11 = "#e0af68";

            color4 = "#7aa2f7";
            color12 = "#7aa2f7";

            color5 = "#bb9af7";
            color13 = "#bb9af7";

            color6 = "#7dcfff";
            color14 = "#7dcfff";

            color7 = "#c0caf5";
            color15 = "#c0caf5";

            cursor = "#c0caf5";
            cursor_text_color = "#1a1b26";

            selection_foreground = "none";
            selection_background = "#28344a";

            url_color = "#9ece6a";

            active_border_color = "#3d59a1";
            inactive_border_color = "#101014";
            bell_border_color = "#e0af68";

            tab_bar_style = "fade";
            tab_fade = "1";
            active_tab_foreground = "#3d59a1";
            active_tab_background = "#16161e";
            active_tab_font_style = "bold";
            inactive_tab_foreground = "#787c99";
            inactive_tab_background = "#16161e";
            inactive_tab_font_style = "bold";
            tab_bar_background = "#101014";

            macos_titlebar_color = "#16161e";
        };

        keybindings = {
            "ctrl+backspace" = "send_text all \\x17";
        };
    };
}

