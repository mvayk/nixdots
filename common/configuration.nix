{ config, pkgs, zen-browser, spicetify-nix, firefox-nightly, ... }:

{
    imports = [
        ./packages.nix
    ];
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.ollama = {
        enable = true;
    };

    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gnome3;
    };

    time.timeZone = "Australia/Sydney";

    i18n.defaultLocale = "en_AU.UTF-8";

    i18n.extraLocaleSettings = {
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

    services.xserver = {
        xkb = {
            layout = "au";
            variant = "";
        };
        xkb.options = "caps:escape_shifted_capslock";
    };

    xdg.menus.enable = true;
    xdg.mime.enable = true;

    environment.sessionVariables = {
        C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
        CPLUS_INCLUDE_PATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.cc.version}:${pkgs.glibc.dev}/include";
        LIBRARY_PATH = "${pkgs.glibc}/lib:${pkgs.gcc.cc.lib}/lib";
        CPATH = "${pkgs.glibc.dev}/include";
    };

    services.flatpak.enable = true;
    services.fwupd.enable = true;

    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = ["uinput"];

    services.printing.enable = true;
    services.xserver = {
        enable = true;
    };

    services.displayManager.ly.enable = true;

    services.emacs = {
        enable = true;
        package = pkgs.emacs;
    };

    services.upower.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
    security.pam.services.hyprland.enableGnomeKeyring = true;
    programs.seahorse.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      
      extraConfig.pipewire = {
        "10-rt-prio" = {
          "context.modules" = [
            {
              name = "libpipewire-module-rt";
              args = {
                "nice.level" = -11;
                "rt.prio" = 88;
              };
              flags = [ "ifexists" "nofail" ];
            }
          ];
        };
      };
    };
    users.users.mvayk = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };

    documentation = {
        enable = true;
        man = {
            man-db.enable = false;
            mandoc.enable = true;
        };
        dev = {
            enable = true;
        };
    };

    programs.dconf.enable = true;
    programs.firefox.enable = false;
    programs.zsh.enable = true;
    # programs.fish.enable = true;
    programs.neovim.defaultEditor = true;
    nixpkgs.config.allowUnfree = true;
    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    xdg.portal = {
        enable = true;
    };


    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.gvfs.enable = true;
    #services.openssh.enable = true;
    system.stateVersion = "25.05";
}
