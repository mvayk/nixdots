{ pkgs, lib, ... }:
{
  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "*";
  };

  services.displayManager.defaultSession = "niri";
}
