{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
  };
}
