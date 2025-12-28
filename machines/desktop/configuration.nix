{ config, pkgs, ... }:

{
  networking.hostName = "desktop";

  services.xserver = {
    videoDrivers = ["nvidia"];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    open = false;
    nvidiaSettings = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  services.hardware.openrgb.enable = true;

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
  ];
}
