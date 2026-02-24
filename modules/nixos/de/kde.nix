{ pkgs, ... }:
{
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kwallet
    kwallet-pam
    kwalletmanager
  ];

  xdg.portal.enable = true;
}
