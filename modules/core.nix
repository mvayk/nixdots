{pkgs, ...}: {
  imports = [
    ../modules/profiles/default.nix
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

  services = {
    udisks2.enable = true;
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
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      xkb = {
        layout = "au";
        variant = "";
        options = "caps:escape_shifted_capslock";
      };
    };
    pulseaudio.enable = false;
    pipewire = {
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
  };

  xdg = {
    menus.enable = true;
    mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "org.kde.dolphin.desktop";
      };
    };
    portal.enable = true;
  };

  gnome.gnome-keyring.enable = true;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
    pam.services.hyprland.enableGnomeKeyring = true;
    pam.services.sddm.enableGnomeKeyring = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  # hey dont touch remember
  system.stateVersion = "25.05";
}
