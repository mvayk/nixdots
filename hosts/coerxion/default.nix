{
  config,
  pkgs,
  ...
}:
{
  networking.hostName = "coerxion";

  boot.initrd.availableKernelModules = [ "i915" ];

  services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
      "intel"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    open = false;
    nvidiaSettings = true;
	powerManagement.enable = true;
    powerManagement.finegrained = true;

    prime = {
        offload = {
            enable = true;
            enableOffloadCmd = true;
        };
        sync = {
            enable = false;
        };

	intelBusId  = "PCI:0:2:0";
	nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.logrotate.checkConfig = false;
  services.hardware.openrgb.enable = true;

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    # why cude take so long to build
    (llama-cpp.override {
      cudaSupport = false;
    })
  ];
}
