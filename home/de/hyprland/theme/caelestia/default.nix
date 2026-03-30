{
  config,
  pkgs,
  caelestia-shell,
  quickshell,
  lib,
  machine,
  de,
  ...
}:
{
  imports = [
    ../../../../features/ghostty.nix
    ../../../../features/fastfetch.nix
    caelestia-shell.homeManagerModules.default
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
      environment = [ ];
    };
    settings = {
      paths.wallpaperDir = "~/Pictures/wallpapers/normal";
    };
    cli = {
      enable = true;
      settings = {
        theme.enableGtk = true;
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
      ];

      exec-once = [
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "nm-applet"
        "xwayland-satellite"
      ];

      general = {
        gaps_in = 2;
        gaps_out = 8;
        border_size = 1;
        "col.active_border" = "$primary $secondary $tertiary 45deg";
        "col.inactive_border" = "$surface";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 24;
          render_power = 4;
          color = "rgba(00000055)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 1, linear"
          "borderangle, 1, 80, linear, loop"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 3.5, easeOutExpo, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      bind = [
        /*
          "SUPER, O, exec, noctalia-shell ipc call lockScreen lock"
          ", Pause, exec, noctalia-shell ipc call volume muteInput"
          "SUPER, Semicolon, exec, noctalia-shell ipc call launcher emoji"
          "SUPER, I, exec, noctalia-shell ipc call launcher calculator"
          "SUPER, A, exec, noctalia-shell ipc call launcher toggle"
          "SUPER, Page_Up, exec, noctalia-shell ipc call volume increase"
          "SUPER, Page_Down, exec, noctalia-shell ipc call volume decrease"
        */
      ];
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt5ct/colors/noctalia.conf
    custom_palette=true
    icon_theme=kora
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
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf
    custom_palette=true
    icon_theme=kora
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
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  home.packages = with pkgs; [
    xwayland-satellite
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    lxappearance
    kdePackages.kirigami
    kdePackages.qtstyleplugin-kvantum
    kdePackages.breeze-gtk
    kdePackages.breeze
    kora-icon-theme
    adw-gtk3
    nwg-look

    # apple-cursor
    bibata-cursors
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

    quickshell.packages.${pkgs.system}.default
    #caelestia-shell.packages.${pkgs.system}.default
  ];
}
