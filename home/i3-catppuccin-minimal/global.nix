
{ config, pkgs, ... }:
{
    services.displayManager.defaultSession = "i3";

    services.xserver = {
        windowManager.i3.enable = true;
    };
}
