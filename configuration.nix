{ config, pkgs, ... }:

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

    services.printing.enable = true;
    services.xserver = {
        enable = true;	
        windowManager.i3.enable = false;
    };

    services.displayManager.ly.enable = true;

    programs.hyprland.enable = true;

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

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
    };

    users.users.mvayk = {
        isNormalUser = true;
        description = "John";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
            addons = with pkgs; [
                fcitx5-mozc
                fcitx5-gtk
            ];
            waylandFrontend = true;
        };
    };

    environment.sessionVariables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
    };

    programs.neovim.enable = true;
    programs.dconf.enable = true;
    programs.firefox.enable = true;
    programs.zsh.enable = true;
    programs.neovim.defaultEditor = true;
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        git
        neovim
        curl
        wget
        keepassxc
        networkmanagerapplet
        xclip
        zsh
        kdePackages.kmines
        qalculate-qt
        cmake
        unzip
        gcc
        steam
        zsh
        termdown
        openjdk21
        openjdk17
        openjdk8
        modrinth-app
        oh-my-zsh
        cmus
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
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.iosevka
        nerd-fonts.jetbrains-mono
        nerd-fonts.space-mono
        nerd-fonts.symbols-only
        noto-fonts-cjk-sans
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.openssh.enable = true;
    system.stateVersion = "25.05";
}
