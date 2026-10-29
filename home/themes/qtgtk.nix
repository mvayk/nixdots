{
  pkgs,
  config,
  theme,
  ...
}: {
  home.pointerCursor = {
    enable = true;
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "Darkly";
      package = [pkgs.darkly];
    };
    qt6ctSettings = {
      Appearance = {
        style = "Darkly";
        icon_theme = "Colloid-Dark";
        standard_dialogs = "xdgdesktopportal";
        custom_palette = true;
        color_scheme_path = "${config.home.homeDirectory}/.config/qt6ct/colors/${
          if theme == "dank"
          then "matugen"
          else "noctalia"
        }.conf";
      };
      Fonts = {
        general = "\"JetBrainsMono,11\"";
      };
    };
    qt5ctSettings = {
      Appearance = {
        style = "Darkly";
        icon_theme = "Colloid-Dark";
        standard_dialogs = "xdgdesktopportal";
        custom_palette = true;
        color_scheme_path = "${config.home.homeDirectory}/.config/qt6ct/colors/${
          if theme == "dank"
          then "matugen"
          else "noctalia"
        }.conf";
      };
      Fonts = {
        general = "\"JetBrainsMono,11\"";
      };
    };
  };

  gtk.gtk4.theme = null;
  gtk = {
    enable = true;
    font = {
      name = "JetBrainsMono";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-icon-theme;
    };
  };

  xdg.configFile."kdeglobals".text = ''
    [Icons]
    Theme=Colloid-Dark
  '';

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  home.packages = with pkgs; [];
}
