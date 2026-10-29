{pkgs, ...}: {
  imports = [../xorg.nix];
  services.displayManager.defaultSession = "xfce";
  services.xserver.desktopManager.xfce.enable = true;

  xdg.portal.enable = true;

  environment.systemPackages = with pkgs; [
    xfce4-pulseaudio-plugin
    xfce4-whiskermenu-plugin
    xfce4-docklike-plugin

    lxappearance
    redshift
    geoclue2
    libxrandr

    chicago95
  ];
}
