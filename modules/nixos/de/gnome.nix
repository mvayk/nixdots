{ ... }:
{
  services.displayManager.defaultSession = "gnome";

  services.desktopManager.gnome.enable = true;

  xdg.portal.enable = true;
}
