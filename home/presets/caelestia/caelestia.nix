{
  pkgs,
  caelestia-shell,
  caelestia-cli,
  quickshell,
  ...
}:
{
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [ ];
    };
    settings = {
      paths.wallpaperDir = "~/Pictures/wallpapers/";
    };

    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = false;
      };
    };
  };

  home.packages = [
    #caelestia-shell.packages.${pkgs.system}.default
    quickshell.packages.${pkgs.system}.default
  ];
}
