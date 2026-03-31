{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.displayManager.dms-greeter = {
    enable = false;
  };
}
