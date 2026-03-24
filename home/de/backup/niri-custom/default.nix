{
  config,
  pkgs,
  lib,
  machine,
  de,
  theme,
  ...
}:
{
  imports = [
    ../../features/ghostty.nix
    ../../features/fastfetch.nix
    ../../features/rofi.nix
    ../../features/waybar.nix
  ];

  home.pointerCursor = {
    package = pkgs.openzone-cursors;
    name = "Openzone_black";
    size = 24;
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      environment = {
        XDG_CURRENT_DESKTOP = "niri";
        XCURSOR_THEME = "Openzone_black";
        XCURSOR_SIZE = "24";
      };

      cursor = {
        theme = "Openzone_black";
        size = 24;
      };

      input = {
        focus-follows-mouse.enable = true;
        keyboard = {
          xkb = {
            layout = "us";
            options = "caps:escape_shifted_capslock";
          };
        };
        mouse = {
          accel-profile = "flat";
          accel-speed = 0.0;
        };
        touchpad = {
          natural-scroll = false;
          tap = true;
        };
      };

      outputs =
        if machine == "flandre" then
          {
            "HDMI-A-1" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 60.0;
              };
              position = {
                x = 0;
                y = 0;
              };
            };
            "DP-3" = {
              mode = {
                width = 2560;
                height = 1440;
                refresh = 240.001;
              };
              position = {
                x = 1920;
                y = 0;
              };
            };
            "DP-1" = {
              mode = {
                width = 2560;
                height = 1440;
                refresh = 240.001;
              };
              position = {
                x = 4480;
                y = 0;
              };
            };
          }
        else
          {
            "eDP-1" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 60.0;
              };
              position = {
                x = 0;
                y = 0;
              };
            };
          };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        background-color = "transparent";

        preset-column-widths = [
          {
            proportion = 0.333333;
          }
          {
            proportion = 0.5;
          }
          {
            proportion = 0.666667;
          }
        ];

        default-column-width = {
          proportion = 0.5;
        };

        focus-ring = {
          enable = false;
          width = 2;
          active.color = "#FFFFFFFF";
          inactive.color = "#000000FF";
        };

        border = {
          enable = true;
          active.color = "#FFFFFFFF";
          inactive.color = "#000000FF";
          width = 1;
        };

        shadow = {
          enable = true;
          offset = {
            x = 2;
            y = 3;
          };
          softness = 24;
          color = "#00000055";
        };
      };

      animations.slowdown = 1.0;

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      spawn-at-startup = [
        {
          command = [
            "swww-daemon"
          ];
        }
        {
          command = [
            "waybar"
          ];
        }
        {
          command = [
            "nm-applet"
          ];
        }
        {
          command = [
            "xwayland-satellite"
          ];
        }
      ];

      prefer-no-csd = true;
      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 0.0;
            top-right = 0.0;
            bottom-left = 0.0;
            bottom-right = 0.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            {
              app-id = "^com\\.mitchellh\\.ghostty$";
            }
          ];
          draw-border-with-background = false;
        }
      ];

      layer-rules = [
        {
          place-within-backdrop = false;
        }
      ];

      binds = {
        "Mod+T".action.spawn = [
          "ghostty"
        ];
        "Mod+W".action.spawn = [
          "chromium"
        ];
        "Mod+E".action.spawn = [
          "dolphin"
        ];

        "Mod+O".action.spawn = [
          "swaylock"
        ];

        "Pause".action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];

        "Mod+Semicolon".action.spawn = [
          "rofi"
          "-show"
          "drun"
        ];

        "Mod+A".action.spawn = [
          "rofi"
          "-show"
          "drun"
        ];

        "Mod+Page_Up".action.spawn = [
          "pamixer"
          "--increase"
          "5"
        ];
        "Mod+Page_Down".action.spawn = [
          "pamixer"
          "--decrease"
          "5"
        ];

        "End".action.spawn = [
          "sh"
          "-c"
          "grim -g \"$(slurp)\" - | tee ~/Documents/sync/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"
        ];
        "Mod+Shift+S".action.screenshot = { };
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };

        "Mod+Q".action.close-window = { };
        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };
        "Mod+V".action.toggle-window-floating = { };
        "Mod+R".action.switch-preset-column-width = { };

        "Mod+M".action.quit = { };

        "Mod+H".action.focus-column-left = { };
        "Mod+L".action.focus-column-right = { };
        "Mod+K".action.focus-window-up = { };
        "Mod+J".action.focus-window-down = { };

        "Mod+Shift+H".action.move-column-left = { };
        "Mod+Shift+L".action.move-column-right = { };
        "Mod+Shift+K".action.move-window-up = { };
        "Mod+Shift+J".action.move-window-down = { };

        "Mod+Ctrl+H".action.focus-monitor-left = { };
        "Mod+Ctrl+L".action.focus-monitor-right = { };
        "Mod+Ctrl+K".action.focus-monitor-up = { };
        "Mod+Ctrl+J".action.focus-monitor-down = { };
        "Mod+Shift+Ctrl+H".action.move-window-to-monitor-left = { };
        "Mod+Shift+Ctrl+L".action.move-window-to-monitor-right = { };

        "Mod+WheelScrollUp" = {
          cooldown-ms = 10;
          action.focus-column-left = { };
        };
        "Mod+WheelScrollDown" = {
          cooldown-ms = 10;
          action.focus-column-right = { };
        };
        "Mod+Shift+WheelScrollDown" = {
          cooldown-ms = 10;
          action.focus-workspace-down = { };
        };
        "Mod+Shift+WheelScrollUp" = {
          cooldown-ms = 10;
          action.focus-workspace-up = { };
        };

        "Mod+Alt+L".action.set-column-width = "+10%";
        "Mod+Alt+H".action.set-column-width = "-10%";
        "Mod+Alt+K".action.set-window-height = "-10%";
        "Mod+Alt+J".action.set-window-height = "+10%";

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        "Mod+S".action.toggle-overview = { };
      }
      // lib.optionalAttrs (machine == "laptop") {
        "XF86AudioRaiseVolume".action.spawn = [
          "pamixer"
          "--increase"
          "5"
        ];
        "XF86AudioLowerVolume".action.spawn = [
          "pamixer"
          "--decrease"
          "5"
        ];
        "XF86MonBrightnessUp".action.spawn = [
          "brightnessctl"
          "set"
          "1%+"
        ];
        "XF86MonBrightnessDown".action.spawn = [
          "brightnessctl"
          "set"
          "1%-"
        ];
      };
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  xdg.configFile."qt6ct/colors/black-metal.conf".text = ''
    [ColorScheme]
    active_colors=#c1c1c1, #1a1a1a, #606060, #303030, #0d0d0d, #404040, #c1c1c1, #ffffff, #c1c1c1, #0a0a0a, #000000, #282828, #486e6f, #000000, #486e6f, #a06666, #0d0d0d, #000000, #1a1a1a, #c1c1c1
    disabled_colors=#888888, #111111, #404040, #202020, #0d0d0d, #303030, #888888, #aaaaaa, #888888, #0a0a0a, #000000, #282828, #404040, #888888, #486e6f, #a06666, #0d0d0d, #000000, #1a1a1a, #888888
    inactive_colors=#999999, #141414, #505050, #282828, #0d0d0d, #383838, #999999, #bbbbbb, #999999, #0a0a0a, #000000, #282828, #404040, #999999, #486e6f, #a06666, #0d0d0d, #000000, #1a1a1a, #999999
  '';

  xdg.configFile."gtk-4.0/black-metal.css".text = ''
    @define-color accent_color #486e6f;
    @define-color accent_bg_color #486e6f;
    @define-color accent_fg_color #000000;
    @define-color destructive_color #a06666;
    @define-color destructive_bg_color #a06666;
    @define-color destructive_fg_color #000000;
    @define-color success_color #486e6f;
    @define-color warning_color #999999;
    @define-color error_color #a06666;
    @define-color window_bg_color #000000;
    @define-color window_fg_color #c1c1c1;
    @define-color view_bg_color #000000;
    @define-color view_fg_color #c1c1c1;
    @define-color headerbar_bg_color #000000;
    @define-color headerbar_fg_color #c1c1c1;
    @define-color headerbar_border_color rgba(72,110,111,0.4);
    @define-color card_bg_color #0a0a0a;
    @define-color card_fg_color #c1c1c1;
    @define-color dialog_bg_color #000000;
    @define-color dialog_fg_color #c1c1c1;
    @define-color popover_bg_color #000000;
    @define-color popover_fg_color #c1c1c1;
    @define-color sidebar_bg_color #000000;
    @define-color sidebar_fg_color #888888;
    @define-color thumbnail_bg_color #000000;
    @define-color thumbnail_fg_color #c1c1c1;
    @define-color shade_color rgba(0,0,0,0.8);
    @define-color scrollbar_outline_color #000000;
  '';

  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/black-metal.conf
    custom_palette=true
    icon_theme=Tela-dark
    standard_dialogs=xdgdesktopportal
    style=Breeze

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [Fonts]
    fixed="JetBrainsMono Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
    general="JetBrainsMono Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid()
  '';

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/black-metal.conf
    custom_palette=true
    icon_theme=Tela-dark
    standard_dialogs=xdgdesktopportal
    style=Breeze

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [Fonts]
    fixed="JetBrainsMono Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
    general="JetBrainsMono Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid()
  '';

  gtk = {
    enable = true;
    /*
      theme = {
        name = "adw-gtk3-dark";
        package =
          pkgs.adw-gtk3;
      };
    */
    iconTheme = {
      name = "Tela-dark";
      package = pkgs.tela-icon-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  xdg.configFile = {
    "gtk-4.0/gtk.css".text = ''
      @import url("file://${config.home.homeDirectory}/.config/gtk-4.0/black-metal.css");
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.zsh.initContent = ''
    eval "$(starship init zsh)"
    export NIXOS_DE="niri"
  '';

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  home.packages = with pkgs; [
    xwayland-satellite
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    lxappearance
    kdePackages.kirigami
    kdePackages.breeze-gtk
    kdePackages.breeze
    tela-icon-theme
    adw-gtk3
    nwg-look

    openzone-cursors
    grim
    slurp
    wl-clipboard

    qt6Packages.qtimageformats
    qt6Packages.qtsvg
    libsForQt5.qtimageformats
    libsForQt5.qtsvg
    libwebp
    libjpeg
    libpng
    librsvg

    waybar
    rofi
    swww

    pamixer
    wireplumber
  ];
}
