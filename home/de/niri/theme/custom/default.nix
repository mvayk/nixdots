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
    ../../../../features/ghostty.nix
    ../../../../features/fastfetch.nix
    ../../../../features/rofi.nix
    ../../../../features/waybar.nix
    ../../../../features/dunst.nix
  ];

  home.pointerCursor = {
    package = pkgs.openzone-cursors;
    name = "OpenZone_Black_Slim";
    size = 24;
  };

  programs.niri = {
    settings = {
      environment = {
        XCURSOR_THEME = "OpenZone_Black_Slim";
        XCURSOR_SIZE = "24";
      };

      cursor = {
        theme = "OpenZone_Black_Slim";
        size = 24;
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

      animations.slowdown = 0.5;

      spawn-at-startup = [
        {
          command = [
            "dunst"
          ];
        }
        {
          command = [
            "swww-daemon"
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

      binds = {
        "Mod+A".action.spawn = [
          "rofi"
          "-show"
          "drun"
        ];
        "Mod+Semicolon".action.spawn = [
          "rofi"
          "-dmenu"
          "p"
          "dunst"
        ];
        "Pause".action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
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
      };

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
          place-within-backdrop = true;
        }
      ];
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

  /*
    programs.zsh.initContent = ''
      eval "$(starship init zsh)"
      export NIXOS_DE="niri"
    '';
  */

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
    dunst

    pamixer
    wireplumber
  ];
}
