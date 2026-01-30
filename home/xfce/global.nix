
{ config, pkgs, ... }:
{
    services.xserver = {
        enable = true;
        desktopManager = {
            xterm.enable = false;
        };
        services.displayManager.defaultSession = "xfce";
    };
}
