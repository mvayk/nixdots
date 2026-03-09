{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.displayManager.ly = {
    enable = false;
  };
}
