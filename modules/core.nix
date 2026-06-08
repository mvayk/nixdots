{
  pkgs,
  ...
}:
{

  imports = [
    ../modules/features/ly.nix
    ../modules/features/dank.nix
    ./programs.nix
    ./packages.nix
    #../modules/sops.nix
  ];

  boot = {
    loader.systemd-boot.enable = false;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.linuxPackages_latest;

    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };

    #    kernel.sysctl = {
    #     "kernel.yama.ptrace_scope" = 0;
    #  };

    #kernelModules = [
    #  "uinput"
    #  "v4l2loopback"
    #];
    #extraModulePackages = with config.boot.kernelPackages; [
    #   v4l2loopback
    #];
    # extraModprobeConfig = ''
    #    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    #   '';
    #
    #  supportedFilesystems = [
    #     "ntfs"
    #    ];
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Sydney";

  i18n = {
    defaultLocale = "en_AU.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  };

  services.udisks2.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    xkb = {
      layout = "au";
      variant = "";
      options = "caps:escape_shifted_capslock";
    };
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire."10-rt-prio" = {
      "context.modules" = [
        {
          name = "libpipewire-module-rt";
          args = {
            "nice.level" = -11;
            "rt.prio" = 88;
          };
          flags = [
            "ifexists"
            "nofail"
          ];
        }
      ];
    };
  };

  hardware = {
    bluetooth.enable = true;
    opentabletdriver.enable = true;
    uinput.enable = true;
    keyboard.qmk.enable = true;
  };

  xdg = {
    menus.enable = true;
    mime.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };

  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  services.udev.packages = [
    pkgs.via
  ];

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  # security.pam.services.login.kwallet.enable = pkgs.lib.mkForce false;
  # security.pam.services.sddm.kwallet.enable = pkgs.lib.mkForce false;

  services = {
    flatpak.enable = true;
    fwupd.enable = false;
    gvfs.enable = true;
    upower.enable = true;
    printing.enable = true;
    dbus = {
      enable = true;
      packages = [
        pkgs.seahorse
      ];
    };

    power-profiles-daemon.enable = true;
    ollama.enable = true;

    emacs = {
      enable = true;
      package = pkgs.emacs;
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  documentation = {
    enable = true;
    man.man-db.enable = true;
    man.mandoc.enable = false;
    dev.enable = true;
  };

  # hey dont touch remember
  system.stateVersion = "25.05";
}
