{ pkgs, ... }:
{
  imports = [
    ../../features/ghostty.nix
    ../../features/fastfetch.nix
  ];

  programs.zsh.initContent = ''
    eval "$(starship init zsh)"
    export NIXOS_DE="gnome"
  '';

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvAmbiance
  '';

  xdg.configFile."gtk-4.0/gtk.css".text = ''
    @define-color accent_color #6d9dc5;
    @define-color accent_bg_color #6d9dc5;
    @define-color accent_fg_color #ffffff;
    @define-color window_bg_color #0a0a0a;
    @define-color window_fg_color #ffffff;
    @define-color view_bg_color #0a0a0a;
    @define-color view_fg_color #ffffff;
    @define-color headerbar_bg_color #0a0a0a;
    @define-color headerbar_fg_color #ffffff;
    @define-color card_bg_color #111111;
    @define-color card_fg_color #ffffff;
    @define-color dialog_bg_color #0a0a0a;
    @define-color dialog_fg_color #ffffff;
    @define-color popover_bg_color rgba(0, 0, 0, 0.75);
    @define-color popover_fg_color #ffffff;
    @define-color menu_bg_color rgba(0, 0, 0, 0.75);
    @define-color sidebar_bg_color #080808;
    @define-color sidebar_fg_color #ffffff;
  '';

  xdg.configFile."gtk-3.0/gtk.css".text = ''
    @define-color accent_color #6d9dc5;
    @define-color theme_bg_color #0a0a0a;
    @define-color theme_fg_color #ffffff;
    @define-color theme_base_color #0a0a0a;
    @define-color theme_text_color #ffffff;
    @define-color theme_selected_bg_color #6d9dc5;
    @define-color theme_selected_fg_color #ffffff;
  '';

  xdg.configFile."gnome-shell/gnome-shell.css".text = ''
    .panel-menu-content,
    .popup-menu-content,
    .popup-menu,
    .candidate-popup-content {
      background-color: rgba(0, 0, 0, 0.75) !important;
      border: 1px solid rgba(255, 255, 255, 0.08) !important;
      border-radius: 12px !important;
      box-shadow: 0 4px 24px rgba(0, 0, 0, 0.6) !important;
    }

    .popup-menu-item:hover {
      background-color: rgba(255, 255, 255, 0.07) !important;
      border-radius: 8px !important;
    }

    .panel-button:hover,
    .panel-button:active {
      background-color: rgba(255, 255, 255, 0.07) !important;
      border-radius: 8px !important;
    }
  '';

  home.packages = with pkgs; [
    gnome-tweaks
    gnome-calendar
    gnome-weather
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.rounded-window-corners-reborn
    marble-shell-theme
    gnomeExtensions.user-themes
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "slate";
      font-name = "JetBrainsMono Nerd Font 10";
      monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
      document-font-name = "JetBrainsMono Nerd Font 10";
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Bibata-Modern-Classic";
      cursor-size = 24;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 4;
      focus-mode = "sloppy";
      auto-raise = false;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        dash-to-dock.extensionUuid
        just-perfection.extensionUuid
        rounded-window-corners-reborn.extensionUuid
        user-themes.extensionUuid
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Marble-gray-dark";
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      static-blur = true;
      override-background = true;
      style-panel = 0;
    };
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      static-blur = true;
    };
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
      style-components = 3;
    };
    "org/gnome/shell/extensions/blur-my-shell/menus" = {
      blur = true;
      static-blur = false;
      sigma = 30;
      brightness = 0.75;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dock-fixed = false;
      intellihide = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      autohide = true;
      extend-height = false;
      transparency-mode = "FIXED";
      custom-background-color = true;
      background-color = "#000000";
      background-opacity = 0.6;
      dash-max-icon-size = 48;
      show-trash = false;
      show-mounts = false;
      running-indicator-style = "DOTS";
      custom-theme-shrink = true;
      disable-overview-on-startup = true;
    };

    "org/gnome/shell/extensions/just-perfection" = {
      activities-button = false;
      app-menu = false;
      clock-menu-position = 1;
      animation = 1;
      panel-size = 32;
      dash = true;
    };

    "org/gnome/shell/extensions/rounded-window-corners" = {
      global-rounded-corner-settings = "{'padding': <{'left': <uint32 1>, 'right': <uint32 1>, 'top': <uint32 1>, 'bottom': <uint32 1>}>, 'keep_rounded_corners': <{'maximized': <false>, 'fullscreen': <false>}>, 'border_radius': <uint32 12>, 'smoothing': <uint32 0>}";
    };
  };
}
