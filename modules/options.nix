{ lib, ... }:
{
  options.hyprConfig = {
    mainMod = lib.mkOption {
      type = lib.types.str;
      default = "SUPER";
      description = "Main modifier key for Hyprland";
    };
  };
}
