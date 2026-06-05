{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/core.nix
  ];

  networking.hostName = "coerxion";

  boot.initrd.availableKernelModules = [ "i915" ];

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
    "intel"
  ];

  environment.sessionVariables = {
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    open = false;
    nvidiaSettings = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      sync = {
        enable = false;
      };

      intelBusId = "PCI:0:2:0";
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
