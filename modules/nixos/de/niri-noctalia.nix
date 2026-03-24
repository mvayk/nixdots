{
  pkgs,
  lib,
  ...
}:
{
  programs.niri.enable =
    true;

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-hyprland
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  #
  #   config.niri = {
  #     default = lib.mkForce [
  #       "hyprland"
  #       "gtk"
  #     ];
  #   };
  # };

  services.displayManager.defaultSession = "niri";
}
