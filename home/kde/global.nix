
{ config, pkgs, ... }:
{
    services.displayManager.defaultSession = "plasma";
    services.desktopManager.plasma6.enable = true;

    xdg.portal = {
        enable = true;
    };
}
