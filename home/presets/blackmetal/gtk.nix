{
  config,
  pkgs,
  ...
}:
{
  gtk = {
    enable = true;
    gtk4.theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
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

    "gtk-3.0/gtk.css".text = ''
      @import url("file://${config.home.homeDirectory}/.config/gtk-3.0/black-metal.css");
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
