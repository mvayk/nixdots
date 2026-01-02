{ config, pkgs, zen-browser, spicetify-nix, firefox-nightly, ... }:

{

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
        pinentryPackage = pkgs.pinentry-gnome3;  # or pkgs.pinentry-curses
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

        desktopManager = {
            xfce.enable = false;
        };

	videoDrivers = ["nvidia"];
    };
    services.displayManager.defaultSession = "xfce";

    environment.sessionVariables = {
        C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
        CPLUS_INCLUDE_PATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.cc.version}:${pkgs.glibc.dev}/include";
        LIBRARY_PATH = "${pkgs.glibc}/lib:${pkgs.gcc.cc.lib}/lib";
        CPATH = "${pkgs.glibc.dev}/include";
    };

    xdg.mime = {
        enable = true;
        defaultApplications = {
            "image/png" = "feh.desktop";
            "image/jpeg" = "feh.desktop";
            "image/jpg" = "feh.desktop";
            "image/gif" = "feh.desktop";
            "image/webp" = "feh.desktop";
            "image/bmp" = "feh.desktop";

            "video/mp4" = "mpv.desktop";
            "video/x-matroska" = "mpv.desktop";
            "video/webm" = "mpv.desktop";
            "video/avi" = "mpv.desktop";
            "video/x-msvideo" = "mpv.desktop";
            "video/quicktime" = "mpv.desktop";

            "text/plain" = "emacs.desktop";
            "text/x-csrc" = "emacs.desktop";
            "text/x-c++src" = "emacs.desktop";
            "text/x-python" = "emacs.desktop";
            "text/markdown" = "emacs.desktop";
            "application/x-shellscript" = "emacs.desktop";
        };
    };

    services.printing.enable = true;
    services.xserver = {
        enable = true;	
        windowManager.i3.enable = false;
    };

    services.displayManager.ly.enable = true;

    services.emacs = {
        enable = true;
        package = pkgs.emacs;
    };

    programs.hyprland = {
        enable = true;
        #withUWSM = true;
        xwayland.enable = true;
    };

    services.upower.enable = true;

    services.desktopManager.plasma6.enable = false;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    
    # GNOME Keyring configuration for Dolphin SMB authentication
    services.gnome.gnome-keyring.enable = false;
    security.pam.services.login.enableGnomeKeyring = false;
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
        description = "John";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };

    programs.dconf.enable = true;
    programs.firefox.enable = true;
    programs.zsh.enable = true;
    programs.neovim.defaultEditor = true;
    nixpkgs.config.allowUnfree = true;
    programs.thunar.enable = true;

    programs.spicetify =
    let
        spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
            adblock
            hidePodcasts
            shuffle # shuffle+ (special characters are sanitized out of extension names)
        ];
        enabledCustomApps = with spicePkgs.apps; [
            newReleases
            ncsVisualizer
        ];
        enabledSnippets = with spicePkgs.snippets; [
            rotatingCoverart
            pointer
        ];
    };

    programs.nix-ld.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    services.gvfs.enable = true;
    #services.openssh.enable = true;
    system.stateVersion = "25.05";
}
