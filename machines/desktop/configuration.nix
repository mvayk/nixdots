{ config, pkgs, ... }:

{
  networking.hostName = "desktop";

  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    open = false;
    nvidiaSettings = true;
  };

  nixpkgs.config.cudaSupport = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # xp pentablet fix
  #sudo cp /nix/store/r7y9rzqa2hmzhhvym01cj0i77m0dn9dv-xppen_4-4.0.7-250117/usr/lib/pentablet/conf/xppen/config.xml /var/lib/pentablet/conf/xppen/config.xml

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091b", MODE="0666"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091b", MODE="0666"
  '';

  services.hardware.openrgb.enable = true;

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    (llama-cpp.override { cudaSupport = true; })
    wootility
    xppen_4
  ];
}
