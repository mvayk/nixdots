{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.hardware;
in {
  options.my.hardware = {
    enable = lib.mkEnableOption "hardware utilities";
    info.enable = mkSub cfg.enable "sensors, usb, system info";
    input.enable = mkSub cfg.enable "brightness, VIA keyboards";
    android.enable = mkSub cfg.enable "adb + scrcpy";
    filesystems.enable = mkSub cfg.enable "ntfs3g";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.info.enable {
      environment.systemPackages = with pkgs; [usbutils acpi inxi sysstat lm_sensors];
    })

    (lib.mkIf cfg.input.enable {
      services.udev.packages = [pkgs.via];
      environment.systemPackages = with pkgs; [via brightnessctl];
    })

    (lib.mkIf cfg.android.enable {
      environment.systemPackages = with pkgs; [android-tools scrcpy];
    })

    (lib.mkIf cfg.filesystems.enable {
      environment.systemPackages = [pkgs.ntfs3g];
    })
  ];
}
