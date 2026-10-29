{...}: {
  services.displayManager.defaultSession = "cinnamon";
  services.xserver.desktopManager.cinnamon.enable = true;
  xdg.portal.enable = true;

  imports = [../xorg.nix];
}
