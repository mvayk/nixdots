{
  pkgs,
  lib,
  config,
  quickshell ? null,
  theme,
  ...
}:
{
  services.displayManager.defaultSession = "hyprland";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  programs.dms-shell = {
    enable = theme == "dank";
  }
  // lib.optionalAttrs (theme == "dank") {
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
  };
}
