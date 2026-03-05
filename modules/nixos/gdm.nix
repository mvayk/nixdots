{ config, pkgs, ... }:
{
  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
    settings = {
      greeter = {
        IncludeAll = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-shell
    adwaita-icon-theme
  ];
}
