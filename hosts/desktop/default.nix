{ config, pkgs, ... }:
{
  networking.hostName = "desktop";

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    package            = config.boot.kernelPackages.nvidiaPackages.latest;
    open               = false;
    nvidiaSettings     = true;
  };

  hardware.graphics = {
    enable      = true;
    enable32Bit = true;
  };

  services.hardware.openrgb.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb",   ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091b", MODE="0666"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091b", MODE="0666"
  '';

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    # (llama-cpp.override { cudaSupport = true; })
    wootility
    xppen_4
  ];
}
