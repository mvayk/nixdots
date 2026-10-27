{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ../../modules/core.nix
    ../../modules/profiles/default.nix
  ];

  my.bundles.workstation.enable = true;

  networking.hostName = "coerxion";

  boot.initrd.availableKernelModules = ["i915"];

  services = {
    logrotate.checkConfig = false;
    xserver.videoDrivers = [
      "modesetting"
      "nvidia"
      "intel"
    ];
  };

  environment.sessionVariables = {
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
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
  };
}
