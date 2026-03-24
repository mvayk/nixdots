{
  pkgs,
  ...
}:
let
  bg = "#000000CC"; # rgba(0,0,0,0.8)
  bgDeep = "#000000E6"; # rgba(0,0,0,0.9)
  fg = "#c1c1c1";
  dim = "#888888";
  accent = "#FFFFFF";
  urgent = "#a06666";
  border = "#FFFFFF66"; # rgba(255,255,255,0.4)
  borderDim = "#FFFFFF33"; # rgba(255,255,255,0.2)
in
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = 300;
        height = "(0, 120)";
        origin = "top-right";
        offset = "(12, 12)";
        scale = 0;
        notification_limit = 5;

        progress_bar = true;
        progress_bar_height = 3;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 0;
        icon_corner_radius = 0;

        indicate_hidden = true;
        transparency = 0;
        separator_height = 1;
        padding = 10;
        horizontal_padding = 12;
        text_icon_padding = 10;
        frame_width = 1;
        frame_color = border;
        gap_size = 4;
        separator_color = "frame";
        sort = "yes";

        idle_threshold = 120;
        font = "JetBrainsMono Nerd Font 11";
        line_height = 2;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = false;

        enable_recursive_icon_lookup = true;
        icon_theme = "Tela-dark";
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 20;

        sticky_history = true;
        history_length = 20;

        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
        browser = "${pkgs.xdg-utils}/bin/xdg-open";

        always_run_script = true;
        corner_radius = 0;
        ignore_dbusclose = false;

        force_xwayland = false;
        force_xinerama = false;

        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = bg;
        foreground = dim;
        frame_color = borderDim;
        timeout = 4;
      };

      urgency_normal = {
        background = bg;
        foreground = fg;
        frame_color = border;
        timeout = 6;
      };

      urgency_critical = {
        background = bgDeep;
        foreground = accent;
        frame_color = urgent;
        timeout = 0;
      };
    };
  };
}
