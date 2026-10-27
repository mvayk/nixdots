{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ../../modules/core.nix
  ];

  profiles = {
    cli = true;
    desktop = true;
    dev = true;
    gaming = true;
    media = true;
    misc = true;
    security = true;
  };

  boot.kernelParams = ["usbhid.mousepoll=8"];
  virtualisation.vmware.host.enable = false;

  networking.hostName = "flandre";

  services = {
    xserver.videoDrivers = [
      "nvidia"
    ];

    ratbagd.enable = true;
    hardware.openrgb.enable = true;

    udev.extraRules = ''
      SUBSYSTEM=="usb",   ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091b", MODE="0666"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091b", MODE="0666"
    '';

    udev.packages = [
      pkgs.via
    ];
  };

  hardware = {
    opentabletdriver.enable = true;
    bluetooth.enable = true;
    uinput.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      #package = config.boot.kernelPackages.nvidiaPackages.latest;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      nvidiaSettings = true;
    };
  };

  programs.xppen = {
    enable = true;
    package = pkgs.xppen_3;
  };

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    # why cude take so long to build
    (llama-cpp.override {
      cudaSupport = false;
    })
    wootility
    #xppen_4
    piper
    #vmware-workstation
  ];
}
