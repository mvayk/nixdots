{pkgs, ...}: {
  imports = [../../themes/dank/default.nix];

  wayland.windowManager.mango = {
    extraConfig = ''
      source=./noctalia.conf

      animation_curve_open=0.46,1.0,0.29,0.99
      animation_curve_move=0.46,1.0,0.29,0.99
      animation_curve_tag=0.46,1.0,0.29,0.99
      animation_curve_close=0.46,1.0,0.29,0.99
      animation_curve_focus=0.46,1.0,0.29,0.99
      animation_curve_opacity_fade_in=0.46,1.0,0.29,0.99
      animation_curve_opacity_fade_out=0.5,0.5,0.5,0.5
    '';
    settings = {
      env = [
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];
      animations = 1;
      layer_animations = 1;

      animation_type_open = "zoom";
      animation_type_close = "slide";
      layer_animation_type_open = "slide";
      layer_animation_type_close = "slide";

      zoom_initial_ratio = 0.2;
      zoom_end_ratio = 0.8;

      animation_duration_move = 500;
      animation_duration_open = 400;
      animation_duration_tag = 300;
      animation_duration_close = 300;
      animation_duration_focus = 0;

      gap_inner_horizontal = 14;
      gap_inner_vertical = 14;
      gap_outer_horizontal = 28;
      gap_outer_vertical = 28;

      border_px = 0;
      focus_color = "0xFFFFFFFF";
      border_color = "0x000000FF";
      root_color = "0x00000000";

      border_radius = 0;

      shadows = 1;
      shadow_only_floating = 0;
      shadows_size = 4;
      shadows_blur = 5;
      shadows_position_x = 0;
      shadows_position_y = 0;
      shadows_color = "0x00000060";
      group_bar_decorate_border_width = 2;
      group_bar_height = 16;
      group_bar_decorate_corner_radius = 0;
      group_bar_decorate_font_desc = "JetBrainsMono Bold 8";

      blur = 1;
      blur_layer = 1;
      blur_optimized = 0;
      blur_params_radius = 2;
      blur_params_num_passes = 1;
      blur_params_noise = 0.02;
      blur_params_brightness = 1;
      blur_params_contrast = 1;
      blur_params_saturation = 5; #1.2

      tab_bar_height = 16;
      tab_bar_decorate_font_desc = "JetBrainsMono Bold 8";
      title_message_bar_height = 0;

      tab_bar_decorate_border_width = 0;
      tab_bar_decorate_corner_radius = 0;

      # monocle_no_gap = 1;
      # monocle_no_border = 1;

      tab_bar_decorate_fg_color = "0xFFFFFFFF";
      tab_bar_decorate_bg_color = "0x000000FF";
      tab_bar_decorate_border_color = "0x000000FF";

      bind = [
        "SUPER,o,spawn,dms ipc call lock lock"
        "NONE,Pause,spawn,dms ipc call audio micmute"
        "SUPER,semicolon,spawn_shell,dms ipc call spotlight openQuery \"/emo \""
        "SUPER,i,spawn_shell,dms ipc call spotlight openQuery \"/calc \""
        "SUPER,a,spawn,dms ipc call spotlight toggle"
        "SUPER,Page_Up,spawn,dms ipc call audio increment 5"
        "SUPER,Page_Down,spawn,dms ipc call audio decrement 5"
        "NONE,Print,spawn,dms screenshot"
        "SUPER,Insert,spawn,dms ipc call dash toggle \"\""
        "SUPER+CTRL,w,spawn,dms ipc call dankdash wallpaper"
      ];

      exec_once = [
        "dms run"
      ];
    };
  };
}
