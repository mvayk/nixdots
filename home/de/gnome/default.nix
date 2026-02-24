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
      # name = "adw-gtk3-dark";
      # package = pkgs.adw-gtk3;
      name = "WhiteSur-dark";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
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

  home.file.".local/share/themes/WhiteSur-Dark".source =
    "${pkgs.whitesur-gtk-theme}/share/themes/WhiteSur-Dark";

  home.file.".local/share/themes/Marble-gray-dark".source =
    "${pkgs.marble-shell-theme}/share/themes/Marble-gray-dark";

  home.packages = with pkgs; [
    gnome-tweaks
    gnome-calendar
    gnome-weather
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.rounded-window-corners-reborn
    marble-shell-theme
    gnomeExtensions.user-themes
  ];
  home.sessionVariables = { };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "slate";
      font-name = "JetBrainsMono Nerd Font 10";
      monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
      document-font-name = "JetBrainsMono Nerd Font 10";
      gtk-theme = "WhiteSur-dark";
      icon-theme = "WhiteSur-dark";
      cursor-theme = "Bibata-Modern-Classic";
      cursor-size = 24;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 4;
      focus-mode = "sloppy";
      auto-raise = false;
      titlebar-font = "JetBrainsMono Nerd Font Bold 10";
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
      override-background = false;
      sigma = 20;
      brightness = 0.7;
    };
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
      style-components = 3;
      sigma = 30;
      brightness = 0.65;
    };
    "org/gnome/shell/extensions/blur-my-shell/menus" = {
      blur = true;
      static-blur = true;
      override-background = true;
      sigma = 30;
      brightness = 0.6;
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
      background-color = "#2a2a2e";
      background-opacity = 0.45;
      dash-max-icon-size = 48;
      show-trash = false;
      show-mounts = false;
      running-indicator-style = "DOTS";
      custom-theme-shrink = true;
      disable-overview-on-startup = true;
    };
    "org/gnome/shell/extensions/just-perfection" = {
      animation = 1;
      panel-size = 32;
      dash = true;
      panel-in-overview = true;
      panel-button-padding-size = 6;
      window-demands-attention-focus = true;
      window-maximized-titlebar = false;
    };
    "org/gnome/shell/extensions/rounded-window-corners" = {
      global-rounded-corner-settings = "{'padding': <{'left': <uint32 1>, 'right': <uint32 1>, 'top': <uint32 1>, 'bottom': <uint32 1>}>, 'keep_rounded_corners': <{'maximized': <false>, 'fullscreen': <false>}>, 'border_radius': <uint32 12>, 'smoothing': <uint32 0>}";
    };
  };
}
