{ config, pkgs, zen-browser, ... }:

{
    imports =
    [
        ./hardware-configuration.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";

    networking.networkmanager.enable = true;

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

    services.xserver.xkb = {
        layout = "au";
        variant = "";
    };

    environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        SUDO_EDITOR = "nvim";
    };

    environment.sessionVariables = {
        C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
        CPLUS_INCLUDE_PATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.cc.version}:${pkgs.glibc.dev}/include";
        LIBRARY_PATH = "${pkgs.glibc}/lib:${pkgs.gcc.cc.lib}/lib";
        CPATH = "${pkgs.glibc.dev}/include";
    };

    services.printing.enable = true;
    services.xserver = {
        enable = true;	
        windowManager.i3.enable = false;
    };

    services.displayManager.ly.enable = true;

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            intel-media-driver
                intel-vaapi-driver
                vaapiVdpau
                libvdpau-va-gl
        ];
    };
    services.upower.enable = true;

    services.desktopManager.plasma6.enable = false;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
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

    environment.systemPackages = with pkgs; [
        git
        curl
vim
neovim
        wget
        keepassxc
        networkmanagerapplet
        xclip
        btop
        zsh
        kdePackages.kmines
        qalculate-qt
        epiphany
        cmake
        unzip
        gcc
        clang
        clang-tools
        glibc
        steam
        zsh
        termdown
        zen-browser.packages."${system}".beta
        openjdk21
        openjdk17
        openjdk8
        modrinth-app
        oh-my-zsh
        cmus
        ungoogled-chromium
        yt-dlp
        firefox
        eza
        gnome-keyring
        seahorse
        fastfetch
        cheese
        mpv
        prismlauncher
        brave
        blanket
        emacs
        libnotify
        tmux
        texlive.combined.scheme-medium
        imagemagick
        obsidian
        flameshot
        tor
        tor-browser
        vesktop
        qutebrowser
        pulseaudio
        kdePackages.dolphin
        ffmpeg
        nnn
        zathura
        feh
        dmenu
        cargo
        xorg.xinput
        acpi
        sysstat
        lm_sensors
        brightnessctl
        pamixer
        iw
        alarm-clock-applet
        coreutils
        pavucontrol
        kitty

        ripgrep
        fd
        python3
        python3Packages.pynvim
        nodejs
        nodePackages.npm
        luarocks
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.iosevka
        nerd-fonts.jetbrains-mono
        nerd-fonts.space-mono
        nerd-fonts.symbols-only
        noto-fonts-cjk-sans
    ];

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      glibc
      glibc.dev
      libgcc
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.openssh.enable = true;
    system.stateVersion = "25.05";
}

