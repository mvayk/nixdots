{
  config,
  pkgs,
  ...
}: {
  boot = {
    loader.limine = {
      extraEntries = ''
        /Windows 11
            protocol: efi
            path: guid(e68c8506-3dcf-44b1-aee5-6e77f17cf45c):/EFI/Microsoft/Boot/bootmgfw.efi
      '';
      resolution = "2560x1440";
      style = {
        wallpapers = [../../modules/styling/wallpaper.png];
        wallpaperStyle = "centered";
        backdrop = "000000";
        interface.resolution = "2560x1440";
      };
    };
  };

  imports = [
    ./hardware.nix
    ../../modules/core.nix
    ../../modules/profiles/default.nix
    ../../modules/features/gdm.nix
  ];

  my.bundles.workstation.enable = true;
  my.hardware.info.enable = false;
  my.ai.enable = false;
  my.ai.tools.enable = true;
  my.gaming.enable = true;
  my.gaming.games.enable = false;
  my.gaming.other.enable = false;
  my.dev.emacs.enable = true;
  my.reversing.cli.enable = true;
  my.reversing.gui.enable = true;

  boot = {
    kernel.sysctl = {
      "kernel.yama.ptrace_scope" = 0;
    };

    kernelParams = ["usbhid.mousepoll=8" "nvidia-drm.fbdev=1" "nvidia-drm.modeset=1"];
    blacklistedKernelModules = ["wacom" "hid_uclogic" "hid_huion"];

    kernelModules = [
      "uinput"
      "v4l2loopback"
    ];

    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    supportedFilesystems = [
      "ntfs"
    ];
  };

  networking.hostName = "flandre";

  services = {
    xserver.videoDrivers = [
      "nvidia"
    ];

    ratbagd.enable = true;
    hardware.openrgb.enable = false;

    udev.extraRules = ''
      SUBSYSTEM=="usb",    ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091b", MODE="0666"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091b", MODE="0666"
      SUBSYSTEM=="input",  ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091b", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';

    udev.packages = [
      pkgs.via
    ];
  };

  hardware = {
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
    bluetooth.enable = true;
    uinput.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      #package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      nvidiaSettings = true;
    };
  };

  fonts.fontconfig.enable = true;

  programs.xppen = {
    enable = false;
    package = pkgs.xppen_3;
  };

  environment.systemPackages = with pkgs; [
    #openrgb-with-all-plugins
    (llama-cpp.override {
      cudaSupport = false;
    })
    wootility
    #xppen_4
    piper
    #vmware-workstation
  ];
}
