
{ config, pkgs, ... }:
{
    services.displayManager.defaultSession = "hyprland";

    xdg.menus.enable = true;
    xdg.mime.enable = true;

    environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    programs.hyprland = {
        enable = true;
        #withUWSM = true;
        xwayland.enable = true;
    };

    xdg.portal = {
        enable = true;
    };
}
